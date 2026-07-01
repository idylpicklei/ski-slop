import { Agent } from "agents";
import type { AgentEnv } from "./types";
import { normalizeResortWithAi } from "./tools/ai";
import {
  finishAgentRun,
  getRegion,
  markRegionStatus,
  startAgentRun,
  upsertResort,
} from "./tools/d1";
import { fetchSkiResortsFromOsm, isLikelySkiResort } from "./tools/osm";

interface ResortAgentState {
  regionId: number | null;
  lastRunAt: string | null;
  itemsProcessed: number;
}

export class ResortEnrichmentAgent extends Agent<AgentEnv, ResortAgentState> {
  initialState: ResortAgentState = {
    regionId: null,
    lastRunAt: null,
    itemsProcessed: 0,
  };

  async enrichRegion(regionId: number): Promise<{ upserted: number }> {
    const region = await getRegion(this.env.DB, regionId);
    if (!region) {
      throw new Error(`Region ${regionId} not found`);
    }

    const runId = await startAgentRun(this.env.DB, "resort", regionId);
    await markRegionStatus(this.env.DB, regionId, "in_progress");

    let upserted = 0;
    try {
      const elements = await fetchSkiResortsFromOsm(
        region.slug,
        region.center_lat,
        region.center_lng,
      );

      const seen = new Set<string>();
      for (const el of elements) {
        if (!isLikelySkiResort(el)) continue;
        const normalized = await normalizeResortWithAi(
          this.env,
          el,
          region.name,
        );
        if (!normalized || seen.has(normalized.slug)) continue;
        seen.add(normalized.slug);

        await upsertResort(
          this.env.DB,
          regionId,
          normalized,
          JSON.stringify(el),
        );
        upserted++;
      }

      await markRegionStatus(this.env.DB, regionId, "done");
      await finishAgentRun(this.env.DB, runId, "succeeded", upserted);

      this.setState({
        regionId,
        lastRunAt: new Date().toISOString(),
        itemsProcessed: upserted,
      });

      await this.env.ENRICHMENT_QUEUE.send({
        type: "rental",
        regionId,
      });

      return { upserted };
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      await markRegionStatus(this.env.DB, regionId, "failed");
      await finishAgentRun(this.env.DB, runId, "failed", upserted, message);
      throw err;
    }
  }

  async onRequest(request: Request): Promise<Response> {
    if (request.method !== "POST") {
      return new Response("Method not allowed", { status: 405 });
    }

    const body = (await request.json()) as { regionId?: number };
    if (!body.regionId) {
      return Response.json({ error: "regionId required" }, { status: 400 });
    }

    const result = await this.enrichRegion(body.regionId);
    return Response.json({ ok: true, ...result });
  }
}

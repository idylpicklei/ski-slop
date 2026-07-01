import { Agent } from "agents";
import type { AgentEnv } from "./types";
import { normalizeRentalWithAi } from "./tools/ai";
import {
  finishAgentRun,
  findNearestResortId,
  getRegion,
  startAgentRun,
  upsertRental,
} from "./tools/d1";
import { fetchSkiRentalsFromOsm } from "./tools/osm";

interface RentalAgentState {
  regionId: number | null;
  lastRunAt: string | null;
  itemsProcessed: number;
}

export class RentalEnrichmentAgent extends Agent<AgentEnv, RentalAgentState> {
  initialState: RentalAgentState = {
    regionId: null,
    lastRunAt: null,
    itemsProcessed: 0,
  };

  async enrichRegion(regionId: number): Promise<{ upserted: number }> {
    const region = await getRegion(this.env.DB, regionId);
    if (!region) {
      throw new Error(`Region ${regionId} not found`);
    }

    const runId = await startAgentRun(this.env.DB, "rental", regionId);

    let upserted = 0;
    try {
      const elements = await fetchSkiRentalsFromOsm(
        region.slug,
        region.center_lat,
        region.center_lng,
      );

      const seen = new Set<string>();
      for (const el of elements) {
        const normalized = await normalizeRentalWithAi(
          this.env,
          el,
          region.name,
        );
        if (!normalized || seen.has(normalized.slug)) continue;
        seen.add(normalized.slug);

        const nearestResortId = await findNearestResortId(
          this.env.DB,
          normalized.lat,
          normalized.lng,
          regionId,
        );

        await upsertRental(
          this.env.DB,
          regionId,
          normalized,
          nearestResortId,
          JSON.stringify(el),
        );
        upserted++;
      }

      await finishAgentRun(this.env.DB, runId, "succeeded", upserted);

      this.setState({
        regionId,
        lastRunAt: new Date().toISOString(),
        itemsProcessed: upserted,
      });

      return { upserted };
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
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

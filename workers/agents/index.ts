import { routeAgentRequest } from "agents";
import { RentalEnrichmentAgent } from "./rental-agent";
import { ResortEnrichmentAgent } from "./resort-agent";
import type { AgentEnv, EnrichmentMessage } from "./types";
import { getPendingRegions, finishAgentRun, startAgentRun } from "./tools/d1";

async function dispatchToAgent(
  env: AgentEnv,
  type: "resort" | "rental",
  regionId: number,
): Promise<Response> {
  const namespace =
    type === "resort" ? env.RESORT_AGENT : env.RENTAL_AGENT;
  const className =
    type === "resort" ? "ResortEnrichmentAgent" : "RentalEnrichmentAgent";
  const id = namespace.idFromName(`${className}-region-${regionId}`);
  const stub = namespace.get(id);
  return stub.fetch(
    new Request("https://agent/enrich", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ regionId }),
    }),
  );
}

async function handleDealScan(env: AgentEnv, regionId: number): Promise<void> {
  const runId = await startAgentRun(env.DB, "deal", regionId);
  await finishAgentRun(
    env.DB,
    runId,
    "failed",
    0,
    "DealScannerAgent not implemented yet — see docs/deal-scanner-agent.md",
  );
}

export default {
  async fetch(request: Request, env: AgentEnv): Promise<Response> {
    const url = new URL(request.url);

    if (url.pathname === "/enqueue" && request.method === "POST") {
      const body = (await request.json()) as {
        regionId?: number;
        type?: "resort" | "rental" | "both" | "deal";
      };

      if (!body.regionId) {
        return Response.json({ error: "regionId required" }, { status: 400 });
      }

      const type = body.type ?? "both";
      if (type === "deal") {
        await env.ENRICHMENT_QUEUE.send({
          type: "deal",
          regionId: body.regionId,
        });
      } else if (type === "rental") {
        await env.ENRICHMENT_QUEUE.send({
          type: "rental",
          regionId: body.regionId,
        });
      } else {
        await env.ENRICHMENT_QUEUE.send({
          type: "resort",
          regionId: body.regionId,
        });
      }

      return Response.json({ queued: true, regionId: body.regionId, type });
    }

    if (url.pathname === "/health") {
      return Response.json({ status: "ok", service: "ski-slop-agents" });
    }

    return (
      (await routeAgentRequest(request, env)) ??
      new Response("Not found", { status: 404 })
    );
  },

  async queue(
    batch: MessageBatch<EnrichmentMessage>,
    env: AgentEnv,
  ): Promise<void> {
    for (const message of batch.messages) {
      const { type, regionId } = message.body;
      try {
        if (type === "deal") {
          await handleDealScan(env, regionId);
        } else {
          await dispatchToAgent(env, type, regionId);
        }
        message.ack();
      } catch (err) {
        console.error(`Queue processing failed for region ${regionId}:`, err);
        message.retry();
      }
    }
  },

  async scheduled(_event: ScheduledEvent, env: AgentEnv): Promise<void> {
    const regions = await getPendingRegions(env.DB, 3);
    for (const region of regions) {
      await env.ENRICHMENT_QUEUE.send({
        type: "resort",
        regionId: region.id,
      });
    }
  },
};

export { ResortEnrichmentAgent, RentalEnrichmentAgent };

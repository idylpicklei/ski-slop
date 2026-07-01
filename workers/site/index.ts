import pagesWorker from "../../dist/_worker.js/index.js";
import agentHandlers from "../agents/index.js";
import { RentalEnrichmentAgent } from "../agents/rental-agent.js";
import { ResortEnrichmentAgent } from "../agents/resort-agent.js";

interface CombinedEnv {
  DB: D1Database;
  AI: Ai;
  ENRICHMENT_QUEUE: Queue;
  RESORT_AGENT: DurableObjectNamespace;
  RENTAL_AGENT: DurableObjectNamespace;
  ASSETS: Fetcher;
  ADMIN_TOKEN?: string;
}

const pages = pagesWorker as {
  fetch: (
    request: Request,
    env: CombinedEnv,
    ctx: ExecutionContext,
  ) => Response | Promise<Response>;
};

export default {
  fetch(request: Request, env: CombinedEnv, ctx: ExecutionContext) {
    return pages.fetch(request, env, ctx);
  },
  queue: agentHandlers.queue,
  scheduled: agentHandlers.scheduled,
};

export { ResortEnrichmentAgent, RentalEnrichmentAgent };

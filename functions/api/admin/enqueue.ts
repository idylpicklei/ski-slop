import { errorResponse, jsonResponse } from "../../../shared/utils";

export const onRequestPost: PagesFunction<Env> = async ({
  env,
  request,
}) => {
  const token = request.headers.get("Authorization")?.replace("Bearer ", "");
  if (!env.ADMIN_TOKEN || token !== env.ADMIN_TOKEN) {
    return errorResponse("Unauthorized", 401);
  }
  if (!env.ENRICHMENT_QUEUE) {
    return errorResponse("Enrichment queue not configured", 503);
  }

  const body = (await request.json()) as {
    regionSlug?: string;
    type?: "resort" | "rental" | "both" | "deal";
  };

  if (!body.regionSlug) {
    return errorResponse("regionSlug is required", 400);
  }

  const region = await env.DB.prepare(
    "SELECT id, slug FROM regions WHERE slug = ?",
  )
    .bind(body.regionSlug)
    .first<{ id: number; slug: string }>();

  if (!region) {
    return errorResponse("Region not found", 404);
  }

  const type = body.type ?? "both";
  if (type === "deal") {
    await env.ENRICHMENT_QUEUE.send({
      type: "deal",
      regionId: region.id,
    });
  } else if (type === "rental") {
    await env.ENRICHMENT_QUEUE.send({
      type: "rental",
      regionId: region.id,
    });
  } else {
    await env.ENRICHMENT_QUEUE.send({
      type: "resort",
      regionId: region.id,
    });
  }

  return jsonResponse({ queued: true, regionId: region.id, type });
};

export const onRequestOptions: PagesFunction = async () => {
  return new Response(null, {
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
    },
  });
};

import { errorResponse, jsonResponse } from "../../../shared/utils";

export const onRequestPost: PagesFunction<Env> = async ({
  env,
  request,
}) => {
  const token = request.headers.get("Authorization")?.replace("Bearer ", "");
  if (!env.ADMIN_TOKEN || token !== env.ADMIN_TOKEN) {
    return errorResponse("Unauthorized", 401);
  }
  if (!env.AGENTS) {
    return errorResponse("Agent service not configured", 503);
  }

  const body = (await request.json()) as {
    regionSlug?: string;
    type?: "resort" | "rental" | "both";
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
  const agentResponse = await env.AGENTS.fetch(
    new Request("https://agents/enqueue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ regionId: region.id, type }),
    }),
  );

  const result = await agentResponse.json();
  return jsonResponse(result, { status: agentResponse.status });
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

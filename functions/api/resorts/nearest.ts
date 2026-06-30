import {
  NEAREST_RESORTS_SQL,
  errorResponse,
  jsonResponse,
  parseNumber,
} from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const url = new URL(request.url);
  const lat = parseNumber(url.searchParams.get("lat"), NaN);
  const lng = parseNumber(url.searchParams.get("lng"), NaN);
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 10), 25);

  if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
    return errorResponse("lat and lng query parameters are required", 400);
  }
  if (lat < -90 || lat > 90 || lng < -180 || lng > 180) {
    return errorResponse("Invalid coordinates", 400);
  }

  const { results } = await env.DB.prepare(NEAREST_RESORTS_SQL)
    .bind(lat, lng, limit)
    .all();

  return jsonResponse({ lat, lng, resorts: results });
};

export const onRequestOptions: PagesFunction = async () => {
  return new Response(null, {
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
    },
  });
};

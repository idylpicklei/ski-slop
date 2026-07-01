import {
  buildNearestRentalsSql,
  errorResponse,
  jsonResponse,
  parseNumber,
  parseRentalSortMode,
} from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const url = new URL(request.url);
  const lat = parseNumber(url.searchParams.get("lat"), NaN);
  const lng = parseNumber(url.searchParams.get("lng"), NaN);
  const sort = parseRentalSortMode(url.searchParams.get("sort"), "value");
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 10), 25);

  if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
    return errorResponse("lat and lng query parameters are required", 400);
  }

  const { results } = await env.DB.prepare(buildNearestRentalsSql(sort))
    .bind(lat, lng, limit)
    .all();

  return jsonResponse({ lat, lng, sort, rentals: results });
};

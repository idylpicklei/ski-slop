import {
  buildResortNearbyRentalsSql,
  errorResponse,
  jsonResponse,
  parseRentalSortMode,
} from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, params, request }) => {
  const slug = params.slug;
  if (!slug) {
    return errorResponse("Slug required", 400);
  }

  const url = new URL(request.url);
  const sort = parseRentalSortMode(url.searchParams.get("sort"), "value");
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 25), 50);

  const resort = await env.DB.prepare(`
    SELECT r.*, reg.name AS region_name, reg.slug AS region_slug
    FROM ski_resorts r
    LEFT JOIN regions reg ON reg.id = r.region_id
    WHERE r.slug = ?
  `)
    .bind(slug)
    .first();

  if (!resort) {
    return errorResponse("Resort not found", 404);
  }

  const { results: rentals } = await env.DB.prepare(buildResortNearbyRentalsSql(sort))
    .bind(
      (resort as { lat: number }).lat,
      (resort as { lng: number }).lng,
      (resort as { id: number }).id,
      (resort as { region_id: number }).region_id,
      limit,
    )
    .all();

  return jsonResponse({ resort, sort, nearby_rentals: rentals });
};

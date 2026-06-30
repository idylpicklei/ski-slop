import { errorResponse, jsonResponse } from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, params }) => {
  const slug = params.slug;
  if (!slug) {
    return errorResponse("Slug required", 400);
  }

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

  const { results: rentals } = await env.DB.prepare(`
    SELECT sr.*, (
      3958.8 * 2 * ASIN(SQRT(
        POWER(SIN((sr.lat - ?1) * PI() / 180 / 2), 2) +
        COS(?1 * PI() / 180) * COS(sr.lat * PI() / 180) *
        POWER(SIN((sr.lng - ?2) * PI() / 180 / 2), 2)
      ))
    ) AS distance_miles
    FROM ski_rentals sr
    WHERE sr.nearest_resort_id = ?3 OR sr.region_id = ?4
    ORDER BY distance_miles ASC
    LIMIT 10
  `)
    .bind(
      (resort as { lat: number }).lat,
      (resort as { lng: number }).lng,
      (resort as { id: number }).id,
      (resort as { region_id: number }).region_id,
    )
    .all();

  return jsonResponse({ resort, nearby_rentals: rentals });
};

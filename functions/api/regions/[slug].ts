import { errorResponse, jsonResponse } from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, params }) => {
  const slug = params.slug;
  if (!slug) {
    return errorResponse("Region slug required", 400);
  }

  const region = await env.DB.prepare("SELECT * FROM regions WHERE slug = ?")
    .bind(slug)
    .first();

  if (!region) {
    return errorResponse("Region not found", 404);
  }

  const resortCount = await env.DB.prepare(
    "SELECT COUNT(*) as count FROM ski_resorts WHERE region_id = ?",
  )
    .bind((region as { id: number }).id)
    .first<{ count: number }>();

  const rentalCount = await env.DB.prepare(
    "SELECT COUNT(*) as count FROM ski_rentals WHERE region_id = ?",
  )
    .bind((region as { id: number }).id)
    .first<{ count: number }>();

  const lastRun = await env.DB.prepare(
    `SELECT * FROM agent_runs WHERE region_id = ? ORDER BY started_at DESC LIMIT 1`,
  )
    .bind((region as { id: number }).id)
    .first();

  const { results: resorts } = await env.DB.prepare(`
    SELECT slug, name, source, updated_at
    FROM ski_resorts WHERE region_id = ?
    ORDER BY name ASC
  `)
    .bind((region as { id: number }).id)
    .all();

  return jsonResponse({
    region,
    resort_count: resortCount?.count ?? 0,
    rental_count: rentalCount?.count ?? 0,
    last_run: lastRun,
    resorts,
  });
};
import { haversineMiles } from "../../../shared/utils";
import type { AgentEnv, NormalizedRental, NormalizedResort, RegionRow } from "../types";

export async function startAgentRun(
  db: D1Database,
  agentType: "resort" | "rental" | "deal",
  regionId: number,
): Promise<number> {
  const result = await db
    .prepare(
      `INSERT INTO agent_runs (agent_type, region_id, status, started_at)
       VALUES (?, ?, 'started', datetime('now'))`,
    )
    .bind(agentType, regionId)
    .run();

  return result.meta.last_row_id ?? 0;
}

export async function finishAgentRun(
  db: D1Database,
  runId: number,
  status: "succeeded" | "failed",
  itemsUpserted: number,
  error?: string,
): Promise<void> {
  await db
    .prepare(
      `UPDATE agent_runs
       SET status = ?, items_upserted = ?, error = ?, finished_at = datetime('now')
       WHERE id = ?`,
    )
    .bind(status, itemsUpserted, error ?? null, runId)
    .run();
}

export async function getRegionBySlug(
  db: D1Database,
  slug: string,
): Promise<RegionRow | null> {
  return db
    .prepare("SELECT * FROM regions WHERE slug = ?")
    .bind(slug)
    .first<RegionRow>();
}

export async function resetRegionEnrichment(
  db: D1Database,
  slug: string,
): Promise<boolean> {
  const result = await db
    .prepare(
      `UPDATE regions SET enrichment_status = 'pending', last_enriched_at = NULL WHERE slug = ?`,
    )
    .bind(slug)
    .run();
  return (result.meta.changes ?? 0) > 0;
}

export async function getRegionStats(
  db: D1Database,
  slug: string,
): Promise<{
  region: RegionRow | null;
  resort_count: number;
  rental_count: number;
  last_run: Record<string, unknown> | null;
}> {
  const region = await getRegionBySlug(db, slug);
  if (!region) {
    return { region: null, resort_count: 0, rental_count: 0, last_run: null };
  }

  const resortCount = await db
    .prepare("SELECT COUNT(*) as count FROM ski_resorts WHERE region_id = ?")
    .bind(region.id)
    .first<{ count: number }>();

  const rentalCount = await db
    .prepare("SELECT COUNT(*) as count FROM ski_rentals WHERE region_id = ?")
    .bind(region.id)
    .first<{ count: number }>();

  const lastRun = await db
    .prepare(
      `SELECT * FROM agent_runs WHERE region_id = ? ORDER BY started_at DESC LIMIT 1`,
    )
    .bind(region.id)
    .first();

  return {
    region,
    resort_count: resortCount?.count ?? 0,
    rental_count: rentalCount?.count ?? 0,
    last_run: lastRun ?? null,
  };
}

export async function getRegion(
  db: D1Database,
  regionId: number,
): Promise<RegionRow | null> {
  return db
    .prepare("SELECT * FROM regions WHERE id = ?")
    .bind(regionId)
    .first<RegionRow>();
}

export async function markRegionStatus(
  db: D1Database,
  regionId: number,
  status: string,
): Promise<void> {
  await db
    .prepare(
      `UPDATE regions SET enrichment_status = ?, last_enriched_at = datetime('now') WHERE id = ?`,
    )
    .bind(status, regionId)
    .run();
}

export async function upsertResort(
  db: D1Database,
  regionId: number,
  resort: NormalizedResort,
  rawJson: string,
): Promise<void> {
  await db
    .prepare(
      `INSERT INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary, raw_json, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'osm', ?, ?, datetime('now'))
       ON CONFLICT(slug) DO UPDATE SET
         name = excluded.name,
         lat = excluded.lat,
         lng = excluded.lng,
         elevation_ft = COALESCE(excluded.elevation_ft, ski_resorts.elevation_ft),
         trail_count = COALESCE(excluded.trail_count, ski_resorts.trail_count),
         website = COALESCE(excluded.website, ski_resorts.website),
         summary = excluded.summary,
         raw_json = excluded.raw_json,
         updated_at = datetime('now')`,
    )
    .bind(
      resort.slug,
      resort.name,
      regionId,
      resort.lat,
      resort.lng,
      resort.elevation_ft,
      resort.trail_count,
      resort.website,
      resort.summary,
      rawJson,
    )
    .run();
}

export async function findNearestResortId(
  db: D1Database,
  lat: number,
  lng: number,
  regionId: number,
): Promise<number | null> {
  const { results } = await db
    .prepare(
      `SELECT id, lat, lng FROM ski_resorts WHERE region_id = ? LIMIT 50`,
    )
    .bind(regionId)
    .all<{ id: number; lat: number; lng: number }>();

  if (!results.length) return null;

  let nearest = results[0];
  let minDist = haversineMiles(lat, lng, nearest.lat, nearest.lng);

  for (const resort of results.slice(1)) {
    const dist = haversineMiles(lat, lng, resort.lat, resort.lng);
    if (dist < minDist) {
      minDist = dist;
      nearest = resort;
    }
  }

  return nearest.id;
}

export async function upsertRental(
  db: D1Database,
  regionId: number,
  rental: NormalizedRental,
  nearestResortId: number | null,
  rawJson: string,
): Promise<void> {
  await db
    .prepare(
      `INSERT INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, source, summary, raw_json, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'osm', ?, ?, datetime('now'))
       ON CONFLICT(slug) DO UPDATE SET
         name = excluded.name,
         nearest_resort_id = COALESCE(excluded.nearest_resort_id, ski_rentals.nearest_resort_id),
         lat = excluded.lat,
         lng = excluded.lng,
         address = COALESCE(excluded.address, ski_rentals.address),
         phone = COALESCE(excluded.phone, ski_rentals.phone),
         website = COALESCE(excluded.website, ski_rentals.website),
         summary = excluded.summary,
         raw_json = excluded.raw_json,
         updated_at = datetime('now')`,
    )
    .bind(
      rental.slug,
      rental.name,
      regionId,
      nearestResortId,
      rental.lat,
      rental.lng,
      rental.address,
      rental.phone,
      rental.website,
      rental.summary,
      rawJson,
    )
    .run();
}

export async function getPendingRegions(db: D1Database, limit = 3): Promise<RegionRow[]> {
  const { results } = await db
    .prepare(
      `SELECT * FROM regions
       WHERE enrichment_status IN ('pending', 'failed')
          OR last_enriched_at IS NULL
          OR last_enriched_at < datetime('now', '-30 days')
       ORDER BY last_enriched_at ASC NULLS FIRST
       LIMIT ?`,
    )
    .bind(limit)
    .all<RegionRow>();
  return results;
}

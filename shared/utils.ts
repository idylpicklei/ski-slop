export function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export function parseNumber(value: string | null, fallback: number): number {
  if (value === null) return fallback;
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
}

export function jsonResponse(data: unknown, init: ResponseInit = {}): Response {
  return new Response(JSON.stringify(data), {
    ...init,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      ...init.headers,
    },
  });
}

export function errorResponse(message: string, status = 400): Response {
  return jsonResponse({ error: message }, { status });
}

/** Haversine distance in miles */
export function haversineMiles(
  lat1: number,
  lng1: number,
  lat2: number,
  lng2: number,
): number {
  const toRad = (deg: number) => (deg * Math.PI) / 180;
  const dLat = toRad(lat2 - lat1);
  const dLng = toRad(lng2 - lng1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLng / 2) ** 2;
  return 3958.8 * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

export const NEAREST_RESORTS_SQL = `
  SELECT
    r.*,
    reg.name AS region_name,
    reg.slug AS region_slug,
    (
      3958.8 * 2 * ASIN(SQRT(
        POWER(SIN((r.lat - ?1) * PI() / 180 / 2), 2) +
        COS(?1 * PI() / 180) * COS(r.lat * PI() / 180) *
        POWER(SIN((r.lng - ?2) * PI() / 180 / 2), 2)
      ))
    ) AS distance_miles
  FROM ski_resorts r
  LEFT JOIN regions reg ON reg.id = r.region_id
  WHERE r.lat BETWEEN ?1 - 5 AND ?1 + 5
    AND r.lng BETWEEN ?2 - 5 AND ?2 + 5
  ORDER BY distance_miles ASC
  LIMIT ?3
`;

export const NEAREST_RENTALS_SQL = `
  SELECT
    sr.*,
    reg.name AS region_name,
    res.name AS nearest_resort_name,
    (
      3958.8 * 2 * ASIN(SQRT(
        POWER(SIN((sr.lat - ?1) * PI() / 180 / 2), 2) +
        COS(?1 * PI() / 180) * COS(sr.lat * PI() / 180) *
        POWER(SIN((sr.lng - ?2) * PI() / 180 / 2), 2)
      ))
    ) AS distance_miles
  FROM ski_rentals sr
  LEFT JOIN regions reg ON reg.id = sr.region_id
  LEFT JOIN ski_resorts res ON res.id = sr.nearest_resort_id
  WHERE sr.lat BETWEEN ?1 - 5 AND ?1 + 5
    AND sr.lng BETWEEN ?2 - 5 AND ?2 + 5
  ORDER BY distance_miles ASC
  LIMIT ?3
`;

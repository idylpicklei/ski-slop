import { jsonResponse } from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const url = new URL(request.url);
  const region = url.searchParams.get("region");
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 50), 100);

  let query = `
    SELECT sr.*, reg.name AS region_name, res.name AS nearest_resort_name
    FROM ski_rentals sr
    LEFT JOIN regions reg ON reg.id = sr.region_id
    LEFT JOIN ski_resorts res ON res.id = sr.nearest_resort_id
  `;
  const params: (string | number)[] = [];

  if (region) {
    query += " WHERE reg.slug = ?";
    params.push(region);
  }
  query += " ORDER BY sr.name ASC LIMIT ?";
  params.push(limit);

  const { results } = await env.DB.prepare(query).bind(...params).all();
  return jsonResponse({ rentals: results });
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

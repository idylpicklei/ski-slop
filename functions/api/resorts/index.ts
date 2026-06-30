import { jsonResponse } from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const url = new URL(request.url);
  const region = url.searchParams.get("region");
  const q = url.searchParams.get("q");
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 50), 100);

  let query = `
    SELECT r.*, reg.name AS region_name, reg.slug AS region_slug
    FROM ski_resorts r
    LEFT JOIN regions reg ON reg.id = r.region_id
  `;
  const params: (string | number)[] = [];
  const conditions: string[] = [];

  if (region) {
    conditions.push("reg.slug = ?");
    params.push(region);
  }
  if (q) {
    conditions.push("r.name LIKE ?");
    params.push(`%${q}%`);
  }

  if (conditions.length > 0) {
    query += ` WHERE ${conditions.join(" AND ")}`;
  }
  query += " ORDER BY r.name ASC LIMIT ?";
  params.push(limit);

  const { results } = await env.DB.prepare(query).bind(...params).all();
  return jsonResponse({ resorts: results });
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

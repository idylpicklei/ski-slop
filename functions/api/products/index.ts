import { jsonResponse } from "../../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const url = new URL(request.url);
  const category = url.searchParams.get("category");
  const q = url.searchParams.get("q");
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 50), 100);

  let query = "SELECT * FROM products";
  const params: (string | number)[] = [];
  const conditions: string[] = [];

  if (category) {
    conditions.push("category = ?");
    params.push(category);
  }
  if (q) {
    conditions.push("(name LIKE ? OR brand LIKE ?)");
    params.push(`%${q}%`, `%${q}%`);
  }

  if (conditions.length > 0) {
    query += ` WHERE ${conditions.join(" AND ")}`;
  }
  query += " ORDER BY category, brand, name LIMIT ?";
  params.push(limit);

  const { results } = await env.DB.prepare(query).bind(...params).all();
  return jsonResponse({ products: results });
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

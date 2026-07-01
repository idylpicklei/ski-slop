import { renderResortHtml, type ResortPageData } from "../../shared/resort-html";
import { errorResponse } from "../../shared/utils";

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
    .first<ResortPageData>();

  if (!resort) {
    return new Response("Resort not found", { status: 404 });
  }

  return new Response(renderResortHtml(resort), {
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      "Cache-Control": "public, max-age=300",
    },
  });
};

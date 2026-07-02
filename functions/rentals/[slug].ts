import { renderRentalHtml, type RentalPageData } from "../../shared/rental-html";
import { errorResponse } from "../../shared/utils";

export const onRequestGet: PagesFunction<Env> = async ({ env, params, request }) => {
  const slug = params.slug;
  if (!slug) {
    return errorResponse("Slug required", 400);
  }

  const rental = await env.DB.prepare(`
    SELECT sr.*,
      reg.name AS region_name,
      reg.slug AS region_slug,
      res.name AS nearest_resort_name,
      res.slug AS nearest_resort_slug
    FROM ski_rentals sr
    LEFT JOIN regions reg ON reg.id = sr.region_id
    LEFT JOIN ski_resorts res ON res.id = sr.nearest_resort_id
    WHERE sr.slug = ?
  `)
    .bind(slug)
    .first<RentalPageData>();

  if (!rental) {
    return new Response("Rental shop not found", { status: 404 });
  }

  return new Response(renderRentalHtml(rental, new URL(request.url).origin), {
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      "Cache-Control": "public, max-age=300",
    },
  });
};

import { errorResponse, jsonResponse } from "../../../../../shared/utils";

export const onRequestPost: PagesFunction<Env> = async ({
  env,
  request,
  params,
}) => {
  const token = request.headers.get("Authorization")?.replace("Bearer ", "");
  if (!env.ADMIN_TOKEN || token !== env.ADMIN_TOKEN) {
    return errorResponse("Unauthorized", 401);
  }

  const slug = params.slug;
  if (!slug) {
    return errorResponse("Region slug required", 400);
  }

  const result = await env.DB.prepare(
    `UPDATE regions SET enrichment_status = 'pending', last_enriched_at = NULL WHERE slug = ?`,
  )
    .bind(slug)
    .run();

  if ((result.meta.changes ?? 0) === 0) {
    return errorResponse("Region not found", 404);
  }

  return jsonResponse({ reset: true, slug });
};

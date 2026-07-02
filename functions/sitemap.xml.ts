const STATIC_PATHS = ["/", "/resorts/", "/rentals/", "/products/", "/about/"];

export const onRequestGet: PagesFunction<Env> = async ({ env, request }) => {
  const origin = new URL(request.url).origin;

  const { results: resorts } = await env.DB.prepare(
    `SELECT slug, updated_at FROM ski_resorts ORDER BY slug`,
  ).all<{ slug: string; updated_at: string | null }>();

  const { results: rentals } = await env.DB.prepare(
    `SELECT slug, updated_at FROM ski_rentals ORDER BY slug`,
  ).all<{ slug: string; updated_at: string | null }>();

  const urls: string[] = [
    ...STATIC_PATHS.map(
      (path) => `  <url><loc>${origin}${path}</loc></url>`,
    ),
    ...(resorts ?? []).map((r) => {
      const lastmod = r.updated_at
        ? `<lastmod>${r.updated_at.slice(0, 10)}</lastmod>`
        : "";
      return `  <url><loc>${origin}/resorts/${r.slug}/</loc>${lastmod}</url>`;
    }),
    ...(rentals ?? []).map((r) => {
      const lastmod = r.updated_at
        ? `<lastmod>${r.updated_at.slice(0, 10)}</lastmod>`
        : "";
      return `  <url><loc>${origin}/rentals/${r.slug}/</loc>${lastmod}</url>`;
    }),
  ];

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.join("\n")}
</urlset>`;

  return new Response(xml, {
    headers: {
      "Content-Type": "application/xml; charset=utf-8",
      "Cache-Control": "public, max-age=3600",
    },
  });
};

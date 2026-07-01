import { escapeHtml } from "./escape-html";

export interface ResortPageData {
  slug: string;
  name: string;
  summary: string | null;
  region_name: string | null;
  region_slug: string | null;
  trail_count: number | null;
  elevation_ft: number | null;
  lat: number;
  lng: number;
  website: string | null;
  source: string | null;
}

export function renderResortHtml(resort: ResortPageData): string {
  const title = escapeHtml(resort.name);
  const summary = escapeHtml(resort.summary ?? "Ski resort in North America.");
  const region = escapeHtml(
    resort.region_name ?? resort.region_slug?.toUpperCase() ?? "",
  );
  const trails = resort.trail_count ?? "?";
  const elevation = resort.elevation_ft?.toLocaleString() ?? "?";
  const coords = `${resort.lat.toFixed(2)}°, ${resort.lng.toFixed(2)}°`;
  const website = resort.website
    ? `<p><a class="btn" href="${escapeHtml(resort.website)}" target="_blank" rel="noopener">Official website</a></p>`
    : "";
  const sourceBadge =
    resort.source === "osm"
      ? `<p class="meta">Discovered via OpenStreetMap · enriched by Ski Slop agents</p>`
      : "";

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="${summary}" />
  <title>${title} — Ski Slop</title>
  <link rel="stylesheet" href="/styles/global.css" />
</head>
<body>
  <header class="site-header">
    <div class="container">
      <a class="logo" href="/">Ski <span>Slop</span></a>
      <nav>
        <a href="/resorts/">Resorts</a>
        <a href="/idaho/">Idaho</a>
        <a href="/rentals/">Rentals</a>
        <a href="/products/">Products</a>
        <a href="/about/">About</a>
      </nav>
    </div>
  </header>
  <main>
    <section class="container detail-hero">
      <h1>${title}</h1>
      <p class="meta">${region}</p>
      ${sourceBadge}
      <p>${summary}</p>
      <div class="stats">
        <div class="stat"><strong>${trails}</strong><span>Trails</span></div>
        <div class="stat"><strong>${elevation}</strong><span>Summit (ft)</span></div>
        <div class="stat"><strong>${coords}</strong><span>Coordinates</span></div>
      </div>
      ${website}
    </section>
    <section class="container">
      <h2 class="section-title">Nearby rentals</h2>
      <div id="nearby-rentals" class="card-grid"><p class="loading">Loading nearby rentals…</p></div>
    </section>
  </main>
  <footer class="site-footer">
    <div class="container">
      <p>Ski Slop — ski hills, rentals, and gear across North America.</p>
    </div>
  </footer>
  <script>
    fetch("/api/resorts/${escapeHtml(resort.slug)}")
      .then((r) => r.json())
      .then((data) => {
        const el = document.getElementById("nearby-rentals");
        if (!el) return;
        const rentals = data.nearby_rentals ?? [];
        if (!rentals.length) {
          el.innerHTML = '<p class="empty">No rental shops listed nearby yet.</p>';
          return;
        }
        el.innerHTML = rentals.map((r) =>
          '<article class="card"><h3>' + r.name + '</h3><p class="meta">' +
          (r.address ?? '') + (r.distance_miles ? ' · ' + Number(r.distance_miles).toFixed(1) + ' mi' : '') +
          '</p><p>' + (r.summary ?? '').slice(0, 120) + '</p></article>'
        ).join('');
      })
      .catch(() => {
        const el = document.getElementById("nearby-rentals");
        if (el) el.innerHTML = '<p class="empty">Could not load rentals.</p>';
      });
  </script>
</body>
</html>`;
}

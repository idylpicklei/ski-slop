import { escapeHtml } from "./escape-html";

export interface ResortPageData {
  slug: string;
  name: string;
  summary: string | null;
  region_name: string | null;
  region_slug: string | null;
  trail_count: number | null;
  elevation_ft: number | null;
  ticket_price_usd: number | null;
  lat: number;
  lng: number;
  website: string | null;
  source: string | null;
}

function buildResortJsonLd(resort: ResortPageData, pageUrl: string): string {
  const country = resort.region_slug?.startsWith("ca-") ? "CA" : "US";
  const skiResort: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "SkiResort",
    name: resort.name,
    description:
      resort.summary ?? `${resort.name} ski resort information, lift ticket prices, and nearby rental shops.`,
    url: pageUrl,
    geo: {
      "@type": "GeoCoordinates",
      latitude: resort.lat,
      longitude: resort.lng,
    },
    address: {
      "@type": "PostalAddress",
      addressRegion: resort.region_name ?? undefined,
      addressCountry: country,
    },
  };
  if (resort.website) skiResort.sameAs = resort.website;

  const breadcrumbs = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Home", item: new URL("/", pageUrl).href },
      { "@type": "ListItem", position: 2, name: "Resorts", item: new URL("/resorts/", pageUrl).href },
      { "@type": "ListItem", position: 3, name: resort.name, item: pageUrl },
    ],
  };

  return JSON.stringify([skiResort, breadcrumbs]);
}

export function renderResortHtml(resort: ResortPageData, origin?: string): string {
  const title = escapeHtml(resort.name);
  const summary = escapeHtml(resort.summary ?? "Ski resort in North America.");
  const region = escapeHtml(
    resort.region_name ?? resort.region_slug?.toUpperCase() ?? "",
  );
  const trails = resort.trail_count ?? "?";
  const elevation = resort.elevation_ft?.toLocaleString() ?? "?";
  const coords = `${resort.lat.toFixed(2)}°, ${resort.lng.toFixed(2)}°`;
  const pageTitle = `${title} Ski Resort — Tickets, Trails & Nearby Rentals | Skier Slop`;
  const metaDescription = escapeHtml(
    `${resort.name} in ${resort.region_name ?? "North America"}: ${resort.trail_count ?? "many"} trails` +
      (resort.ticket_price_usd != null ? `, day tickets from $${resort.ticket_price_usd}` : "") +
      `. Compare nearby ski rental prices before you go. ${resort.summary ?? ""}`.slice(0, 300),
  );
  const pageUrl = origin ? `${origin}/resorts/${resort.slug}` : "";
  const canonicalTags = pageUrl
    ? `<link rel="canonical" href="${escapeHtml(pageUrl)}" />
  <meta property="og:url" content="${escapeHtml(pageUrl)}" />`
    : "";
  const jsonLd = pageUrl
    ? `<script type="application/ld+json">${buildResortJsonLd(resort, pageUrl)}</script>`
    : "";
  const priceStat =
    resort.ticket_price_usd != null
      ? `<div class="stat"><strong>$${resort.ticket_price_usd}</strong><span>Day ticket</span></div>`
      : "";
  const website = resort.website
    ? `<p><a class="btn" href="${escapeHtml(resort.website)}" target="_blank" rel="noopener">Official website</a></p>`
    : "";
  const sourceBadge =
    resort.source === "osm"
      ? `<p class="meta">Discovered via OpenStreetMap · enriched by Skier Slop agents</p>`
      : "";

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="${metaDescription}" />
  <title>${pageTitle}</title>
  ${canonicalTags}
  <meta property="og:site_name" content="Skier Slop" />
  <meta property="og:type" content="website" />
  <meta property="og:title" content="${pageTitle}" />
  <meta property="og:description" content="${metaDescription}" />
  <meta name="twitter:card" content="summary" />
  <meta name="twitter:title" content="${pageTitle}" />
  <meta name="twitter:description" content="${metaDescription}" />
  <meta name="theme-color" content="#0284c7" />
  ${jsonLd}
  <link rel="stylesheet" href="/styles/global.css" />
</head>
<body>
  <header class="site-header">
    <div class="container">
      <a class="logo" href="/">Skier <span>Slop</span></a>
      <nav>
        <a href="/resorts/">Resorts</a>
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
        ${priceStat}
        <div class="stat"><strong>${coords}</strong><span>Coordinates</span></div>
      </div>
      ${website}
    </section>
    <section class="container">
      <h2 class="section-title">Nearby resorts</h2>
      <div id="nearby-resorts" class="card-grid card-grid-compact"><p class="loading">Loading nearby resorts…</p></div>
    </section>
    <section class="container">
      <div class="section-header">
        <h2 class="section-title">Rent skis near ${title}</h2>
        <select id="rental-sort" aria-label="Sort rentals">
          <option value="value" selected>Best value</option>
          <option value="price">Cheapest</option>
          <option value="distance">Closest</option>
        </select>
      </div>
      <p class="meta">Compare daily ski rental package prices from shops around the mountain — often cheaper than renting at the base.</p>
      <div id="nearby-rentals" class="card-grid"><p class="loading">Loading nearby rentals…</p></div>
    </section>
  </main>
  <footer class="site-footer">
    <div class="container">
      <p>Skier Slop — ski hills, rentals, and gear across North America.</p>
      <p class="meta">
        <a href="/resorts/">Ski resorts</a> ·
        <a href="/rentals/">Ski rentals</a> ·
        <a href="/products/">Ski gear</a> ·
        <a href="/about/">About</a>
      </p>
    </div>
  </footer>
  <script src="/js/rental-cards.js"></script>
  <script src="/js/resort-detail.js"></script>
  <script>
    initResortDetailPage("${escapeHtml(resort.slug)}", ${resort.lat}, ${resort.lng});
  </script>
</body>
</html>`;
}

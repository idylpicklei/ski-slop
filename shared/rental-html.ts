import { escapeHtml } from "./escape-html";

export interface RentalPageData {
  slug: string;
  name: string;
  summary: string | null;
  region_name: string | null;
  region_slug: string | null;
  nearest_resort_name: string | null;
  nearest_resort_slug: string | null;
  address: string | null;
  phone: string | null;
  website: string | null;
  daily_rate_usd: number | null;
  lat: number;
  lng: number;
  source: string | null;
}

function buildRentalJsonLd(rental: RentalPageData, pageUrl: string): string {
  const localBusiness: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "SportingGoodsStore",
    name: rental.name,
    description:
      rental.summary ??
      `${rental.name} ski and snowboard rental near ${rental.nearest_resort_name ?? "North American ski country"}.`,
    url: pageUrl,
    geo: {
      "@type": "GeoCoordinates",
      latitude: rental.lat,
      longitude: rental.lng,
    },
  };
  if (rental.address) {
    localBusiness.address = {
      "@type": "PostalAddress",
      streetAddress: rental.address,
      addressCountry: rental.region_slug?.startsWith("ca-") ? "CA" : "US",
    };
  }
  if (rental.phone) localBusiness.telephone = rental.phone;
  if (rental.website) localBusiness.sameAs = rental.website;

  const breadcrumbs = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Home", item: new URL("/", pageUrl).href },
      { "@type": "ListItem", position: 2, name: "Rentals", item: new URL("/rentals/", pageUrl).href },
      { "@type": "ListItem", position: 3, name: rental.name, item: pageUrl },
    ],
  };

  return JSON.stringify([localBusiness, breadcrumbs]);
}

export function renderRentalHtml(rental: RentalPageData, origin?: string): string {
  const name = escapeHtml(rental.name);
  const summary = escapeHtml(
    rental.summary ?? "Ski and snowboard rental shop in North America.",
  );
  const region = escapeHtml(rental.region_name ?? "");
  const resortLink = rental.nearest_resort_slug
    ? `<a href="/resorts/${escapeHtml(rental.nearest_resort_slug)}/">${escapeHtml(rental.nearest_resort_name ?? "")}</a>`
    : escapeHtml(rental.nearest_resort_name ?? "");
  const address = rental.address ? escapeHtml(rental.address) : "";
  const phone = rental.phone ? escapeHtml(rental.phone) : "";
  const phoneLink = rental.phone
    ? `<a href="tel:${escapeHtml(String(rental.phone).replace(/[^+\d]/g, ""))}">${phone}</a>`
    : "";
  const coords = `${rental.lat.toFixed(4)}°, ${rental.lng.toFixed(4)}°`;
  const priceStat =
    rental.daily_rate_usd != null
      ? `<div class="stat"><strong>$${rental.daily_rate_usd}</strong><span>Adult ski package / day</span></div>`
      : "";
  const websiteBtn = rental.website
    ? `<p><a class="btn" href="${escapeHtml(rental.website)}" target="_blank" rel="noopener">Visit official site</a></p>`
    : "";
  const pageTitle = `${name} — Ski Rental${rental.nearest_resort_name ? ` near ${escapeHtml(rental.nearest_resort_name)}` : ""} | Skier Slop`;
  const metaDescription = escapeHtml(
    `${rental.name}${rental.nearest_resort_name ? ` near ${rental.nearest_resort_name}` : ""}` +
      (rental.daily_rate_usd != null ? `: adult ski packages from $${rental.daily_rate_usd}/day.` : ".") +
      ` ${rental.summary ?? ""}`.slice(0, 300),
  );
  const pageUrl = origin ? `${origin}/rentals/${rental.slug}` : "";
  const canonicalTags = pageUrl
    ? `<link rel="canonical" href="${escapeHtml(pageUrl)}" />
  <meta property="og:url" content="${escapeHtml(pageUrl)}" />`
    : "";
  const jsonLd = pageUrl
    ? `<script type="application/ld+json">${buildRentalJsonLd(rental, pageUrl)}</script>`
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
      <p class="meta"><a href="/rentals/">← All rentals</a></p>
      <h1>${name}</h1>
      <p class="meta">${region}${rental.nearest_resort_name ? ` · near ${resortLink}` : ""}</p>
      <p>${summary}</p>
      <div class="stats">
        ${priceStat}
        <div class="stat"><strong>${coords}</strong><span>Location</span></div>
      </div>
      ${address ? `<p class="meta"><strong>Address:</strong> ${address}</p>` : ""}
      ${phoneLink ? `<p class="meta"><strong>Phone:</strong> ${phoneLink}</p>` : ""}
      ${websiteBtn}
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
</body>
</html>`;
}

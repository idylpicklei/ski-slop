/** Shared rental card renderer for list views. */

function escapeHtml(text) {
  return String(text)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function renderRentalCard(r, sort) {
  const slug = escapeHtml(r.slug ?? "");
  const dist =
    r.distance_miles != null
      ? `${Number(r.distance_miles).toFixed(1)} mi`
      : "";
  const priceLine =
    r.daily_rate_usd != null
      ? `<p class="meta"><strong>$${r.daily_rate_usd}/day</strong> ski package${dist ? ` · ${dist}` : ""}</p>`
      : dist
        ? `<p class="meta">${dist}</p>`
        : "";
  const effective =
    sort === "value" && r.effective_cost != null
      ? `<p class="meta">≈ $${Math.round(r.effective_cost)} effective (incl. $2/mi travel)</p>`
      : "";
  const regionLine =
    r.region_name || r.nearest_resort_name
      ? `<p class="meta">${escapeHtml(r.region_name ?? "")}${r.nearest_resort_name ? `${r.region_name ? " · " : ""}near ${escapeHtml(r.nearest_resort_name)}` : ""}</p>`
      : "";
  const actions = [
    r.website
      ? `<a class="btn btn-small" href="${escapeHtml(r.website)}" target="_blank" rel="noopener">Official site</a>`
      : "",
    r.phone
      ? `<a class="btn btn-small btn-secondary" href="tel:${escapeHtml(String(r.phone).replace(/[^+\d]/g, ""))}">Call</a>`
      : "",
  ]
    .filter(Boolean)
    .join(" ");

  return `<article class="card card-rental">
    <a class="card-rental-link" href="/rentals/${slug}/">
      <h3>${escapeHtml(r.name)}</h3>
      ${regionLine}
      ${priceLine}
      ${effective}
      <p class="meta">${escapeHtml(r.address ?? "")}</p>
      <p>${escapeHtml((r.summary ?? "").slice(0, 120))}</p>
      <span class="card-more">View details →</span>
    </a>
    ${actions ? `<div class="card-actions">${actions}</div>` : ""}
  </article>`;
}

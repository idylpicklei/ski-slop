/** Shared client helpers for resort detail pages (static + dynamic HTML). */

function renderRentalCard(r, sort) {
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
  return `<article class="card">
    <h3>${escapeHtml(r.name)}</h3>
    ${priceLine}
    ${effective}
    <p class="meta">${escapeHtml(r.address ?? "")}</p>
    <p>${escapeHtml((r.summary ?? "").slice(0, 120))}</p>
  </article>`;
}

function escapeHtml(text) {
  return String(text)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function renderNearbyResortCard(r) {
  return `<article class="card card-compact">
    <h3><a href="/resorts/${escapeHtml(r.slug)}/">${escapeHtml(r.name)}</a></h3>
    <p class="meta">${escapeHtml(r.region_name ?? "")} · ${Number(r.distance_miles).toFixed(1)} mi</p>
  </article>`;
}

async function loadNearbyRentals(slug, sort) {
  const container = document.getElementById("nearby-rentals");
  if (!container) return;
  container.innerHTML = '<p class="loading">Loading nearby rentals…</p>';
  try {
    const res = await fetch(`/api/resorts/${encodeURIComponent(slug)}?sort=${sort}&limit=25`);
    const data = await res.json();
    const rentals = data.nearby_rentals ?? [];
    if (!rentals.length) {
      container.innerHTML =
        '<p class="empty">No rental shops listed nearby yet.</p>';
      return;
    }
    container.innerHTML = rentals.map((r) => renderRentalCard(r, sort)).join("");
  } catch {
    container.innerHTML = '<p class="empty">Could not load rentals.</p>';
  }
}

async function loadNearbyResorts(lat, lng, excludeSlug) {
  const container = document.getElementById("nearby-resorts");
  if (!container) return;
  try {
    const res = await fetch(
      `/api/resorts/nearest?lat=${lat}&lng=${lng}&limit=6`,
    );
    const data = await res.json();
    const resorts = (data.resorts ?? []).filter((r) => r.slug !== excludeSlug);
    if (!resorts.length) {
      container.innerHTML = '<p class="empty">No other resorts nearby.</p>';
      return;
    }
    container.innerHTML = resorts
      .slice(0, 5)
      .map((r) => renderNearbyResortCard(r))
      .join("");
  } catch {
    container.innerHTML = '<p class="empty">Could not load nearby resorts.</p>';
  }
}

function initResortDetailPage(slug, lat, lng) {
  const sortSelect = document.getElementById("rental-sort");
  let sort = sortSelect?.value ?? "value";

  loadNearbyRentals(slug, sort);
  loadNearbyResorts(lat, lng, slug);

  sortSelect?.addEventListener("change", () => {
    sort = sortSelect.value;
    loadNearbyRentals(slug, sort);
  });
}

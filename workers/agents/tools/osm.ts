import {
  bboxToOverpass,
  getRegionBbox,
  getRegionIso,
} from "../../../shared/region-bboxes";
import type { OsmElement } from "../types";

const OVERPASS_URL = "https://overpass-api.de/api/interpreter";

async function fetchOverpass(query: string, retries = 3): Promise<OsmElement[]> {
  for (let attempt = 0; attempt < retries; attempt++) {
    const response = await fetch(OVERPASS_URL, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: `data=${encodeURIComponent(query)}`,
    });

    if (response.status === 429 || response.status === 504) {
      const retryAfter = Number(response.headers.get("retry-after") ?? 5);
      await new Promise((r) => setTimeout(r, retryAfter * 1000 * (attempt + 1)));
      continue;
    }

    if (!response.ok) {
      throw new Error(`Overpass error: ${response.status} ${response.statusText}`);
    }

    const data = (await response.json()) as { elements?: OsmElement[] };
    return data.elements ?? [];
  }
  throw new Error("Overpass request failed after retries");
}

function skiResortSelectors(areaVar: string): string {
  return `
      node["leisure"="ski_resort"](${areaVar});
      way["leisure"="ski_resort"](${areaVar});
      relation["leisure"="ski_resort"](${areaVar});
      way["landuse"="winter_sports"](${areaVar});
      way["sport"="skiing"]["name"](${areaVar});
      node["sport"="skiing"]["name"](${areaVar});
      way["piste:type"]["name"](${areaVar});
      relation["site"="piste"]["name"](${areaVar});
  `;
}

export async function fetchSkiResortsFromOsm(
  regionSlug: string,
  centerLat: number,
  centerLng: number,
): Promise<OsmElement[]> {
  const iso = getRegionIso(regionSlug);

  if (iso) {
    const query = `
      [out:json][timeout:120];
      area["ISO3166-2"="${iso}"]->.searchArea;
      (
        ${skiResortSelectors("area.searchArea")}
      );
      out center tags;
    `;
    const results = await fetchOverpass(query);
    if (results.length > 0) return results;
  }

  const bbox = bboxToOverpass(getRegionBbox(regionSlug, centerLat, centerLng));
  const query = `
    [out:json][timeout:120];
    (
      ${skiResortSelectors(bbox)}
    );
    out center tags;
  `;
  return fetchOverpass(query);
}

export async function fetchSkiRentalsFromOsm(
  regionSlug: string,
  centerLat: number,
  centerLng: number,
): Promise<OsmElement[]> {
  const iso = getRegionIso(regionSlug);
  const query = iso
    ? `
      [out:json][timeout:90];
      area["ISO3166-2"="${iso}"]->.searchArea;
      (
        ${rentalSelectors("area.searchArea")}
      );
      out center tags;
    `
    : `
      [out:json][timeout:90];
      (
        ${rentalSelectors(bboxToOverpass(getRegionBbox(regionSlug, centerLat, centerLng, 1.5)))}
      );
      out center tags;
    `;
  return fetchOverpass(query);
}

function rentalSelectors(areaVar: string): string {
  return `
      node["shop"="sports"]["name"~"ski|snowboard|rental",i](${areaVar});
      node["shop"="rental"]["name"~"ski|snowboard",i](${areaVar});
      way["shop"="sports"]["name"~"ski|snowboard|rental",i](${areaVar});
  `;
}

export function osmElementCoords(el: OsmElement): { lat: number; lng: number } | null {
  if (el.lat !== undefined && el.lon !== undefined) {
    return { lat: el.lat, lng: el.lon };
  }
  if (el.center) {
    return { lat: el.center.lat, lng: el.center.lon };
  }
  return null;
}

export function osmElementName(el: OsmElement): string | null {
  return el.tags?.name ?? el.tags?.["name:en"] ?? null;
}

/** Skip OSM elements that are clearly not public ski hills */
export function isLikelySkiResort(el: OsmElement): boolean {
  const name = osmElementName(el);
  if (!name) return false;
  const tags = el.tags ?? {};
  if (tags.leisure === "ski_resort") return true;
  if (tags.landuse === "winter_sports") return true;
  if (tags.sport === "skiing") return true;
  if (tags.site === "piste") return true;
  if (tags["piste:type"]) return Boolean(name);
  const lower = name.toLowerCase();
  if (lower.includes("ski") || lower.includes("snow") || lower.includes("mountain")) {
    return true;
  }
  return false;
}

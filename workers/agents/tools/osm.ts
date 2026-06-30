import type { OsmElement } from "../types";

const OVERPASS_URL = "https://overpass-api.de/api/interpreter";

function regionBbox(lat: number, lng: number, delta = 2.5): string {
  const south = lat - delta;
  const north = lat + delta;
  const west = lng - delta;
  const east = lng + delta;
  return `${south},${west},${north},${east}`;
}

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

export async function fetchSkiResortsFromOsm(
  centerLat: number,
  centerLng: number,
): Promise<OsmElement[]> {
  const bbox = regionBbox(centerLat, centerLng);
  const query = `
    [out:json][timeout:60];
    (
      node["leisure"="ski_resort"](${bbox});
      way["leisure"="ski_resort"](${bbox});
      node["sport"="skiing"]["name"](${bbox});
      way["sport"="skiing"]["name"](${bbox});
    );
    out center tags;
  `;
  return fetchOverpass(query);
}

export async function fetchSkiRentalsFromOsm(
  centerLat: number,
  centerLng: number,
): Promise<OsmElement[]> {
  const bbox = regionBbox(centerLat, centerLng, 1.5);
  const query = `
    [out:json][timeout:60];
    (
      node["shop"="sports"]["name"~"ski|snowboard|rental",i](${bbox});
      node["shop"="rental"]["name"~"ski|snowboard",i](${bbox});
      way["shop"="sports"]["name"~"ski|snowboard|rental",i](${bbox});
    );
    out center tags;
  `;
  return fetchOverpass(query);
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

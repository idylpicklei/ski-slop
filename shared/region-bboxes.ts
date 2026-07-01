export interface RegionBbox {
  south: number;
  west: number;
  north: number;
  east: number;
}

/** ISO 3166-2 codes for US states / CA provinces — used for precise Overpass area queries */
export const REGION_ISO: Record<string, string> = {
  "us-id": "US-ID",
  "us-co": "US-CO",
  "us-ut": "US-UT",
  "us-wy": "US-WY",
  "us-mt": "US-MT",
  "us-ca": "US-CA",
  "us-vt": "US-VT",
  "us-nh": "US-NH",
  "us-me": "US-ME",
  "us-ny": "US-NY",
  "us-wa": "US-WA",
  "us-or": "US-OR",
  "us-nm": "US-NM",
  "ca-bc": "CA-BC",
  "ca-ab": "CA-AB",
  "ca-qc": "CA-QC",
};

/** Fallback bounding boxes when area query is unavailable */
export const REGION_BBOX: Record<string, RegionBbox> = {
  "us-id": { south: 42.0, west: -117.2, north: 49.0, east: -111.0 },
  "us-co": { south: 37.0, west: -109.1, north: 41.0, east: -102.0 },
  "us-ut": { south: 37.0, west: -114.1, north: 42.0, east: -109.0 },
  "us-ca": { south: 35.5, west: -124.5, north: 42.0, east: -118.0 },
  "us-mt": { south: 44.0, west: -116.1, north: 49.0, east: -104.0 },
  "us-wy": { south: 41.0, west: -111.1, north: 45.0, east: -104.0 },
};

export function getRegionIso(slug: string): string | null {
  return REGION_ISO[slug] ?? null;
}

export function getRegionBbox(
  slug: string,
  centerLat: number,
  centerLng: number,
  delta = 2.5,
): RegionBbox {
  const preset = REGION_BBOX[slug];
  if (preset) return preset;
  return {
    south: centerLat - delta,
    west: centerLng - delta,
    north: centerLat + delta,
    east: centerLng + delta,
  };
}

export function bboxToOverpass(bbox: RegionBbox): string {
  return `${bbox.south},${bbox.west},${bbox.north},${bbox.east}`;
}

export interface AgentEnv {
  DB: D1Database;
  AI: Ai;
  ENRICHMENT_QUEUE: Queue<EnrichmentMessage>;
  RESORT_AGENT: DurableObjectNamespace;
  RENTAL_AGENT: DurableObjectNamespace;
  ADMIN_TOKEN?: string;
}

export interface EnrichmentMessage {
  type: "resort" | "rental";
  regionId: number;
}

export interface RegionRow {
  id: number;
  slug: string;
  name: string;
  country: string;
  center_lat: number;
  center_lng: number;
}

export interface OsmElement {
  type: string;
  id: number;
  lat?: number;
  lon?: number;
  center?: { lat: number; lon: number };
  tags?: Record<string, string>;
}

export interface NormalizedResort {
  name: string;
  slug: string;
  lat: number;
  lng: number;
  elevation_ft: number | null;
  trail_count: number | null;
  website: string | null;
  summary: string;
}

export interface NormalizedRental {
  name: string;
  slug: string;
  lat: number;
  lng: number;
  address: string | null;
  phone: string | null;
  website: string | null;
  summary: string;
}

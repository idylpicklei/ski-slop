-- Geographic anchors for agent work queues
CREATE TABLE IF NOT EXISTS regions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  country TEXT NOT NULL,
  center_lat REAL,
  center_lng REAL,
  enrichment_status TEXT DEFAULT 'pending',
  last_enriched_at TEXT
);

CREATE TABLE IF NOT EXISTS ski_resorts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  lat REAL NOT NULL,
  lng REAL NOT NULL,
  elevation_ft INTEGER,
  trail_count INTEGER,
  website TEXT,
  source TEXT,
  summary TEXT,
  raw_json TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ski_rentals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  nearest_resort_id INTEGER REFERENCES ski_resorts(id),
  lat REAL NOT NULL,
  lng REAL NOT NULL,
  address TEXT,
  phone TEXT,
  website TEXT,
  source TEXT,
  summary TEXT,
  raw_json TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  category TEXT NOT NULL,
  brand TEXT,
  name TEXT NOT NULL,
  description TEXT,
  specs_json TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS agent_runs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  agent_type TEXT NOT NULL,
  region_id INTEGER,
  status TEXT,
  items_upserted INTEGER DEFAULT 0,
  error TEXT,
  started_at TEXT,
  finished_at TEXT
);

CREATE INDEX IF NOT EXISTS idx_resorts_lat_lng ON ski_resorts(lat, lng);
CREATE INDEX IF NOT EXISTS idx_rentals_lat_lng ON ski_rentals(lat, lng);
CREATE INDEX IF NOT EXISTS idx_regions_status ON regions(enrichment_status);

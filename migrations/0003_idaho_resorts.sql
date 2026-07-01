-- Additional Idaho ski resorts (manual seed; agent fills gaps from OSM)
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'schweitzer', 'Schweitzer Mountain', id, 48.5136, -116.622, 6400, 92, 'https://www.schweitzer.com', 'manual',
  'North Idaho''s largest ski area with views of three states, Lake Pend Oreille, and Canada.'
FROM regions WHERE slug = 'us-id';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'bogus-basin', 'Bogus Basin', id, 43.764, -116.102, 7580, 107, 'https://www.bogusbasin.org', 'manual',
  'Boise''s local ski hill with night skiing and affordable access from the Treasure Valley.'
FROM regions WHERE slug = 'us-id';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'brundage', 'Brundage Mountain', id, 45.006, -116.152, 8001, 53, 'https://www.brundage.com', 'manual',
  'McCall favorite known for light powder, glades, and a relaxed Idaho vibe.'
FROM regions WHERE slug = 'us-id';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'pebble-creek', 'Pebble Creek', id, 42.778, -112.157, 9200, 54, 'https://www.pebblecreekski.com', 'manual',
  'Steep terrain above Pocatello with deep snow and minimal crowds.'
FROM regions WHERE slug = 'us-id';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'kelly-canyon', 'Kelly Canyon', id, 43.642, -111.358, 6600, 64, 'https://www.kellycanyon.com', 'manual',
  'Eastern Idaho family-friendly resort near Rexburg with night skiing.'
FROM regions WHERE slug = 'us-id';

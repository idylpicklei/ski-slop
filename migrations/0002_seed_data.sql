-- Seed North America regions (US ski states + all CA provinces)
INSERT OR IGNORE INTO regions (slug, name, country, center_lat, center_lng) VALUES
  ('us-al', 'Alabama', 'US', 32.806671, -86.79113),
  ('us-ak', 'Alaska', 'US', 61.370716, -152.404419),
  ('us-az', 'Arizona', 'US', 33.729759, -111.431221),
  ('us-ca', 'California', 'US', 36.116203, -119.681564),
  ('us-co', 'Colorado', 'US', 39.059811, -105.311104),
  ('us-ct', 'Connecticut', 'US', 41.597782, -72.755371),
  ('us-id', 'Idaho', 'US', 44.068203, -114.742041),
  ('us-me', 'Maine', 'US', 44.693947, -69.381927),
  ('us-ma', 'Massachusetts', 'US', 42.230171, -71.530106),
  ('us-mi', 'Michigan', 'US', 43.326618, -84.536095),
  ('us-mn', 'Minnesota', 'US', 45.694454, -93.900192),
  ('us-mt', 'Montana', 'US', 46.921925, -110.454353),
  ('us-nh', 'New Hampshire', 'US', 43.452492, -71.563896),
  ('us-nm', 'New Mexico', 'US', 34.840515, -106.248482),
  ('us-ny', 'New York', 'US', 42.165726, -74.948051),
  ('us-nc', 'North Carolina', 'US', 35.630066, -79.806419),
  ('us-or', 'Oregon', 'US', 44.572021, -122.070938),
  ('us-pa', 'Pennsylvania', 'US', 40.590752, -77.209755),
  ('us-ut', 'Utah', 'US', 40.150032, -111.862434),
  ('us-vt', 'Vermont', 'US', 44.045876, -72.710686),
  ('us-wa', 'Washington', 'US', 47.400902, -121.490494),
  ('us-wv', 'West Virginia', 'US', 38.491226, -80.954453),
  ('us-wi', 'Wisconsin', 'US', 44.268543, -89.616508),
  ('us-wy', 'Wyoming', 'US', 42.755966, -107.30249),
  ('ca-ab', 'Alberta', 'CA', 53.933271, -116.576504),
  ('ca-bc', 'British Columbia', 'CA', 53.726669, -127.647621),
  ('ca-mb', 'Manitoba', 'CA', 53.760861, -98.813876),
  ('ca-nb', 'New Brunswick', 'CA', 46.565316, -66.461916),
  ('ca-nl', 'Newfoundland and Labrador', 'CA', 53.135509, -57.660435),
  ('ca-ns', 'Nova Scotia', 'CA', 44.682611, -63.744311),
  ('ca-on', 'Ontario', 'CA', 50.000000, -85.000000),
  ('ca-qc', 'Quebec', 'CA', 52.939916, -73.549136),
  ('ca-sk', 'Saskatchewan', 'CA', 52.939916, -106.450864);

-- Seed flagship ski resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'vail', 'Vail', id, 39.6403, -106.3742, 11570, 195, 'https://www.vail.com', 'manual',
  'One of the largest ski resorts in North America, Vail spans seven legendary back bowls and groomed front-side terrain across 5,317 acres.'
FROM regions WHERE slug = 'us-co';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'aspen-snowmass', 'Aspen Snowmass', id, 39.2084, -106.949, 12510, 336, 'https://www.aspensnowmass.com', 'manual',
  'Four mountains in one destination offering diverse terrain for every ability level.'
FROM regions WHERE slug = 'us-co';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'breckenridge', 'Breckenridge', id, 39.4817, -106.0384, 12998, 187, 'https://www.breckenridge.com', 'manual',
  'Historic mining-town charm meets high-alpine skiing with five peaks and above-treeline bowls.'
FROM regions WHERE slug = 'us-co';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'telluride', 'Telluride', id, 37.9375, -107.8123, 13150, 148, 'https://www.telluride.com', 'manual',
  'Remote box canyon resort known for steep chutes and stunning San Juan Mountain scenery.'
FROM regions WHERE slug = 'us-co';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'park-city', 'Park City', id, 40.6514, -111.508, 10026, 330, 'https://www.parkcitymountain.com', 'manual',
  'The largest ski resort in the United States by acreage, minutes from Salt Lake City.'
FROM regions WHERE slug = 'us-ut';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'snowbird', 'Snowbird', id, 40.583, -111.653, 11000, 169, 'https://www.snowbird.com', 'manual',
  'Legendary Utah powder destination with steep chutes and a tram to 11,000 feet.'
FROM regions WHERE slug = 'us-ut';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'alta', 'Alta', id, 40.5884, -111.6386, 10550, 116, 'https://www.alta.com', 'manual',
  'Skier-only classic with some of the deepest snow in North America.'
FROM regions WHERE slug = 'us-ut';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'dear-valley', 'Deer Valley', id, 40.6375, -111.4783, 9570, 103, 'https://www.deervalley.com', 'manual',
  'Upscale skier-only resort famous for impeccable grooming and limited ticket sales.'
FROM regions WHERE slug = 'us-ut';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'jackson-hole', 'Jackson Hole', id, 43.5875, -110.8279, 10450, 133, 'https://www.jacksonhole.com', 'manual',
  'Expert paradise in the Tetons, famous for Corbet''s Couloir and cold-smoke powder.'
FROM regions WHERE slug = 'us-wy';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mammoth-mountain', 'Mammoth Mountain', id, 37.6308, -119.0326, 11053, 175, 'https://www.mammothmountain.com', 'manual',
  'California''s largest ski area with long seasons and expansive high-alpine terrain.'
FROM regions WHERE slug = 'us-ca';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'palisades-tahoe', 'Palisades Tahoe', id, 39.1969, -120.2358, 9050, 170, 'https://www.palisadestahoe.com', 'manual',
  'Olympic legacy resort with steep KT-22 lines and Lake Tahoe views.'
FROM regions WHERE slug = 'us-ca';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'killington', 'Killington', id, 43.6045, -72.8201, 4241, 155, 'https://www.killington.com', 'manual',
  'The Beast of the East with the longest season in the eastern United States.'
FROM regions WHERE slug = 'us-vt';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'stowe', 'Stowe', id, 44.5303, -72.7814, 4850, 116, 'https://www.stowe.com', 'manual',
  'Classic New England resort beneath Mount Mansfield with charming village atmosphere.'
FROM regions WHERE slug = 'us-vt';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'sun-valley', 'Sun Valley', id, 43.6807, -114.3626, 9150, 121, 'https://www.sunvalley.com', 'manual',
  'America''s first destination ski resort with impeccable grooming and sunny weather.'
FROM regions WHERE slug = 'us-id';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'whistler-blackcomb', 'Whistler Blackcomb', id, 50.1163, -122.9574, 7494, 200, 'https://www.whistlerblackcomb.com', 'manual',
  'North America''s largest ski resort by acreage with two connected mountains.'
FROM regions WHERE slug = 'ca-bc';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'lake-louise', 'Lake Louise', id, 51.4254, -116.1773, 8650, 164, 'https://www.skilouise.com', 'manual',
  'Banff National Park gem with turquoise lake views and wide open bowls.'
FROM regions WHERE slug = 'ca-ab';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'sunshine-village', 'Sunshine Village', id, 51.0784, -115.782, 8954, 137, 'https://www.skibanff.com', 'manual',
  'High-elevation Banff resort with Canada''s longest non-glacial season.'
FROM regions WHERE slug = 'ca-ab';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mont-tremblant', 'Mont Tremblant', id, 46.2127, -74.5844, 2871, 102, 'https://www.tremblant.ca', 'manual',
  'Québec''s premier ski destination with European-style village and night skiing.'
FROM regions WHERE slug = 'ca-qc';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'big-sky', 'Big Sky', id, 45.2618, -111.4013, 11166, 300, 'https://www.bigskyresort.com', 'manual',
  'Biggest skiing in America by vertical drop with Lone Peak Tram access.'
FROM regions WHERE slug = 'us-mt';

INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'taos', 'Taos Ski Valley', id, 36.5956, -105.4485, 12481, 110, 'https://www.skitaos.com', 'manual',
  'Authentic New Mexico ski culture with steep chutes and Southwest powder.'
FROM regions WHERE slug = 'us-nm';

-- Seed sample ski rentals near flagship resorts
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, source, summary)
SELECT 'vail-sports-rental', 'Vail Sports Rental', reg.id, res.id, 39.6431, -106.3781, 'Vail Village, CO', 'manual',
  'Full-service ski and snowboard rental in the heart of Vail Village.'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-co' AND res.slug = 'vail';

INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, source, summary)
SELECT 'park-city-ski-rental', 'Park City Ski Rental', reg.id, res.id, 40.6461, -111.498, 'Main Street, Park City, UT', 'manual',
  'Convenient downtown rental shop serving Park City Mountain and Deer Valley.'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-ut' AND res.slug = 'park-city';

INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, source, summary)
SELECT 'whistler-premier-rentals', 'Whistler Premier Rentals', reg.id, res.id, 50.1161, -122.957, 'Whistler Village, BC', 'manual',
  'Premium equipment rentals steps from Whistler and Blackcomb gondolas.'
FROM regions reg, ski_resorts res WHERE reg.slug = 'ca-bc' AND res.slug = 'whistler-blackcomb';

-- Seed product directory
INSERT OR IGNORE INTO products (slug, category, brand, name, description) VALUES
  ('rossignol-hero-elite-st', 'skis', 'Rossignol', 'Hero Elite ST', 'Frontside carving ski with race-inspired construction for precise turns on hardpack.'),
  ('salomon-qst-blank', 'skis', 'Salomon', 'QST Blank', 'Big-mountain freeride ski built for powder, steeps, and variable conditions.'),
  ('atomic-hawx-ultra-130', 'boots', 'Atomic', 'Hawx Ultra 130', 'Lightweight performance boot with customizable fit for aggressive all-mountain skiing.'),
  ('lange-lx-110', 'boots', 'Lange', 'LX 110 HV', 'High-volume fit boot designed for comfort and control on groomed runs.'),
  ('marker-griffon-13', 'bindings', 'Marker', 'Griffon 13 ID', 'Versatile alpine binding with reliable release for all-mountain use.'),
  ('look-pivot-15', 'bindings', 'Look', 'Pivot 15 GW', 'Legendary freeride binding with turntable heel piece for strong retention.'),
  ('smith-vantage-helmet', 'helmets', 'Smith', 'Vantage MIPS', 'Premium helmet with MIPS protection and adjustable ventilation.'),
  ('giro-luxe-goggles', 'goggles', 'Giro', 'Luxe', 'OTG-compatible goggle with Vivid lens technology for enhanced contrast.');

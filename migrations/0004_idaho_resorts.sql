-- Idaho ski resorts — researched, original descriptions.
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: silvermt.com/mountain/trail-map ; en.wikipedia.org/wiki/Silver_Mountain_(Idaho)
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'silver-mountain', 'Silver Mountain', id, 47.495, -116.135, 6300, 73, 'https://www.silvermt.com', 'manual',
  'Kellogg resort linked to town by a long gondola, with Bitterroot Range terrain and lit runs after dark'
FROM regions WHERE slug = 'us-id';

-- Sources: tamarackidaho.com/the-mountain ; en.wikipedia.org/wiki/Tamarack_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'tamarack', 'Tamarack Resort', id, 44.671, -116.123, 7700, 57, 'https://tamarackidaho.com', 'manual',
  'All-season resort west of Donnelly with 2,800 feet of vertical above Lake Cascade and a walkable village'
FROM regions WHERE slug = 'us-id';

-- Sources: skilookout.com/trail-map ; en.wikipedia.org/wiki/Lookout_Pass_Ski_and_Recreation_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'lookout-pass', 'Lookout Pass', id, 47.453, -115.707, 6150, 51, 'https://skilookout.com', 'manual',
  'Interstate 90 ski hill on the Idaho-Montana border, known for deep powder and budget-friendly lift tickets'
FROM regions WHERE slug = 'us-id';

-- Sources: losttrail.com/trail-map ; en.wikipedia.org/wiki/Lost_Trail_Powder_Mountain
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'lost-trail-powder-mountain', 'Lost Trail Powder Mountain', id, 45.692, -113.952, 8200, 69, 'https://losttrail.com', 'manual',
  'Family-owned Continental Divide area on Highway 93 with tree skiing and light weekday crowds'
FROM regions WHERE slug = 'us-id';

-- Sources: www.fs.usda.gov/r04/sawtooth/recreation/soldier-mountain-ski-resort ; en.wikipedia.org/wiki/Soldier_Mountain
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'soldier-mountain', 'Soldier Mountain', id, 43.485, -114.830, 7177, 36, 'https://soldiermountain.com', 'manual',
  'Camas County ski area in the Sawtooth National Forest with bowls, glades, and a Thursday-to-Sunday schedule'
FROM regions WHERE slug = 'us-id';

-- Sources: www.pomerelle.com/the-mountain ; www.pomerelle.com/conditions
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'pomerelle', 'Pomerelle Mountain Resort', id, 42.3175, -113.6082, 8762, 32, 'https://www.pomerelle.com', 'manual',
  'Albion Mountains day area near Albion with heavy snowfall, night skiing, and an early-season opening track record'
FROM regions WHERE slug = 'us-id';

-- Sources: magicmountainresort.com/trails ; magicmountainresort.com
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'magic-mountain', 'Magic Mountain', id, 42.1875, -114.2856, 7240, 22, 'https://magicmountainresort.com', 'manual',
  'Sawtooth National Forest ski hill south of Twin Falls with tubing and low-key southern Idaho terrain'
FROM regions WHERE slug = 'us-id';

-- Sources: rotarun.org ; en.wikipedia.org/wiki/Rotarun_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'rotarun', 'Rotarun', id, 43.4975, -114.366, 5895, 7, 'https://rotarun.org', 'manual',
  'Volunteer-run Hailey hill with platter-lift skiing, night sessions, and affordable Wood River Valley access'
FROM regions WHERE slug = 'us-id';

-- Sources: payettelakesskiclub.org/pages/little-ski-hill ; en.wikipedia.org/wiki/Little_Ski_Hill
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'little-ski-hill', 'Little Ski Hill', id, 44.93, -116.1631, 5600, NULL, 'https://payettelakesskiclub.org/pages/little-ski-hill', 'manual',
  'McCall community hill dating to 1937 with a T-bar, night skiing, and a terrain park for local youth programs'
FROM regions WHERE slug = 'us-id';

-- Sources: skibaldmountain.com/about-us ; en.wikipedia.org/wiki/Bald_Mountain_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'bald-mountain-pierce', 'Bald Mountain Ski Area', id, 46.57, -115.87, 4800, 15, 'https://skibaldmountain.com', 'manual',
  'Clearwater Ski Club hill near Pierce with vintage T-bar lifts, 140 acres, and weekend-only operation'
FROM regions WHERE slug = 'us-id';

-- Sources: en.wikipedia.org/wiki/Cottonwood_Butte ; cottonwoodbutte.org
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'cottonwood-butte', 'Cottonwood Butte', id, 46.0755, -116.4528, 5730, 7, 'https://cottonwoodbutte.org', 'manual',
  'Community-run Camas Prairie ski hill west of Cottonwood with surface lifts and occasional Friday night skiing'
FROM regions WHERE slug = 'us-id';

-- Sources: grangeville.us/about-snowhaven ; en.wikipedia.org/wiki/Snowhaven
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'snowhaven', 'Snowhaven', id, 45.869, -116.09, 5600, 9, 'https://grangeville.us/about-snowhaven', 'manual',
  'Grangeville city ski and tubing hill with beginner-friendly slopes and weekend operation southeast of town'
FROM regions WHERE slug = 'us-id';

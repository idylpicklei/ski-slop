-- Washington skeleton resorts (name/slug/coords/website only; elevation/trails/prices/summaries deferred).
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: https://www.crystalmountainresort.com ; https://en.wikipedia.org/wiki/Crystal_Mountain_(Washington)
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'crystal-mountain', 'Crystal Mountain', id, 46.9350, -121.4750, NULL, NULL, 'https://www.crystalmountainresort.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.stevenspass.com ; https://en.wikipedia.org/wiki/Stevens_Pass_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'stevens-pass', 'Stevens Pass', id, 47.7447, -121.0889, NULL, NULL, 'https://www.stevenspass.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.summitatsnoqualmie.com ; https://en.wikipedia.org/wiki/The_Summit_at_Snoqualmie
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'the-summit-at-snoqualmie', 'The Summit at Snoqualmie', id, 47.4240, -121.4160, NULL, NULL, 'https://www.summitatsnoqualmie.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.mtbaker.us ; https://en.wikipedia.org/wiki/Mt._Baker_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mt-baker', 'Mt. Baker Ski Area', id, 48.8620, -121.6540, NULL, NULL, 'https://www.mtbaker.us', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://skiwhitepass.com ; https://en.wikipedia.org/wiki/White_Pass_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'white-pass', 'White Pass', id, 46.6380, -121.3910, NULL, NULL, 'https://skiwhitepass.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.missionridge.com ; https://en.wikipedia.org/wiki/Mission_Ridge_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mission-ridge', 'Mission Ridge', id, 47.2920, -120.3990, NULL, NULL, 'https://www.missionridge.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.ski49n.com ; https://en.wikipedia.org/wiki/49_Degrees_North_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT '49-degrees-north', '49 Degrees North', id, 48.3010, -117.5630, NULL, NULL, 'https://www.ski49n.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.mtspokane.com ; https://en.wikipedia.org/wiki/Mount_Spokane_Ski_and_Snowboard_Park
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mount-spokane', 'Mount Spokane', id, 47.9220, -117.0970, NULL, NULL, 'https://www.mtspokane.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.bluewood.com ; https://en.wikipedia.org/wiki/Ski_Bluewood
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'ski-bluewood', 'Ski Bluewood', id, 46.0820, -117.8510, NULL, NULL, 'https://www.bluewood.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.hurricaneridge.com ; https://en.wikipedia.org/wiki/Hurricane_Ridge_Ski_and_Snowboard_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'hurricane-ridge', 'Hurricane Ridge', id, 47.9710, -123.4930, NULL, NULL, 'https://www.hurricaneridge.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://skiechovalley.com ; https://en.wikipedia.org/wiki/Echo_Valley_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'echo-valley', 'Echo Valley', id, 47.9358, -120.0561, NULL, NULL, 'https://skiechovalley.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://skitheloup.org ; https://en.wikipedia.org/wiki/Loup_Loup_Ski_Bowl
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'loup-loup', 'Loup Loup Ski Bowl', id, 48.3947, -119.9128, NULL, NULL, 'https://skitheloup.org', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://www.skibadgermt.com ; https://en.wikipedia.org/wiki/Badger_Mountain_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'badger-mountain', 'Badger Mountain', id, 47.6127, -120.1298, NULL, NULL, 'https://www.skibadgermt.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://ride-sitzmark.com ; https://en.wikipedia.org/wiki/Sitzmark_Ski_Area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'sitzmark', 'Sitzmark Ski Area', id, 48.8650, -119.1640, NULL, NULL, 'https://ride-sitzmark.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

-- Sources: https://skileavenworth.com ; https://en.wikipedia.org/wiki/Leavenworth_Ski_Hill
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'leavenworth-ski-hill', 'Leavenworth Ski Hill', id, 47.6144, -120.6686, NULL, NULL, 'https://skileavenworth.com', 'manual', NULL
FROM regions WHERE slug = 'us-wa';

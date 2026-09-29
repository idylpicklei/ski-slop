-- Oregon skeleton resorts (name/slug/coords/website only; elevation/trails/prices/summaries deferred).
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: https://www.mtbachelor.com ; https://en.wikipedia.org/wiki/Mount_Bachelor_ski_area ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mount-bachelor', 'Mount Bachelor', id, 44.0030, -121.6770, NULL, NULL, 'https://www.mtbachelor.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.timberlinelodge.com ; https://en.wikipedia.org/wiki/Timberline_Lodge_ski_area ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'timberline-lodge', 'Timberline Lodge', id, 45.3375, -121.7139, NULL, NULL, 'https://www.timberlinelodge.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.skihood.com ; https://en.wikipedia.org/wiki/Mount_Hood_Meadows ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mt-hood-meadows', 'Mt. Hood Meadows', id, 45.3289, -121.6625, NULL, NULL, 'https://www.skihood.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.skibowl.com ; https://en.wikipedia.org/wiki/Mount_Hood_Skibowl ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mt-hood-skibowl', 'Mt. Hood Skibowl', id, 45.3019, -121.7732, NULL, NULL, 'https://www.skibowl.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.cooperspur.com ; https://en.wikipedia.org/wiki/Cooper_Spur_ski_area ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'cooper-spur', 'Cooper Spur', id, 45.4123, -121.6050, NULL, NULL, 'https://www.cooperspur.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.willamettepass.ski ; https://en.wikipedia.org/wiki/Willamette_Pass_Resort ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'willamette-pass', 'Willamette Pass', id, 43.6013, -122.0365, NULL, NULL, 'https://www.willamettepass.ski', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.skihoodoo.com ; https://en.wikipedia.org/wiki/Hoodoo_(ski_area) ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'hoodoo', 'Hoodoo Ski Area', id, 44.4034, -121.8818, NULL, NULL, 'https://www.skihoodoo.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.mtashland.com ; https://en.wikipedia.org/wiki/Mount_Ashland_Ski_Area ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mt-ashland', 'Mt. Ashland', id, 42.0812, -122.7066, NULL, NULL, 'https://www.mtashland.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.warner-canyon.com ; https://en.wikipedia.org/wiki/Warner_Canyon ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'warner-canyon', 'Warner Canyon', id, 42.2328, -120.2975, NULL, NULL, 'https://www.warner-canyon.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.anthonylakes.com ; https://en.wikipedia.org/wiki/Anthony_Lakes_(ski_area) ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'anthony-lakes', 'Anthony Lakes', id, 44.9600, -118.2400, NULL, NULL, 'https://www.anthonylakes.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

-- Sources: https://www.skifergi.com ; https://en.wikipedia.org/wiki/Ferguson_Ridge_Ski_Area ; https://traveloregon.com/things-to-do/outdoor-recreation/snow-sports/ski-oregon-conditions-events/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'ferguson-ridge', 'Ferguson Ridge Ski Area', id, 45.2790, -117.1150, NULL, NULL, 'https://www.skifergi.com', 'manual', NULL
FROM regions WHERE slug = 'us-or';

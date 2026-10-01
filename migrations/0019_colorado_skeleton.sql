-- Colorado skeleton gap fill (name/slug/coords/website only; elevation/trails/prices/summaries deferred).
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: https://www.aspensnowmass.com/four-mountains ; https://en.wikipedia.org/wiki/Aspen_Mountain_(ski_area) ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'aspen-mountain', 'Aspen Mountain', id, 39.1863, -106.8182, NULL, NULL, 'https://www.aspensnowmass.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.aspensnowmass.com/four-mountains ; https://en.wikipedia.org/wiki/Aspen_Highlands ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'aspen-highlands', 'Aspen Highlands', id, 39.1811, -106.8564, NULL, NULL, 'https://www.aspensnowmass.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.aspensnowmass.com/four-mountains/buttermilk ; https://en.wikipedia.org/wiki/Buttermilk_(ski_area) ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'buttermilk', 'Buttermilk', id, 39.2050, -106.8606, NULL, NULL, 'https://www.aspensnowmass.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.gunnisonco.gov/departments/parks___recreation/cranor_ski_area.php ; https://coloradosun.com/2025/02/15/cranor-hill-cheap-family-skiing-gunnison-colorado/ ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'cranor-ski-hill', 'Cranor Ski Hill', id, 38.5849, -106.8960, NULL, NULL, 'https://www.gunnisonco.gov/departments/parks___recreation/cranor_ski_area.php', 'manual', NULL
FROM regions WHERE slug = 'us-co';

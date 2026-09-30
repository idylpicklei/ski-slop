-- Colorado skeleton resorts (name/slug/coords/website only; elevation/trails/prices/summaries deferred).
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: https://www.keystoneresort.com ; https://en.wikipedia.org/wiki/Keystone_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'keystone', 'Keystone', id, 39.6084, -105.9436, NULL, NULL, 'https://www.keystoneresort.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.beavercreek.com ; https://en.wikipedia.org/wiki/Beaver_Creek_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'beaver-creek', 'Beaver Creek', id, 39.6042, -106.5165, NULL, NULL, 'https://www.beavercreek.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.coppercolorado.com ; https://en.wikipedia.org/wiki/Copper_Mountain_(Colorado)
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'copper-mountain', 'Copper Mountain', id, 39.5022, -106.1497, NULL, NULL, 'https://www.coppercolorado.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.winterparkresort.com ; https://en.wikipedia.org/wiki/Winter_Park_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'winter-park', 'Winter Park Resort', id, 39.8868, -105.7625, NULL, NULL, 'https://www.winterparkresort.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.steamboat.com ; https://en.wikipedia.org/wiki/Steamboat_Ski_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'steamboat', 'Steamboat', id, 40.4572, -106.8045, NULL, NULL, 'https://www.steamboat.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.skicb.com ; https://en.wikipedia.org/wiki/Crested_Butte_Mountain_Resort
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'crested-butte', 'Crested Butte Mountain Resort', id, 38.8999, -106.9658, NULL, NULL, 'https://www.skicb.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.arapahoebasin.com ; https://en.wikipedia.org/wiki/Arapahoe_Basin ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'arapahoe-basin', 'Arapahoe Basin', id, 39.6425, -105.8717, NULL, NULL, 'https://www.arapahoebasin.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.skiloveland.com ; https://en.wikipedia.org/wiki/Loveland_Ski_Area ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'loveland', 'Loveland Ski Area', id, 39.6800, -105.8977, NULL, NULL, 'https://www.skiloveland.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.eldora.com ; https://en.wikipedia.org/wiki/Eldora_Mountain_Resort ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'eldora', 'Eldora Mountain Resort', id, 39.9375, -105.5827, NULL, NULL, 'https://www.eldora.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://skimonarch.com ; https://en.wikipedia.org/wiki/Monarch_Mountain_(ski_area) ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'monarch-mountain', 'Monarch Mountain', id, 38.5123, -106.3323, NULL, NULL, 'https://skimonarch.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.purgatory.ski ; https://en.wikipedia.org/wiki/Purgatory_Resort ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'purgatory', 'Purgatory Resort', id, 37.6303, -107.8367, NULL, NULL, 'https://www.purgatory.ski', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://powderhorn.com ; https://en.wikipedia.org/wiki/Powderhorn_Resort ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'powderhorn', 'Powderhorn', id, 39.0694, -108.1506, NULL, NULL, 'https://powderhorn.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://sunlightmtn.com ; https://en.wikipedia.org/wiki/Sunlight_Ski_Area ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'sunlight', 'Sunlight Mountain Resort', id, 39.3997, -107.3392, NULL, NULL, 'https://sunlightmtn.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.skicooper.com ; https://en.wikipedia.org/wiki/Ski_Cooper ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'ski-cooper', 'Ski Cooper', id, 39.3600, -106.3020, NULL, NULL, 'https://www.skicooper.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.steamboatsprings.net/131/Howelsen-Hill-Ski-Area ; https://en.wikipedia.org/wiki/Howelsen_Hill_Ski_Area ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'howelsen-hill', 'Howelsen Hill Ski Area', id, 40.4850, -106.8317, NULL, NULL, 'https://www.steamboatsprings.net/131/Howelsen-Hill-Ski-Area', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.wolfcreekski.com ; https://en.wikipedia.org/wiki/Wolf_Creek_ski_area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'wolf-creek', 'Wolf Creek Ski Area', id, 37.4722, -106.7933, NULL, NULL, 'https://www.wolfcreekski.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.silvertonmountain.com ; https://en.wikipedia.org/wiki/Silverton_Mountain ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'silverton-mountain', 'Silverton Mountain', id, 37.8845, -107.6656, NULL, NULL, 'https://www.silvertonmountain.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.echomtn.com ; https://en.wikipedia.org/wiki/Echo_Mountain_(ski_area) ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'echo-mountain', 'Echo Mountain', id, 39.6850, -105.5194, NULL, NULL, 'https://www.echomtn.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://granbyranch.com ; https://en.wikipedia.org/wiki/Granby_Ranch ; https://www.coloradoski.com/resorts/
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'granby-ranch', 'Granby Ranch', id, 40.0450, -105.9067, NULL, NULL, 'https://granbyranch.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.skikendall.com ; https://en.wikipedia.org/wiki/Kendall_Mountain_Ski_Area ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'kendall-mountain', 'Kendall Mountain', id, 37.8116, -107.6555, NULL, NULL, 'https://www.skikendall.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.durangoco.gov/544/Ski-Area ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'chapman-hill', 'Chapman Hill Ski Area', id, 37.2823, -107.8681, NULL, NULL, 'https://www.durangoco.gov/544/Ski-Area', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://skilakecity.com ; https://lakecity.com/ski-hill-and-terrain-park/ ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'lake-city-ski-hill', 'Lake City Ski Hill', id, 38.0105, -107.3137, NULL, NULL, 'https://skilakecity.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://www.uncovercolorado.com/skiing-snowboarding/lees-ski-hill/ ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'lees-ski-hill', 'Lee''s Ski Hill', id, 38.0189, -107.6689, NULL, NULL, NULL, 'manual', NULL
FROM regions WHERE slug = 'us-co';

-- Sources: https://hoedownhill.com/skiing-boarding/ ; https://hoedownhill.com/tickets/ ; https://en.wikipedia.org/wiki/List_of_Colorado_ski_resorts
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'hoedown-hill', 'Hoedown Hill', id, 40.4542, -104.9295, NULL, NULL, 'https://hoedownhill.com', 'manual', NULL
FROM regions WHERE slug = 'us-co';

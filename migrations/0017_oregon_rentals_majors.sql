-- Oregon ski rental shops for mount-bachelor, timberline-lodge, mt-hood-meadows,
-- mt-hood-skibowl, willamette-pass, hoodoo, mt-ashland, anthony-lakes.
-- Resort-outward fill, nearest base or town shop first, capped at three per resort.
-- Adult standard one-day ski package (skis+boots+poles), walk-in, whole USD, or NULL
-- where the shop publishes no fixed rate.

-- Sources: mtbachelor.com/lessons-rentals/rentals/ (26/27 standard pkg includes skis or snowboard, boots, bindings, helmet, poles; date-based checkout, no fixed adult day rate) ; OSM way 209711986 Mountain Gateway
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-bachelor-west-village-rental', 'Mt. Bachelor West Village Rental Shop', reg.id, res.id, 44.00291, -121.67924, 'Lower level, Mountain Gateway, West Village, Mt. Bachelor, OR', '541-382-1709', 'https://www.mtbachelor.com', NULL, 'manual',
  'Alpine ski and snowboard packages fitted on the lower level of Mountain Gateway at the West Village base'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mount-bachelor';

-- Sources: mtbachelor.com/lessons-rentals/rentals/ (same 26/27 date-based standard pkg; Sunrise listed as pickup base; no fixed adult day rate) ; OSM way 209711989 Sunrise Lodge
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-bachelor-sunrise-rental', 'Mt. Bachelor Sunrise Rental Shop', reg.id, res.id, 43.99216, -121.66129, 'Lower level, Sunrise Lodge, Cascade Lakes Highway, Mt. Bachelor, OR', '541-382-1709', 'https://www.mtbachelor.com', NULL, 'manual',
  'Sunrise Lodge rental counter about a mile from West Village handing out ski and snowboard day packages'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mount-bachelor';

-- Sources: villagebikeandski.com/skis-boards (Sport Ski Package full day $45 listed; page does not state boots and poles are included, poles $8 separate; rate left NULL) ; villageatsunriver.com/business/village-bike-ski/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'village-bike-and-ski', 'Village Bike & Ski', reg.id, res.id, 43.87384, -121.43714, '57100 Beaver Drive, Building 21, Suite 110, Sunriver, OR 97707', '541-593-2453', 'https://www.villagebikeandski.com', NULL, 'manual',
  'Sunriver village shop on Beaver Drive renting alpine skis and snowboards about 15 miles from West Village'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mount-bachelor';

-- Sources: timberlinelodge.com/mountain/rentals/ (Adult standard Skis, Boots & Poles all-day walk-in $65; performance $75, demo $85) ; OSM way 303644873 Wy'East Day Lodge
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'timberline-rental-shop', 'Timberline Rental Shop', reg.id, res.id, 45.33043, -121.71007, 'Wy''East Day Lodge, 27500 E Timberline Rd, Government Camp, OR 97028', '503-272-3409', 'https://www.timberlinelodge.com', 65, 'manual',
  'Walk-in rental desk on the lower level of Wy''East Day Lodge at the Timberline base with published adult packages'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'timberline-lodge';

-- Sources: skihood.com/explore/Rentals-and-Lessons/Ski-Rentals (date-priced online; no fixed adult one-day dollar amount; poles and helmet included) ; skihood.com/product/alpine-snowboard-rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-hood-meadows-rental-center', 'Mt. Hood Meadows Rental Center', reg.id, res.id, 45.33225, -121.66504, 'Sahale Lodge, 14040 Hwy 35, Mt. Hood, OR 97041', '503-337-2222', 'https://www.skihood.com', NULL, 'manual',
  'Sahale Lodge counter at the Mt. Hood Meadows base issuing Rossignol sets booked by date online'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-meadows';

-- Sources: goodwynns.com/pages/snow-rentals (Skis Basic Rental w/ Bindings, Boots, Poles $55/day) ; goodwynns.com/pages/location-hood-river
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'goodwynns-hood-river', 'Goodwynn''s Hood River', reg.id, res.id, 45.70784, -121.52429, '1235 State St Suite 200, Hood River, OR 97031', '541-436-4455', 'https://www.goodwynns.com', 55, 'manual',
  'Hood River State Street shop with a published one-day basic ski set on the Highway 35 approach to Meadows'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-meadows';

-- Sources: dougshoodriver.com/pages/rentals (Adult Complete Ski Package skis, boots, poles $40) ; traveloregon.com/things-to-do/oregon-attractions/shopping/dougs-sports/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'dougs-hood-river', 'Doug''s Hood River', reg.id, res.id, 45.70873, -121.51143, '101 Oak Street, Hood River, OR 97031', '541-386-5787', 'https://dougshoodriver.com', 40, 'manual',
  'Downtown Hood River Oak Street desk renting a complete adult ski set before the drive up Highway 35'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-meadows';

-- Sources: skibowl.com/lessons-rentals-racing/equipment-rentals/ (conflicting adult package rows $57/$49 with poles priced separately; no single skis-boots-poles figure) ; skibowl.com/mt-hood-outfitters/equipment-rentals/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'skibowl-rental-shop', 'Mt. Hood Skibowl Rental Shop', reg.id, res.id, 45.3019, -121.77344, 'Below Starlight Lodge, 87000 US Hwy 26, Government Camp, OR 97028', '503-272-3206', 'https://www.skibowl.com', NULL, 'manual',
  'Rental desk under Starlight Lodge at the Skibowl base open for day sessions and night skiing'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-skibowl';

-- Sources: valianssports.com (Adult full package $50/day: ski boots, skis, and poles; additional days $35) ; OSM way 368567710
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'valians-sports-government-camp', 'Valian''s Ski Shop', reg.id, res.id, 45.30385, -121.7552, '88510 Government Camp Loop, Government Camp, OR 97028', '503-272-3888', 'https://www.valianssports.com', 50, 'manual',
  'Government Camp loop shop with walk-in adult ski packages and after-hours returns for Skibowl night skiing'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-skibowl';

-- Sources: timberlinelodge.com/mountain/rentals/ (Summit Pass Adult 16+ Skis, Boots & Poles all-day $48) ; traveloregon.com Summit Pass listing (90255 Government Camp Loop, 503-272-0256)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'summit-pass-rental-shop', 'Summit Pass Rental Shop', reg.id, res.id, 45.30306, -121.74593, '90255 E Government Camp Loop, Government Camp, OR 97028', '503-272-0256', 'https://www.timberlinelodge.com', 48, 'manual',
  'Timberline-run rental counter at the Summit Pass lodge in Government Camp, about a mile from Skibowl'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-hood-skibowl';

-- Sources: willamettepass.ski/rentals/ (2025/26 Adult Ski or Snowboard rental weekday standard $25 plus $10 day-of fee = $35 walk-in) ; fs.usda.gov Willamette Pass Ski Area
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'willamette-pass-rental-shop', 'Willamette Pass Rental Shop', reg.id, res.id, 43.60069, -122.03648, 'Mile Marker 62, OR-58, Cascade Summit, OR 97733', '541-345-7669', 'https://www.willamettepass.ski', 35, 'manual',
  'Base lodge rental desk at Highway 58 milepost 62 with a published weekday adult rate plus a same-day fee'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'willamette-pass';

-- Sources: bergsskishop.com/info/ski-repairs-and-rentals.php (Adult Sport Ski Package skis, boots, poles $30/day) ; eugenecascadescoast.org ski-day post
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'bergs-ski-shop-eugene', 'Berg''s Ski & Snowboard Shop', reg.id, res.id, 44.04582, -123.09829, '367 West 13th Ave, Eugene, OR 97401', '541-683-1300', 'https://www.bergsskishop.com', 30, 'manual',
  'West 13th Avenue Eugene shop renting adult sport ski packages before the Highway 58 drive to Willamette Pass'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'willamette-pass';

-- Sources: hoodoo.com/rates/rentals/ (Adult 13-64 all-day ski package skis, boots, poles $49; peak days +$10) ; OSM node 9155101152
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'hoodoo-rental-shop', 'Hoodoo Rental Shop', reg.id, res.id, 44.40858, -121.87137, '27400 Big Lake Road, Sisters, OR 97759', '541-822-3799', 'https://hoodoo.com', 49, 'manual',
  'Lodge rental counter on Big Lake Road at the Hoodoo base with a published adult all-day ski package'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'hoodoo';

-- Sources: eurosports.us/winter-rentals/ (Rossignol Adult Ski Package $35 listed; page last modified 2023-04-23 and does not state boots and poles included; rate left NULL) ; eurosports.us/contact/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'eurosports-sisters', 'Eurosports', reg.id, res.id, 44.29029, -121.54839, '223 E Hood Ave, Sisters, OR 97759', '541-549-2471', 'https://eurosports.us', NULL, 'manual',
  'East Hood Avenue shop in Sisters renting downhill gear the evening before a Hoodoo day'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'hoodoo';

-- Sources: hillsideski.com/rental-rates/ (Adult 13-64 all-day ski package skis, boots, poles $35 for 8am-1pm pickup) ; hoodoo.com/hillside-ski-sport/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'hillside-ski-sport', 'Hillside Ski & Sport', reg.id, res.id, 44.29104, -121.54605, '411 E Cascade Ave, Sisters, OR 97759', '541-904-4673', 'https://hillsideski.com', 35, 'manual',
  'East Cascade Avenue Sisters shop renting alpine sets and selling Hoodoo tickets about 18 miles from the lifts'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'hoodoo';

-- Sources: mtashland.com/ski-board-rentals/ (2025-26 ages 13+ all-day ski or snowboard rental $45 at ticket desk) ; mtashland.com/ski-school-faq/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-ashland-rental-shop', 'Mt. Ashland Rental Shop', reg.id, res.id, 42.0817, -122.70478, '11 Mt. Ashland Ski Road, Ashland, OR 97520', '541-482-2897', 'https://www.mtashland.com', 45, 'manual',
  'Base lodge rental counter at Mt. Ashland issuing adult ski and snowboard sets for a single operating day'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-ashland';

-- Sources: theblackbird.com/wp-content/uploads/2025/11/Black-Bird-Ski-Shop-Rentals.pdf (2025/26 adult Down Hill Ski Package $40 for 24hr) ; mtashland.com/cross-country-snowshoeing/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'black-bird-medford', 'Black Bird Ski Shop', reg.id, res.id, 42.3245, -122.89311, '1810 W. Main St., Medford, OR 97501', '541-779-5431', 'https://theblackbird.com', 40, 'manual',
  'West Main Medford shop with a published 24-hour adult downhill ski package before the drive to Mt. Ashland'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'mt-ashland';

-- Sources: anthonylakes.com/winter/rental-repair-shop/#alpine-ski-rental-rates (Adult Alpine full day $40, after 1pm $35; Tablesome table updated 2025-11-18) ; OSM way 778107119
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'anthony-lakes-rental-repair-shop', 'Anthony Lakes Rental & Repair Shop', reg.id, res.id, 44.96259, -118.23361, '47500 Anthony Lakes Hwy, North Powder, OR 97867', '541-856-3277', 'https://anthonylakes.com', 40, 'manual',
  'Base ski shop beside Anthony Lakes Lodge renting an adult alpine set for a full day'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'anthony-lakes';

-- Sources: thetrailheadbakercity.com/bike-and-ski-shop/winter-season-lease-program/ (2025-26 season ski lease $265; no one-day adult alpine package published) ; traveloregon.com/plan-your-trip/transportation/the-trailhead/
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'trailhead-baker-city', 'The Trailhead', reg.id, res.id, 44.77589, -117.82952, '1828 Main Street, Baker City, OR 97814', '541-523-1668', 'https://thetrailheadbakercity.com', NULL, 'manual',
  'Main Street Baker City shop leasing adult skis, boots, and poles for the season, about 35 road miles from the base'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-or' AND res.slug = 'anthony-lakes';

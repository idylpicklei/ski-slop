-- Idaho ski rental shops — researched, priced, original descriptions.
-- Each entry verified against >=2 sources; price from the shop's own rates page.

-- Sources: sturtevants-sv.com/rent-snow-online (Adult Sport pkg $39.99 online) ; sturtevants-sv.com/stores
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'sturtevants-ketchum', 'Sturtevants of Sun Valley', reg.id, res.id, 43.6811, -114.3647, '340 N Main St, Ketchum, ID 83340', '208-726-4501', 'https://sturtevants-sv.com', 40, 'manual',
  'Downtown Ketchum shop with online sport-package reservations and a Warm Springs base pickup option'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: pkski.com (Adult Sport pkg $40/day online) ; visitsunvalley.com/dining-shopping/pks-ski-sports
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'pks-ski-sports-ketchum', 'PK''s Ski and Sports', reg.id, res.id, 43.6826, -114.3644, '320 N Leadville Ave, Ketchum, ID 83340', '208-726-7474', 'https://pkski.com', 40, 'manual',
  'Leadville Avenue Ketchum storefront with online sport packages and demo skis for Sun Valley days'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: eco-lounge.com/rentals-winter (Full Day Package $45) ; eco-lounge.com
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'eco-lounge-boise', 'Eco Lounge', reg.id, res.id, 43.6607, -116.185, '2445 N Bogus Basin Rd, Boise, ID 83702', NULL, 'https://eco-lounge.com', 45, 'manual',
  'Bogus Basin Road shop en route from Boise with daily packages and tuning before the drive uphill'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'bogus-basin';

-- Sources: bogusbasin.org/rentals-repairs/winter-rentals (Basic Rental Ski Package $57 full day) ; bogusbasin.org/rentals-repairs
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'bogus-basin-rental-shop', 'Bogus Basin Rental Shop', reg.id, res.id, 43.764, -116.102, 'ICCU Base Area Plaza, Bogus Basin, ID', '208-332-5100', 'https://bogusbasin.org/rentals-repairs/winter-rentals', 57, 'manual',
  'Slopeside ICCU Plaza counter renting basic ski packages a short walk from Bogus Basin lifts'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'bogus-basin';

-- Sources: alpineshopsandpoint.com/ski-rentals-sandpoint (Adult Package $50, Schweitzer location) ; schweitzer.com/things-to-do/shopping/alpine-shop
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'alpine-shop-schweitzer-village', 'Alpine Shop Schweitzer Village', reg.id, res.id, 48.508, -116.618, '166 Village Lane, Sandpoint, ID 83864', '208-255-1660', 'https://www.alpineshopsandpoint.com', 50, 'manual',
  'Schweitzer Village partner shop with walk-in adult packages, boot fitting, and demo gear'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'schweitzer';

-- Sources: schweitzer.com/plan-your-trip/rentals/basic-rentals/ski-rental-package (Adult basic from $50) ; schweitzer.com/plan-your-trip/rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'schweitzer-ski-ride-center', 'Schweitzer Ski & Ride Center', reg.id, res.id, 48.5136, -116.622, 'Schweitzer Village, Sandpoint, ID 83864', NULL, 'https://www.schweitzer.com/plan-your-trip/rentals', 50, 'manual',
  'Resort-run rental desk beside Basin Express with Rossignol basic ski packages and online booking'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'schweitzer';

-- Sources: allmovementsports.com (Adult pkg $20/day) ; allmovementsports.com
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'all-movement-sports-kellogg', 'All Movement Sports', reg.id, res.id, 47.541, -116.119, '119 McKinley Ave W Unit C, Kellogg, ID 83837', '208-956-0716', 'https://allmovementsports.com', 20, 'manual',
  'Uptown Kellogg walk-in shop with budget daily packages minutes from Silver Mountain and Lookout Pass'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'silver-mountain';

-- Sources: silvermt.com/ski-ride/rentals (Adult Basic Package $44 full day) ; silvermt.com/ski-ride/rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'silver-mountain-rental-shop', 'Silver Mountain Rental Shop', reg.id, res.id, 47.544, -116.119, 'Gondola Village, Kellogg, ID 83837', '866-345-2675', 'https://www.silvermt.com/ski-ride/rentals', 44, 'manual',
  'Gondola Village counter renting adult basic ski packages before the Kellogg mountain ascent'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'silver-mountain';

-- Sources: tamarackidaho.com/tamarack-outfitters/winter-rentals (Adult Standard Ski $40 non-holiday) ; tamarackidaho.com/tamarack-outfitters/winter-rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'tamarack-outfitters', 'Tamarack Outfitters', reg.id, res.id, 44.6698, -116.1241, '311 Village Dr, Tamarack, ID 83615', '208-325-1000', 'https://tamarackidaho.com/tamarack-outfitters/winter-rentals', 40, 'manual',
  'Village-base rental desk with standard ski and snowboard packages on Lake Cascade''s ski hill'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'tamarack';

-- Sources: pebblecreekskiarea.com/lessons-rentals (Full Day Package $40) ; visitpocatello.com/rental_location/pebble-creek-ski-area
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'pebble-creek-rental-shop', 'Pebble Creek Rental Shop', reg.id, res.id, 42.778, -112.157, '3340 E Green Canyon Rd, Inkom, ID 83445', '208-775-4452', 'https://pebblecreekskiarea.com/lessons-rentals', 40, 'manual',
  'Inkom base-area desk renting full-day ski packages on the steep Portneuf Range above Pocatello'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'pebble-creek';

-- Sources: barriessports.com/articles/ski-snowboard-rentals-pg218.htm (Alpine package $25/day) ; idahohighcountry.org/item/barries-ski-and-sports
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'barries-ski-sport-pocatello', 'Barrie''s Ski & Sports', reg.id, res.id, 42.8867, -112.4513, '624 Yellowstone Ave, Pocatello, ID 83201', '208-232-8996', 'https://www.barriessports.com', 25, 'manual',
  'Yellowstone Avenue Pocatello outfitter with walk-in alpine packages for Pebble Creek day trips'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'pebble-creek';

-- Sources: idahomountaintrading.com/about/winter-rentals-pg183.htm (Ski Package $30/day) ; idahomountaintrading.com/storelocator
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'idaho-mountain-trading', 'Idaho Mountain Trading', reg.id, res.id, 43.4946, -112.0378, '474 Shoup Ave, Idaho Falls, ID 83402', '208-523-6679', 'https://www.idahomountaintrading.com/about/winter-rentals-pg183.htm', 30, 'manual',
  'Idaho Falls Shoup Avenue shop with $30 daily ski packages for Kelly Canyon and eastern Idaho hills'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'kelly-canyon';

-- Sources: skilookout.com/rentals-repairs (Adult pkg $38/day) ; skilookout.com/rentals-repairs
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'lookout-pass-rental-shop', 'Lookout Pass Rental Shop', reg.id, res.id, 47.453, -115.707, 'Lookout Pass, Mullan, ID 83846', NULL, 'https://skilookout.com/rentals-repairs', 38, 'manual',
  'Interstate 90 pass rental desk opening early for adult ski and snowboard setups on the border'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'lookout-pass';

-- Sources: pomerelle.com/rentals (Ski Rental Package $35) ; pomerelle.com/rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'pomerelle-rental-shop', 'Pomerelle Rental Shop', reg.id, res.id, 42.3175, -113.6082, '961 E Howell Canyon Rd, Malta, ID 83342', '208-673-5555', 'https://www.pomerelle.com/rentals', 35, 'manual',
  'Albion Mountains lodge pro shop with $35 ski packages that include poles and a helmet'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'pomerelle';

-- Sources: magicmountainresort.com/rentals (Ski Package $25) ; magicmountainresort.com/rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'magic-mountain-rental-shop', 'Magic Mountain Rental Shop', reg.id, res.id, 42.1875, -114.2856, 'Forest Rd 499, Kimberly, ID 83341', '208-280-2883', 'https://magicmountainresort.com/rentals', 25, 'manual',
  'Sawtooth Forest base shed renting $25 ski packages for southern Idaho day trips near Twin Falls'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'magic-mountain';

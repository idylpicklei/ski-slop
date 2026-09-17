-- Idaho ski rental shops for sun-valley, brundage, schweitzer, bogus-basin, tamarack.
-- Cap fill: nearest town/independent shops missing from 0007/0010. Adult standard
-- one-day ski package (skis+boots+poles), walk-in, whole USD — or NULL.

-- Sources: sturtevants-sv.com/rent-snow-online (Adult Sport skis+boots $39.99, Hailey+Main) ; sturtevants-sv.com/stores
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'sturtevants-hailey', 'Sturtevants of Sun Valley Hailey', reg.id, res.id, 43.5199, -114.3158, '1 W Carbonate St, Hailey, ID 83333', '208-788-7847', 'https://sturtevants-sv.com', 40, 'manual',
  'Hailey Main and Carbonate shop with adult sport packages for Sun Valley day trips from the south valley'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: sunvalley.com/rentals (sport/performance/demo packages; walk-in sport rate unpublished while Off-Sale) ; sunvalley.com/shopping/pete-lanes/locations
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'pete-lanes-village-rental-center', 'Pete Lane''s Village Rental Center', reg.id, res.id, 43.696, -114.3536, '15 Kitzbuhler Strasse, Sun Valley, ID 83353', '208-622-6127', 'https://www.sunvalley.com/rentals/', NULL, 'manual',
  'Sun Valley Village fitting desk for next-day Pete Lane sport packages delivered to Dollar or Bald bases'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: boardbin.com/Rentals (adult full pkg board+boots+bindings $84.99; snowboard pkg) ; visitsunvalley.com/dining-shopping/board-bin-girl-street
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'board-bin-ketchum', 'The Board Bin', reg.id, res.id, 43.6804, -114.3659, '180 4th St E, Ketchum, ID 83340', '208-726-1222', 'https://boardbin.com', 85, 'manual',
  'Ketchum Fourth Street snowboard shop with published adult board-boot packages and in-house demos'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: blacktieskis.com/sun-valley (Main Street storefront + booking; one-day walk-in sport price unpublished) ; blacktieskis.com/sun-valley/sun-valley-ski-rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'black-tie-ketchum', 'Black Tie Skis of Sun Valley', reg.id, res.id, 43.6832, -114.3668, '660 N Main St, Ketchum, ID 83340', '208-720-6935', 'https://www.blacktieskis.com/sun-valley', NULL, 'manual',
  'Walk-in rental desk on North Main in Ketchum that also delivers fitted ski packages to lodging'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'sun-valley';

-- Sources: sites.google.com/view/home-town-sports/retail/winter-rentals (Adult Standard Alpine; prices unpublished) ; OSM shop Home Town Sports McCall
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'home-town-sports-mccall', 'Home Town Sports', reg.id, res.id, 44.91, -116.0984, '300 E Lenora St, McCall, ID 83638', '208-634-2302', 'https://sites.google.com/view/home-town-sports/retail/winter-rentals', NULL, 'manual',
  'McCall Lenora Street shop with adult standard alpine packages for Brundage day trips'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'brundage';

-- Sources: gravitysportsidaho.com/rentals (Alpine Demo Package $70 only; no standard sport tier published) ; gravitysportsidaho.com/contact-us
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'gravity-sports-mccall', 'Gravity Sports', reg.id, res.id, 44.8941, -116.0948, '200 Jacob St, McCall, ID 83638', '208-634-8530', 'https://www.gravitysportsidaho.com/rentals/', NULL, 'manual',
  'Downtown McCall rental desk between Brundage and Tamarack with alpine demo packages on the books'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'brundage';

-- Sources: alpineshopsandpoint.com (downtown full-service ski shop; current ski package rates unpublished on site) ; EquipDash Alpine Shop Sandpoint listing
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'alpine-shop-sandpoint', 'Alpine Shop Sandpoint', reg.id, res.id, 48.274, -116.5491, '213 Church St, Sandpoint, ID 83864', '208-263-5157', 'https://www.alpineshopsandpoint.com', NULL, 'manual',
  'Downtown Sandpoint Church Street shop with ski rentals and boot fitting before the drive up to Schweitzer'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'schweitzer';

-- Sources: mcusports.com/ski-rentals-boise (Adult Sport Package $50 full day) ; OSM shop McU Sports 2314 N Bogus Basin Rd
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mcu-sports-bogus-basin-rd', 'McU Sports Ski Shop', reg.id, res.id, 43.6405, -116.2079, '2314 N Bogus Basin Rd, Boise, ID 83702', '208-336-2300', 'https://www.mcusports.com/ski-rentals-boise/', 50, 'manual',
  'Bogus Basin Road ski shop with adult sport packages and overnight pickup before the drive uphill'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'bogus-basin';

-- Sources: mcusports.com/ski-rentals-boise (Adult Sport Package $50 full day; downtown store listed) ; mcusports.com
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mcu-sports-downtown-boise', 'McU Sports Downtown', reg.id, res.id, 43.6186, -116.2019, '822 W Jefferson St, Boise, ID 83702', '208-342-7734', 'https://www.mcusports.com/ski-rentals-boise/', 50, 'manual',
  'Downtown Boise Jefferson Street storefront sharing McU adult sport ski package rates for Bogus Basin days'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'bogus-basin';

-- Sources: greenwoodsskihaus.com/RENTALS (daily/half-day rentals; package price unpublished) ; OSM Bob Greenwood''s Ski Haus
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'greenwoods-ski-haus', 'Greenwood''s Ski Haus', reg.id, res.id, 43.6414, -116.2074, '2400 N Bogus Basin Rd, Boise, ID 83702', '208-342-6808', 'https://greenwoodsskihaus.com/RENTALS', NULL, 'manual',
  'Bogus Basin Road shop offering daily ski and snowboard rentals beside the McU corridor'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'bogus-basin';

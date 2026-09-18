-- Washington ski rental shops for crystal-mountain, stevens-pass, the-summit-at-snoqualmie, mt-baker, white-pass, mission-ridge, 49-degrees-north, mount-spokane.
-- Resort-outward fill, nearest base or town shop first, capped at six per resort. Adult standard
-- one-day ski package (skis+boots+poles), walk-in, whole USD, or NULL where the shop publishes no rate.

-- Sources: crystalmountainresort.com/plan-your-trip/rental-and-demo-equipment (date-based online pricing, walk-up 15% higher; no fixed adult day rate published) ; crystalmountainresort.com/plan-your-trip/rental-and-demo-equipment/beginner-rental-equipment/adult-beginner-ski-rentals (standard pkg = skis, boots, poles; Cascade Lodge 4th level)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'crystal-mountain-brand-x-rentals', 'Brand X Equipment at Crystal Mountain', reg.id, res.id, 46.9352, -121.4746, '33914 Crystal Mountain Blvd, Enumclaw, WA 98022', NULL, 'https://www.crystalmountainresort.com/plan-your-trip/rental-and-demo-equipment', NULL, 'manual',
  'Resort-run rental and repair shop on the fourth level of Cascade Lodge beside the Crystal Mountain lifts, priced by date through online booking'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'crystal-mountain';

-- Sources: skiandbicycle.com (Daily Ski Package skis, boots, poles adult $45 on the homepage rate table and /rental/) ; visitrainier.com/enumclaw-ski-mountain-sports (adult full package $45; Hwy 410 location, 360-825-6910)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'enumclaw-ski-and-mountain-sports', 'Enumclaw Ski & Mountain Sports', reg.id, res.id, 47.19928, -121.97553, '240 Roosevelt Ave E, Enumclaw, WA 98022', '360-825-6910', 'https://skiandbicycle.com', 45, 'manual',
  'Highway 410 walk-in shop in Enumclaw renting daily ski and snowboard packages on the drive up to Crystal Mountain, with after-hours locker returns'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'crystal-mountain';

-- Sources: stevenspass.com/plan-your-trip/rentals/winter-equipment.aspx (Sport, Performance, Demo packages; date-based online pricing, no fixed adult day rate published) ; stevenspass.com/explore-the-resort/during-your-stay/first-time-guide/beginners-guide.aspx (Rental Tech Center in Tye Creek Lodge)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'stevens-pass-rental-center', 'Stevens Pass Rental Center', reg.id, res.id, 47.7448, -121.0895, 'Tye Creek Lodge, 93001 NE Stevens Pass Hwy, Skykomish, WA 98288', '206-812-4510', 'https://www.stevenspass.com/plan-your-trip/rentals/winter-equipment.aspx', NULL, 'manual',
  'Vail-run rental desk inside Tye Creek Lodge at the Stevens Pass base with sport, performance, and demo packages booked by date online'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'stevens-pass';

-- Sources: stevenspasssnowboardshop.com/rentals (ski and snowboard rentals, daily walk-in, reserve by 4pm the day before; no package prices published) ; mountaineers.org Everett Nordic ski rental info 2026 (617 Croft Ave, Gold Bar, 360-799-0613)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'stevens-pass-snowboard-shop-gold-bar', 'Stevens Pass Snowboard Shop', reg.id, res.id, 47.85454, -121.69666, '617 Croft Ave, Gold Bar, WA 98251', '360-799-0613', 'https://www.stevenspasssnowboardshop.com', NULL, 'manual',
  'Gold Bar shop on the US 2 approach to Stevens Pass renting skis and snowboards by the day, with late-night returns during night operations'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'stevens-pass';

-- Sources: arlbergsports.com/articles/leavenworth-pg177.htm (Leavenworth store, 1207 Front St; no rental rate list published online) ; skileavenworth.com/equipment-rental (listed for alpine ski and snowboard rentals)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'arlberg-sports-haus-leavenworth', 'Arlberg Sports Haus', reg.id, res.id, 47.59775, -120.65645, '1207 Front St, Leavenworth, WA 98826', '509-548-5615', 'https://www.arlbergsports.com/articles/leavenworth-pg177.htm', NULL, 'manual',
  'Front Street Leavenworth branch of the Wenatchee ski shop renting alpine skis and snowboards to visitors heading up to Stevens Pass'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'stevens-pass';

-- Sources: eastsidecycleworks.com/winter (alpine ski and boot rentals from a new Rossignol fleet, online reservations; no prices on page) ; skileavenworth.com/equipment-rental (listed for alpine skis and snowboards, 215 14th St)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'eastside-cycleworks-leavenworth', 'Eastside Cycleworks', reg.id, res.id, 47.59871, -120.65428, '215 14th St, Leavenworth, WA 98826', '509-470-6655', 'https://eastsidecycleworks.com/winter/', NULL, 'manual',
  'Leavenworth bike-and-ski shop renting new Rossignol alpine skis and boots by online reservation, about 32 road miles east of Stevens Pass'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'stevens-pass';

-- Sources: summitatsnoqualmie.com/rentals (online-only reservations; 3-pack $305 and season rentals listed, single-day adult rate not published) ; summitatsnoqualmie.com/rentals/rental-pack (ski package = skis, boots, poles; base-area specific pickup)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'summit-at-snoqualmie-rental-shop', 'Summit at Snoqualmie Rental Shop', reg.id, res.id, 47.4247, -121.417, '1001 WA-906, Snoqualmie Pass, WA 98068', '425-434-7669', 'https://www.summitatsnoqualmie.com/rentals', NULL, 'manual',
  'Resort rental shops at the Summit at Snoqualmie base areas, reserved online for a specific base area with no walk-up sales'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'the-summit-at-snoqualmie';

-- Sources: proskiservice.com/pages/daily-rentals (Adult Basic Ski Package $50 first day, $35 each additional) ; blisterreview.com/gear-reviews/pro-ski-mountain-service-2 (112 W 2nd St, North Bend; daily and seasonal rentals)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'pro-ski-and-mountain-service-north-bend', 'Pro Ski & Mountain Service', reg.id, res.id, 47.49595, -121.78542, '112 W 2nd St, North Bend, WA 98045', '425-888-6397', 'https://www.proskiservice.com', 50, 'manual',
  'North Bend ski and mountaineering shop 15 minutes below Snoqualmie Pass with basic and demo alpine packages plus touring and splitboard rentals'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'the-summit-at-snoqualmie';

-- Sources: mtbaker.us/lessons-rentals/daily-rentals/basic (2026-27 Adult Basic Rental full day $66.48 before 8.2% WA tax; skis, bindings, boots, poles) ; mtbaker.us/lessons-rentals/daily-rentals/rentals-faq (Heather Meadows and White Salmon rental shop locations)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-baker-ski-area-rental-shop', 'Mt. Baker Ski Area Rental Shop', reg.id, res.id, 48.8573, -121.6688, 'Heather Meadows Base Area, Mt Baker Hwy (SR 542), Deming, WA 98244', '360-734-6771', 'https://www.mtbaker.us/lessons-rentals/daily-rentals/basic/', 66, 'manual',
  'Ski-area rental counters at the Heather Meadows and White Salmon lodges with basic and premium packages priced before tax for full or afternoon days'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mt-baker';

-- Sources: glacierskishop.com/pages/rent-gear (Standard alpine ski package $59, premium $69; skis, boots, poles) ; glacierskishop.com (log cabin rental shop at 9966 Mt Baker Hwy, showroom at 9946)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'glacier-ski-shop', 'Glacier Ski Shop', reg.id, res.id, 48.88993, -121.94673, '9966 Mt Baker Hwy, Glacier, WA 98244', '360-599-1943', 'https://glacierskishop.com', 59, 'manual',
  'Log-cabin rental shop in Glacier, the last town below the Mt. Baker ski area, with standard and premium alpine packages plus touring gear'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mt-baker';

-- Sources: backcountryessentials.net/pages/ski-snowsport-rentals (Alpine Basic Package adult overnight rate $49, each additional night $35; overnight rate covers one ski day) ; backcountryessentials.net (1417 N State St, Bellingham)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'backcountry-essentials-bellingham', 'Backcountry Essentials', reg.id, res.id, 48.74965, -122.47536, '1417 N State St, Bellingham, WA 98225', '360-543-5678', 'https://backcountryessentials.net', 49, 'manual',
  'Downtown Bellingham outdoor shop renting basic and premium alpine packages on an overnight rate before the drive up the Mount Baker Highway'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mt-baker';

-- Sources: skiwhitepass.com/lessons-and-rentals/rental-equipment (Adult Alpine Package $54 plus WA sales tax; skis, boots, poles) ; estore.skiwhitepass.com/products/full-day-rentals (online reservation required, adult 17 and up)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'white-pass-rental-shop', 'White Pass Rental Shop', reg.id, res.id, 46.6375, -121.3915, 'Base Camp Lodge, 48935 US Hwy 12, Naches, WA 98937', '509-672-3101', 'https://skiwhitepass.com/lessons-and-rentals/rental-equipment', 54, 'manual',
  'Ski-area rental shop in the Base Camp Lodge off Lot C at White Pass, with adult alpine packages reserved online ahead of walk-ins'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'white-pass';

-- Sources: visitrainier.com/white-pass-sports-hut (downhill, snowboard, cross-country, and snowshoe rentals; 13020 US Hwy 12 Packwood; no prices published) ; whitepasswa.bar-z.com/222/feature/white-pass-sports-hut (rental, sales, and repair listing)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'white-pass-sports-hut-packwood', 'White Pass Sports Hut', reg.id, res.id, 46.60725, -121.67052, '13020 US Hwy 12, Packwood, WA 98361', '360-494-7321', NULL, NULL, 'manual',
  'Packwood outdoor store on US 12 below the west side of White Pass renting downhill skis, snowboards, and snowshoes with in-house tuning'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'white-pass';

-- Sources: missionridge.com/rental (Basic Rental Package full day $63, late arrival $53; skis, boots, poles) ; missionridge.com/contact (Rental & Repair Shops 509-663-6543, 7500 Mission Ridge Rd)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mission-ridge-rental-shop', 'Mission Ridge Rental Shop', reg.id, res.id, 47.2925, -120.3995, '7500 Mission Ridge Rd, Wenatchee, WA 98801', '509-663-6543', 'https://www.missionridge.com/rental/', 63, 'manual',
  'Main-lodge rental shop at the Mission Ridge base with basic and performance packages priced for full-day, late-arrival, and night sessions'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mission-ridge';

-- Sources: arlbergsports.com/articles/downtown-wenatchee-rentals-pg148.htm (downtown Wenatchee rentals page; no rate list rendered online) ; skileavenworth.com/equipment-rental (listed for alpine ski and snowboard rentals, 25 N Wenatchee Ave)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'arlberg-sports-wenatchee', 'Arlberg Sports', reg.id, res.id, 47.42504, -120.31166, '25 N Wenatchee Ave, Wenatchee, WA 98801', '509-663-7401', 'https://www.arlbergsports.com', NULL, 'manual',
  'Family-run downtown Wenatchee ski shop 12 miles below Mission Ridge with alpine rentals, boot fitting, and an annual demo day on the mountain'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mission-ridge';

-- Sources: ski49n.com/mountain-services/rental-shop (Adult 18+ full-day package from $40, lowest advance-purchase online rate; walk-in and short-notice rates higher and unpublished) ; ski49n.com/mountain-services/rental-repair-shop (Rental Center in the Experience Center beside Calispel Creek Lodge)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT '49-degrees-north-rental-center', '49 Degrees North Rental Center', reg.id, res.id, 48.3005, -117.5633, 'Experience Center, 3311 Flowery Trail Rd, Chewelah, WA 99109', '509-935-6649', 'https://www.ski49n.com/mountain-services/rental-shop', 40, 'manual',
  'Rental Center in the 49 Degrees North Experience Center at the Chewelah base, with Rossignol, Head, and Elan packages cheapest when booked two days ahead'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = '49-degrees-north';

-- Sources: mtspokane.com/rentals (2025-26 Adult Package skis, boots, poles, helmet $42; $5 off for night sessions) ; mtspokane.com/contact-us (29500 N Mt Spokane Park Dr, Mead, 509-238-2220)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'mt-spokane-rental-shop', 'Mt. Spokane Rental Shop', reg.id, res.id, 47.9215, -117.0975, 'Lodge 2, 29500 N Mt Spokane Park Dr, Mead, WA 99021', '509-238-2220', 'https://www.mtspokane.com/rentals', 42, 'manual',
  'Lodge 2 rental shop at Mount Spokane with Rossignol adult packages that include a helmet and a discount for night-ski sessions'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mount-spokane';

-- Sources: thespokanealpinehaus.com/services/ski-snowboard-rentals (Adult Ski/Board Daily Package $44.95, poles included) ; thespokanealpinehaus.com (2215 W Northwest Blvd location, 509-561-1103)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'spokane-alpine-haus-northwest-blvd', 'Spokane Alpine Haus Northwest Blvd', reg.id, res.id, 47.68329, -117.44503, '2215 W Northwest Blvd, Spokane, WA 99205', '509-561-1103', 'https://www.thespokanealpinehaus.com', 45, 'manual',
  'Northwest Boulevard Spokane ski shop fitting daily adult ski or board packages from 3 pm the day before a Mount Spokane trip'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mount-spokane';

-- Sources: thespokanealpinehaus.com/services/ski-snowboard-rentals (Adult Ski/Board Daily Package $44.95, poles included) ; thespokanealpinehaus.com (2925 S Regal St South Hill location, 509-534-4554)
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'spokane-alpine-haus-south-hill', 'Spokane Alpine Haus South Hill', reg.id, res.id, 47.62723, -117.36849, '2925 S Regal St, Spokane, WA 99223', '509-534-4554', 'https://www.thespokanealpinehaus.com', 45, 'manual',
  'South Hill branch of the Spokane Alpine Haus with the same day-before fitting and daily adult packages, returns due by noon the day after skiing'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-wa' AND res.slug = 'mount-spokane';

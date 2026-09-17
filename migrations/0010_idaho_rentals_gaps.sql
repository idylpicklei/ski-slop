-- Idaho rental shops filling major resort gaps (Brundage, Lost Trail, Soldier Mountain).
-- Adult standard ski package (skis + boots + poles), one-day walk-in, whole USD — or NULL.

-- Sources: losttrail.com/rentals-repairs (adult full ski setup $35/$30 half) ; losttrail.com
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'lost-trail-rental-shop', 'Lost Trail Rental Shop', reg.id, res.id, 45.692, -113.952, 'Lost Trail Pass, Sula, MT 59871', NULL, 'https://losttrail.com/rentals-repairs/', 35, 'manual',
  'Border-pass rental desk with Rossignol alpine packages and same-day walk-in fitting'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'lost-trail-powder-mountain';

-- Sources: soldiermountain.com/rentals (skis+boards from $32; boots free with package) ; getskitickets.com/tickets/id/soldier-mountain
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'soldier-mountain-rental-shop', 'Soldier Mountain Rental Shop', reg.id, res.id, 43.485, -114.830, '1043 N Soldier Creek Rd, Fairfield, ID 83327', '208-765-3437', 'https://soldiermountain.com/rentals/', 32, 'manual',
  'Fairfield lodge counter with standard ski packages and free helmets on Sawtooth Forest terrain'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'soldier-mountain';

-- Sources: brundage.com/ski-and-snowboard-rentals (Basic entry-level packages; rate unpublished) ; estore.brundage.com/products/rentals
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT 'brundage-rental-shop', 'Brundage Rental Shop', reg.id, res.id, 45.006, -116.152, 'Mountain Adventure Center, Brundage Mountain, McCall, ID', '208-634-4151', 'https://brundage.com/ski-and-snowboard-rentals/', NULL, 'manual',
  'MAC base-area desk with Basic Nordica packages a short walk from Brundage lifts'
FROM regions reg, ski_resorts res WHERE reg.slug = 'us-id' AND res.slug = 'brundage';

-- Washington major resort adult full-day peak lift ticket prices (whole USD) plus original summaries.
-- Safe UPDATEs only fill NULL ticket_price_usd / summary; never overwrite a verified value.
-- Peak = highest regular adult day / walk-up window rate per docs/resort-research-guide.md.
-- NULL ticket_price_usd when the official tickets page is a dynamic calendar with no visible regular adult day rate.

-- Sources: crystalmountainresort.com/plan-your-trip/tickets-and-passes/day-tickets/winter-lift-tickets (dynamic calendar; no adult day dollar amounts visible) ; en.wikipedia.org/wiki/Crystal_Mountain_(Washington) (WA largest ski area; ~3,100 ft vertical; Mt. Rainier Gondola)
-- ticket_price_usd left NULL: official day-tickets page is dynamic with no visible regular adult day rate.
UPDATE ski_resorts
SET summary = 'Washington''s largest ski area east of Mount Rainier, with a summit gondola and about 3,100 ft of vertical.'
WHERE slug = 'crystal-mountain' AND summary IS NULL;

-- Sources: stevenspass.com/plan-your-trip/lift-access/tickets.aspx (Epic dynamic tickets; no static adult day rate table) ; en.wikipedia.org/wiki/Stevens_Pass_Ski_Area (U.S. 2 Cascades day resort; night skiing; Mill Valley backside)
-- ticket_price_usd left NULL: official tickets page is dynamic with no visible regular adult day rate.
UPDATE ski_resorts
SET summary = 'Cascades day resort on U.S. 2 near Skykomish, with night skiing and a south-facing Mill Valley backside.'
WHERE slug = 'stevens-pass' AND summary IS NULL;

-- Sources: summitatsnoqualmie.com/tickets/lift-tickets (prices and availability vary; no listed adult day rates) ; en.wikipedia.org/wiki/The_Summit_at_Snoqualmie (I-90 closest major complex to Seattle; Alpental + three Summit bases)
-- ticket_price_usd left NULL: official lift-tickets page is dynamic with no visible regular adult day rate.
UPDATE ski_resorts
SET summary = 'Closest major ski complex to Seattle on I-90, combining Alpental and three Summit bases at Snoqualmie Pass.'
WHERE slug = 'the-summit-at-snoqualmie' AND summary IS NULL;

-- Sources: mtbaker.us/tickets-and-passes/daily-lift-tickets-2025-26/ (2025-26 peak all-day adult 16-59 $104.44 tax not included) ; en.wikipedia.org/wiki/Mt._Baker_Ski_Area (Whatcom County; extreme Cascade snowfall; Mount Shuksan views)
UPDATE ski_resorts
SET ticket_price_usd = 104
WHERE slug = 'mt-baker' AND ticket_price_usd IS NULL;

UPDATE ski_resorts
SET summary = 'Whatcom County ski area near Mount Shuksan, known for extreme Cascade snowfall and steep in-bounds terrain.'
WHERE slug = 'mt-baker' AND summary IS NULL;

-- Sources: skiwhitepass.com/online-day-ticket-sales (2026/27 adult day tickets from $89 on peak days; inventory-driven pricing) ; en.wikipedia.org/wiki/White_Pass_Ski_Area (U.S. 12; 2,000 ft vertical; between Mount Rainier and Mount Adams)
UPDATE ski_resorts
SET ticket_price_usd = 89
WHERE slug = 'white-pass' AND ticket_price_usd IS NULL;

UPDATE ski_resorts
SET summary = 'Central Cascades ski area on U.S. 12 with 2,000 ft of vertical between Mount Rainier and Mount Adams.'
WHERE slug = 'white-pass' AND summary IS NULL;

-- Sources: missionridge.com/news/1-4-26-conditions-report/ (2025-26 adult 25-69 advance day $115; highest official rate seen) ; en.wikipedia.org/wiki/Mission_Ridge_Ski_Area (Wenatchee; 2,250 ft vertical; night skiing; northeast slopes)
UPDATE ski_resorts
SET ticket_price_usd = 115
WHERE slug = 'mission-ridge' AND ticket_price_usd IS NULL;

UPDATE ski_resorts
SET summary = 'East Cascade ski area above Wenatchee with 2,250 ft of vertical, night skiing, and northeast-facing slopes.'
WHERE slug = 'mission-ridge' AND summary IS NULL;

-- Sources: ski49n.com/tickets/day-tickets (adult 18-69 holiday lowest advanced-purchase $79; short-notice/window higher unpublished) ; en.wikipedia.org/wiki/49_Degrees_North_Ski_Area (Chewelah; 2,300+ acres; Colville National Forest tree skiing)
UPDATE ski_resorts
SET ticket_price_usd = 79
WHERE slug = '49-degrees-north' AND ticket_price_usd IS NULL;

UPDATE ski_resorts
SET summary = 'Northeast Washington ski area near Chewelah with more than 2,300 acres of thinned tree skiing in Colville National Forest.'
WHERE slug = '49-degrees-north' AND summary IS NULL;

-- Sources: mtspokane.com/lift-tickets (2025-26 ages 18-59 weekends/holidays $89 window; online saves $5) ; en.wikipedia.org/wiki/Mount_Spokane_Ski_and_Snowboard_Park (Mount Spokane State Park; night skiing; ~23 miles from Spokane)
UPDATE ski_resorts
SET ticket_price_usd = 89
WHERE slug = 'mount-spokane' AND ticket_price_usd IS NULL;

UPDATE ski_resorts
SET summary = 'Spokane''s local ski hill in Mount Spokane State Park, with night skiing about 23 miles from town.'
WHERE slug = 'mount-spokane' AND summary IS NULL;

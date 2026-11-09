-- Colorado major resort adult full-day peak lift ticket prices (whole USD).
-- Safe UPDATEs only fill NULL ticket_price_usd and NULL summary; never overwrite a verified value.
-- Peak = highest regular adult day / walk-up window rate per docs/resort-research-guide.md.
-- 2025-26 peak same-day adult rates taken from resort dynamic calendars as reported for Dec 26-Jan 1.

-- Sources: https://www.vail.com/plan-your-trip/lift-access/tickets.aspx (Epic dynamic calendar; peak same-day adult $356 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/
UPDATE ski_resorts
SET ticket_price_usd = 356
WHERE slug = 'vail' AND ticket_price_usd IS NULL;

-- Sources: https://shop.aspensnowmass.com/ (dynamic shop; 2025-26 adult peak day $279) ; https://www.onthesnow.com/colorado/aspen-snowmass/lift-tickets (resort-sourced adult weekday/weekend $279)
UPDATE ski_resorts
SET ticket_price_usd = 279
WHERE slug = 'aspen-snowmass' AND ticket_price_usd IS NULL;

-- Sources: https://www.breckenridge.com/plan-your-trip/lift-access/tickets.aspx (Epic dynamic calendar; peak same-day adult $321 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/
UPDATE ski_resorts
SET ticket_price_usd = 321
WHERE slug = 'breckenridge' AND ticket_price_usd IS NULL;

-- Sources: https://tellurideskiresort.com/ski/ (tickets shop; peak holiday same-day adult $328 Dec 26-Jan 1 2025-26) ; https://www.powder.com/news/colorado-ski-lift-tickets-christmas-2025
UPDATE ski_resorts
SET ticket_price_usd = 328
WHERE slug = 'telluride' AND ticket_price_usd IS NULL;

-- Sources: https://www.keystoneresort.com/plan-your-trip/lift-access/tickets.aspx (Epic dynamic calendar; peak same-day adult $292 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Keystone_Resort (Summit County; night skiing; three peaks)
UPDATE ski_resorts
SET ticket_price_usd = 292
WHERE slug = 'keystone' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Summit County resort near Dillon with night skiing across three peaks above the Snake River valley.'
WHERE slug = 'keystone' AND summary IS NULL;

-- Sources: https://www.beavercreek.com/plan-your-trip/lift-access/tickets.aspx (Epic dynamic calendar; peak same-day adult $356 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Beaver_Creek_Resort (Avon; Birds of Prey World Cup; three villages)
UPDATE ski_resorts
SET ticket_price_usd = 356
WHERE slug = 'beaver-creek' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Vail Valley resort near Avon with World Cup Birds of Prey terrain and three linked villages.'
WHERE slug = 'beaver-creek' AND summary IS NULL;

-- Sources: https://www.coppercolorado.com/tickets-passes/lift-tickets/tickets/ (dynamic calendar; peak same-day adult $274 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Copper_Mountain_(Colorado) (I-70; naturally zoned beginner-to-expert layout)
UPDATE ski_resorts
SET ticket_price_usd = 274
WHERE slug = 'copper-mountain' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'I-70 Summit County resort with naturally zoned terrain from beginner west to expert east bowls.'
WHERE slug = 'copper-mountain' AND summary IS NULL;

-- Sources: https://www.winterparkresort.com/plan-your-trip/tickets-and-passes (tickets hub; peak same-day adult $287 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Winter_Park_Resort (Mary Jane; Winter Park Express from Denver)
UPDATE ski_resorts
SET ticket_price_usd = 287
WHERE slug = 'winter-park' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Fraser Valley ski area with Mary Jane moguls and Amtrak service from Denver Union Station.'
WHERE slug = 'winter-park' AND summary IS NULL;

-- Sources: https://www.steamboat.com/plan-your-trip/tickets-passes/lift-tickets (dynamic calendar; peak same-day adult $339 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Steamboat_Ski_Resort (Mount Werner; 3,668 ft vertical; Steamboat Springs)
UPDATE ski_resorts
SET ticket_price_usd = 339
WHERE slug = 'steamboat' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Northwest Colorado resort on Mount Werner above Steamboat Springs with more than 3,600 ft of vertical.'
WHERE slug = 'steamboat' AND summary IS NULL;

-- Sources: https://www.skicb.com/plan-your-trip/tickets-and-passes/tickets.aspx (Epic dynamic calendar; peak same-day adult $239 Dec 26-Jan 1 2025-26) ; https://www.vaildaily.com/news/christmas-lift-ticket-prices-colorado/ ; https://en.wikipedia.org/wiki/Crested_Butte_Mountain_Resort (Gunnison County; Headwall/High Lift extreme terrain)
UPDATE ski_resorts
SET ticket_price_usd = 239
WHERE slug = 'crested-butte' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Gunnison County ski area near Crested Butte with extreme Headwall chutes above a mining-town base.'
WHERE slug = 'crested-butte' AND summary IS NULL;

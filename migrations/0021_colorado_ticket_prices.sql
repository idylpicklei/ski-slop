-- Colorado slop resort adult full-day peak lift ticket prices (whole USD).
-- Safe UPDATEs only fill NULL ticket_price_usd and NULL summary; never overwrite a verified value.
-- Peak = highest regular adult day / walk-up window rate per docs/resort-research-guide.md.

-- Sources: https://www.arapahoebasin.com/tickets-and-passes/ (full-day tickets vary by date; no adult day rate printed) ; https://www.arapahoebasin.com/pass-benefits-26-27/ (friends-and-family discount off window rate; dollar amount unpublished) ; https://en.wikipedia.org/wiki/Arapahoe_Basin (Continental Divide; Dillon; long season). Peak walk-up NULL: official tickets page and booking store did not expose a readable adult day rate; third-party holiday figures alone are not used.
UPDATE ski_resorts
SET ticket_price_usd = NULL
WHERE slug = 'arapahoe-basin' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'High-alpine Front Range ski area on the Continental Divide above Dillon with one of Colorado''s longest seasons.'
WHERE slug = 'arapahoe-basin' AND summary IS NULL;

-- Sources: https://skiloveland.com/lift-tickets/ (2026-27 regular-season ticket-window adult $159) ; https://www.summitdaily.com/news/christmas-lift-ticket-prices-colorado/ (2025-26 holiday same-day adult $149) ; https://en.wikipedia.org/wiki/Loveland_Ski_Area (I-70; Eisenhower Tunnel; Loveland Valley)
UPDATE ski_resorts
SET ticket_price_usd = 159
WHERE slug = 'loveland' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'I-70 ski area at the Eisenhower Tunnel west of Denver with a beginner valley base and early openings.'
WHERE slug = 'loveland' AND summary IS NULL;

-- Sources: https://store.eldora.com/category/products?categoryId=112 (adult alpine day price currently $199) ; https://www.summitdaily.com/news/christmas-lift-ticket-prices-colorado/ (2025-26 peak same-day adult $199 Dec 26-Jan 1) ; https://en.wikipedia.org/wiki/Eldora_Mountain_Resort (Nederland; Nordic center; Denver access)
UPDATE ski_resorts
SET ticket_price_usd = 199
WHERE slug = 'eldora' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Nederland Front Range mountain with alpine runs and a Nordic center about an hour from Denver.'
WHERE slug = 'eldora' AND summary IS NULL;

-- Sources: https://skimonarch.com/tickets/ (2026-27 ticket-window full-day adult peak $179) ; https://www.coloradotopia.com/ski-resorts/monarch/lift-tickets/ (peak adult day rates) ; https://en.wikipedia.org/wiki/Monarch_Mountain_(ski_area) (Continental Divide; Salida; natural snow)
UPDATE ski_resorts
SET ticket_price_usd = 179
WHERE slug = 'monarch-mountain' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Independent Continental Divide ski area near Salida with all-natural snow and modest crowds.'
WHERE slug = 'monarch-mountain' AND summary IS NULL;

-- Sources: https://store.purgatory.ski/Calendar.aspx?Category=VARIABLE&Department=TICKET%3AWIN&Item=1DAY (2026-27 adult 1-day calendar; highest listed day $95 on Dec 31 2026 and Jan 1 2027 as of 10 Nov 2026) ; https://www.purgatory.ski/season-pass-faq/ (no window rate; FAQ band $9-$309 not listed on any calendar date) ; https://en.wikipedia.org/wiki/Purgatory_Resort (Durango; San Juans)
UPDATE ski_resorts
SET ticket_price_usd = 95
WHERE slug = 'purgatory' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Durango-area San Juan resort with more than 100 trails and free skiing for kids 12 and under.'
WHERE slug = 'purgatory' AND summary IS NULL;

-- Sources: https://wolfcreekski.com/tickets-passes/ (2026-27 peak adult all-day $110) ; https://wolfcreekski.com/snowreport/sr-1-1-26/ (2025-26 peak adult $105) ; https://en.wikipedia.org/wiki/Wolf_Creek_ski_area (Pagosa Springs; Continental Divide; deep snow)
UPDATE ski_resorts
SET ticket_price_usd = 110
WHERE slug = 'wolf-creek' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Southern Colorado ski area near Pagosa Springs known for deep natural snow on the Continental Divide.'
WHERE slug = 'wolf-creek' AND summary IS NULL;

-- Sources: https://silvertonmountain.com/mountain/pricing/ (guided day from $249; spring unguided $99 only) ; https://en.wikipedia.org/wiki/Silverton_Mountain (expert-only; guided season; no groomed trails). Peak walk-up NULL: main-season day product is a guided package, not a regular adult walk-up day ticket.
UPDATE ski_resorts
SET ticket_price_usd = NULL
WHERE slug = 'silverton-mountain' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Expert-only San Juan mountain near Silverton with guided lift-served terrain and no groomed trails.'
WHERE slug = 'silverton-mountain' AND summary IS NULL;

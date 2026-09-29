-- Oregon major resort adult full-day peak lift ticket prices (whole USD).
-- Safe UPDATEs only fill NULL ticket_price_usd and NULL summary; never overwrite a verified value.
-- Peak = highest regular adult day / walk-up window rate per docs/resort-research-guide.md.

-- Sources: https://www.mtbachelor.com/plan-your-trip/tickets-passes (dynamic shop calendar; no fixed adult day rate visible; ticket_price_usd left NULL) ; https://en.wikipedia.org/wiki/Mount_Bachelor_ski_area (Central Oregon volcano near Bend; 360-degree summit skiing; long NW season)
UPDATE ski_resorts
SET summary = 'Central Oregon volcano near Bend with 360-degree summit skiing and one of the Northwest''s longest seasons.'
WHERE slug = 'mount-bachelor' AND summary IS NULL;

-- Sources: https://timberlinelodge.com/mountain/lift-tickets/ (Adult 9am-Close peak $161 ages 19-64) ; https://en.wikipedia.org/wiki/Timberline_Lodge_ski_area (historic Mt. Hood lodge; Palmer snowfield; long lift season)
UPDATE ski_resorts
SET ticket_price_usd = 161
WHERE slug = 'timberline-lodge' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Historic Mt. Hood ski area above Government Camp with Palmer snowfield and North America''s longest lift season.'
WHERE slug = 'timberline-lodge' AND summary IS NULL;

-- Sources: https://www.skihood.com/product/daily-lift-tickets (dynamic calendar; no visible adult day rate; ticket_price_usd left NULL) ; https://en.wikipedia.org/wiki/Mount_Hood_Meadows (east-side Mt. Hood; largest acreage on the mountain)
UPDATE ski_resorts
SET summary = 'East-side Mount Hood resort with the mountain''s largest lift-served acreage and Pacific Crest Trail access.'
WHERE slug = 'mt-hood-meadows' AND summary IS NULL;

-- Sources: https://skibowl.com/tickets-passes/daily-lift-tickets/ (closing-weekend shift tickets only; no regular-season peak adult day chart; ticket_price_usd left NULL) ; https://en.wikipedia.org/wiki/Mount_Hood_Skibowl (west-side Mt. Hood; extensive night skiing)
UPDATE ski_resorts
SET summary = 'West-side Mount Hood day area known for North America''s most extensive night-lit ski terrain.'
WHERE slug = 'mt-hood-skibowl' AND summary IS NULL;

-- Sources: https://www.willamettepass.ski/lift-tickets/ (variable pricing; no fixed adult day rate on page; ticket_price_usd left NULL) ; https://en.wikipedia.org/wiki/Willamette_Pass_Resort (Cascade crest SE of Eugene; steep terrain)
UPDATE ski_resorts
SET summary = 'Cascade crest ski area southeast of Eugene with steep pitches and Pacific Crest Trail views.'
WHERE slug = 'willamette-pass' AND summary IS NULL;

-- Sources: https://hoodoo.com/rates/lift-tickets/ (2025-26 Adult Peak full day $89 ages 13-64) ; https://en.wikipedia.org/wiki/Hoodoo_(ski_area) (Cascades west of Sisters; night skiing)
UPDATE ski_resorts
SET ticket_price_usd = 89
WHERE slug = 'hoodoo' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Compact Cascades ski area west of Sisters with night skiing and a family-scale footprint.'
WHERE slug = 'hoodoo' AND summary IS NULL;

-- Sources: https://www.mtashland.com/lift-tickets/ (25/26 Weekend/Holiday All Lift ages 13-69 $82) ; https://en.wikipedia.org/wiki/Mount_Ashland_Ski_Area (Siskiyous above Ashland; steep bowls)
UPDATE ski_resorts
SET ticket_price_usd = 82
WHERE slug = 'mt-ashland' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Southern Oregon Siskiyou ski area above Ashland with steep bowls and quick Rogue Valley access.'
WHERE slug = 'mt-ashland' AND summary IS NULL;

-- Sources: https://anthonylakes.com/winter/day-tickets/ (Adult day ticket $55) ; https://en.wikipedia.org/wiki/Anthony_Lakes_(ski_area) (Blue Mountains; dry powder; high elevation)
UPDATE ski_resorts
SET ticket_price_usd = 55
WHERE slug = 'anthony-lakes' AND ticket_price_usd IS NULL;
UPDATE ski_resorts
SET summary = 'Northeast Oregon Blue Mountains resort known for dry powder and high-elevation alpine terrain.'
WHERE slug = 'anthony-lakes' AND summary IS NULL;

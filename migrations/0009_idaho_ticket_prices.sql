-- Idaho resort adult full-day peak lift ticket prices (whole USD).
-- Safe UPDATEs only fill NULL ticket_price_usd; never overwrite a verified price.
-- Peak = highest regular adult day / walk-up window rate per docs/resort-research-guide.md.

-- Sources: skilookout.com/lift-tickets (2025-26 holiday window adult $79) ; onthesnow.com/idaho/lookout-pass-ski-area/lift-tickets
UPDATE ski_resorts
SET ticket_price_usd = 79
WHERE slug = 'lookout-pass' AND ticket_price_usd IS NULL;

-- Sources: pebblecreekskiarea.com/tickets-passes (2025-26 adult full day $83) ; onthesnow.com/idaho/pebble-creek-ski-area/lift-tickets
UPDATE ski_resorts
SET ticket_price_usd = 83
WHERE slug = 'pebble-creek' AND ticket_price_usd IS NULL;

-- Sources: magicmountainresort.com/tickets (adult full day $49) ; onthesnow.com/idaho/magic-mountain-ski-area/lift-tickets
UPDATE ski_resorts
SET ticket_price_usd = 49
WHERE slug = 'magic-mountain' AND ticket_price_usd IS NULL;

-- Sources: pomerelle.com/reload (full day 13+ online $55 / higher $70) ; pomerelle.com (online saves $15 vs window)
UPDATE ski_resorts
SET ticket_price_usd = 70
WHERE slug = 'pomerelle' AND ticket_price_usd IS NULL;

-- Sources: losttrail.com/day-tickets (adults 13-64 full day $60 to $73 peak) ; onthesnow.com/montana/lost-trail-powder-mtn/lift-tickets
UPDATE ski_resorts
SET ticket_price_usd = 73
WHERE slug = 'lost-trail-powder-mountain' AND ticket_price_usd IS NULL;

-- Sources: silvermt.com/ski-ride/tickets (2025-26 holiday online adult $79; window higher unpublished) ; snowstash.com/usa/idaho/silver-mountain/lift-tickets
UPDATE ski_resorts
SET ticket_price_usd = 79
WHERE slug = 'silver-mountain' AND ticket_price_usd IS NULL;

-- Sources: rotarun.org/calendar-2 (adults 18+ daily $20) ; eyeonsunvalley.com/Story_Reader/13541/Rotarun-Ski-Area-to-Open-Today
UPDATE ski_resorts
SET ticket_price_usd = 20
WHERE slug = 'rotarun' AND ticket_price_usd IS NULL;

-- Sources: grangeville.us/snowhaven-facebook2/ski-tickets-and-hours-of-operation (age 7+ day pass $26) ; krem.com Snowhaven season coverage
UPDATE ski_resorts
SET ticket_price_usd = 26
WHERE slug = 'snowhaven' AND ticket_price_usd IS NULL;

-- Sources: ktvb.com Soldier Mountain opens 2025-26 (online adult $59; window +$15 => $74) ; idahonews.com Soldier Mountain opens 2025-26
UPDATE ski_resorts
SET ticket_price_usd = 74
WHERE slug = 'soldier-mountain' AND ticket_price_usd IS NULL;

-- Adult standard ski package (skis + boots + poles), one-day walk-in rate, whole USD.
-- Comparable across shops so listings can be sorted by price. NULL until researched.
ALTER TABLE ski_rentals ADD COLUMN daily_rate_usd INTEGER;

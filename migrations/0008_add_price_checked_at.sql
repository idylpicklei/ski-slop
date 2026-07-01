-- Timestamp of last successful price scrape for daily_rate_usd (ISO 8601 text).
ALTER TABLE ski_rentals ADD COLUMN price_checked_at TEXT;

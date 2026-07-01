# Skier Slop — Rental Shop Research & Pricing Guide

> **Purpose:** This is a complete, self-contained task specification for an AI model
> (any model, TBD) to **find ski/snowboard rental shops** near North American ski resorts
> and record **accurate, comparable prices** so users can sort rentals by price, plus
> **original (non-copied) descriptions**.
>
> Treat everything below as your instructions. Follow the data contract and the pricing
> rules exactly. When you are done, your output must be a single SQL migration file that
> a human can commit to this repo without editing.
>
> This guide is the rental-shop companion to
> [`docs/resort-research-guide.md`](./resort-research-guide.md). Where the two overlap
> (region slugs, originality rules, SQL formatting), the same rules apply.

---

## 1. What Skier Slop is

Skier Slop is a directory of North American ski resorts, rental shops, and gear, running
on Cloudflare (Astro site + Pages Functions API + D1 SQLite database). Rental listings
power:

- `/rentals/` — searchable list, sortable by daily rental price
- `/api/rentals/` — list endpoint with `?sort=price`
- `/api/rentals/nearest` — "rentals near me" geo search
- Each resort detail page's "Nearby rentals" section

Your job is to expand the **`ski_rentals`** table with real shops, trustworthy prices,
and original copy. **The single most valuable thing you contribute is a comparable
price** — that is what makes "sort by price" work.

---

## 2. The data contract (`ski_rentals`)

Every rental shop is one row. This is the exact schema (SQLite / Cloudflare D1):

```sql
CREATE TABLE ski_rentals (
  id                INTEGER PRIMARY KEY AUTOINCREMENT,
  slug              TEXT UNIQUE NOT NULL,   -- URL id, e.g. "christy-sports-vail"
  name              TEXT NOT NULL,          -- official shop name
  region_id         INTEGER,                -- FK -> regions.id (resolved via region slug)
  nearest_resort_id INTEGER,                -- FK -> ski_resorts.id (resolved via resort slug)
  lat               REAL NOT NULL,          -- decimal degrees, WGS84
  lng               REAL NOT NULL,          -- decimal degrees, WGS84 (negative in the Americas)
  address           TEXT,                   -- street address or "Village, ST" locality
  phone             TEXT,                   -- E.164-ish or local format, or NULL
  website           TEXT,                   -- official site (https://), or NULL
  daily_rate_usd    INTEGER,                -- COMPARABLE price, see §5 — or NULL
  source            TEXT,                   -- provenance: use 'manual' for researched entries
  summary           TEXT,                   -- ORIGINAL 1-sentence description (see §6)
  raw_json          TEXT,                   -- leave unset for researched entries
  updated_at        TEXT DEFAULT CURRENT_TIMESTAMP
);
```

### Field rules

| Field | Rule |
|-------|------|
| `slug` | lowercase, ASCII, hyphenated, globally unique. Derive from `name`; if a chain has multiple locations, append the town or resort: `christy-sports-vail`, `christy-sports-breckenridge`. |
| `name` | The shop's real, current business name. For a chain location, the chain name is fine (the slug and address disambiguate). |
| `region_id` | Do NOT hardcode. Resolve via region slug — same slug table as [`resort-research-guide.md` §3](./resort-research-guide.md). |
| `nearest_resort_id` | Do NOT hardcode. Resolve via the **resort slug** of the closest resort already in `migrations/` (see §4). If no resort in the database is within ~30 miles, insert `NULL` using the alternate template in §7. |
| `lat` / `lng` | Coordinates of the storefront (not the resort). 4–5 decimal places, longitude negative. |
| `address` | Street address if available; otherwise a locality like `'Vail Village, CO'`. |
| `phone` | From the shop's own site or Google listing. `NULL` if none. |
| `website` | The shop's own site with scheme (`https://`). Not Yelp, not TripAdvisor, not a resort's page about the shop. `NULL` if none. |
| `daily_rate_usd` | See §5 — this is the field that powers sort-by-price. |
| `source` | Use the string `'manual'` for anything you research. |
| `summary` | See §6 — must be original, never copied. |
| `raw_json`, `updated_at` | Omit; let defaults apply. |

**Golden rule for facts:** if you cannot verify a field from a credible source, set it to
`NULL`. A `NULL` is correct; a confident wrong number is a bug — and a wrong price is the
worst bug, because it mis-sorts every listing around it.

---

## 3. Avoid duplicates before you add anything

1. Read the existing entries so you know what's already covered:
   - [`migrations/0002_seed_data.sql`](../migrations/0002_seed_data.sql) (sample rentals at the bottom)
   - Any later `NNNN_*.sql` migrations in [`migrations/`](../migrations/)
2. Compute the `slug` you would use and confirm it does not already appear.
3. Treat a shop as a duplicate if a row exists with the same name at coordinates within
   ~200 m, even if the slug differs. `INSERT OR IGNORE` protects against slug collisions
   only.
4. On-mountain rental counters run by the resort itself are allowed, but name them
   distinctly (e.g. `'Schweitzer Rental Shop'`) and point `nearest_resort_id` at that
   resort.

---

## 4. How to find rental shops (accuracy first)

Goal: real, currently-operating shops that rent alpine ski and/or snowboard equipment to
the public. For each candidate, verify against **at least two independent sources**.

**Best discovery strategy — work resort-outward.** Rental shops cluster around resorts,
so pick the resorts already in `migrations/` for your target region and search around
each one:

1. **The resort's own website** — most resorts list their rental operation and partner
   shops ("rentals", "gear", "getting ready" pages). These are high-confidence leads.
2. **The shop's own website** — required for pricing (§5), and confirms it's currently
   operating (current-season rates page, hours, booking widget).
3. **OpenStreetMap** — good for storefront coordinates and discovering independents.
   Overpass query (per state/province):
   ```
   [out:json][timeout:60];
   area["ISO3166-2"="US-XX"]->.a;   /* e.g. US-ID, US-CO, CA-BC */
   ( node["shop"="ski"](area.a);
     node["shop"="sports"]["service:ski:rental"="yes"](area.a);
     way["shop"="ski"](area.a); );
   out center tags;
   ```
4. **Town/chamber directories and map listings** — use only to cross-check name,
   address, and phone; never as the sole source and never for prices.

**Accuracy checks before you accept a shop:**

- It is open and operating this season (live website with current rates, or recent
  hours/booking info). Drop shops with dead sites or "permanently closed" listings.
- It actually **rents** gear — exclude retail-only shops, tuning-only shops, and
  clothing rental.
- Coordinates land on the storefront. For chains, each location is its own row with its
  own coordinates and (often) its own prices.
- The nearest resort you link is genuinely the closest one in the database.

**Batch size:** cover a region's resorts systematically (e.g. "every rental shop serving
Idaho's resorts"). 10 verified shops with prices beat 40 without.

---

## 5. Pricing — the field that makes sorting work

`daily_rate_usd` must mean the **same thing for every row**, or sorting by price is
meaningless. The canonical definition:

> **The adult, standard-tier ski package (skis + boots + poles), for one day, at the
> walk-in/standard rate, in whole US dollars.**

### Hard rules

- **Standard/base tier only.** Shops tier their fleets (sport / performance / demo /
  premium). Always record the **cheapest adult full ski package**. Do not record demo,
  performance, or premium tiers, even if featured more prominently.
- **Full package, not à la carte.** If the shop only prices skis, boots, and poles
  separately, sum the three and note `(sum of separates)` in the `-- Sources:` comment.
- **One day, walk-in.** Multi-day rates are cheaper per day — do not average them. If
  the shop only shows discounted online-booking prices, use the online price and note
  `(online rate)` in the sources comment.
- **Adult price.** Never junior/kid/senior rates.
- **Whole USD**, bare number: `52`, never `'$52'` or `52.00`. Round half up.
- **Canadian shops:** convert the CAD price to USD at the current exchange rate, round
  to a whole number, and record the original CAD price in the `-- Sources:` comment,
  e.g. `(C$79 ≈ $58 USD)`.
- **Snowboard-only shops:** use the adult standard snowboard+boots package instead and
  note `(snowboard pkg)` in the sources comment.
- **Source: the shop's own rates/booking page only.** Aggregators, blog posts, and
  resort pages about a partner shop are often a season stale. If the shop publishes no
  prices anywhere official, set `NULL` — never guess, never copy a competitor's price.
- **Current or most recent season** rates only.

### Price provenance

Every row's `-- Sources:` comment must make the price auditable: include the URL of the
rates page you read and any conversion/summation note. Example:

```
-- Sources: christysports.com/vail (rates: sport pkg $62/day) ; en OSM node 1234567
```

---

## 6. Writing the `summary` — accurate and not copied

The same originality rules as [`resort-research-guide.md` §6](./resort-research-guide.md)
apply verbatim: compose one fresh sentence from verified facts; never lift or lightly
reword a shop's marketing copy; no run of ~6+ consecutive words matching any source; no
slogans, superlatives, exclamation marks, or first person.

**House voice for rentals** — one factual sentence, ~80–160 characters, that tells a
skier what the shop is and why they'd pick it. Lead with location relative to the
resort/village, then a concrete differentiator (overnight fitting, slopeside pickup,
delivery, demo fleet, budget pricing, boot fitting):

Good (target style):
- "Full-service ski and snowboard rental in the heart of Vail Village."
- "Budget-friendly package rentals a five-minute drive from the Schweitzer village."
- "Boot-fitting specialist near the Park City base with overnight ski storage."

Bad:
- "The best rental experience in Colorado!" (marketing, superlative, exclamation)
- "We offer a wide range of equipment for all your needs." (copied-brochure voice, first person, no facts)

---

## 7. Output format — a ready-to-commit SQL migration

Produce **one** SQL file. Do not modify existing migrations. Name it with the next
unused 4-digit prefix and a short suffix, e.g. `0007_idaho_rentals.sql`.

The `region_id` and `nearest_resort_id` are resolved by slug in the `FROM` clause.
**Standard template (shop near a known resort):**

```sql
-- <Region> ski rental shops — researched, priced, original descriptions.
-- Each entry verified against >=2 sources; price from the shop's own rates page.

-- Sources: <shop rates page URL> (rates note) ; <source B>
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT '<slug>', '<Name>', reg.id, res.id, <lat>, <lng>, '<address|NULL>', '<phone|NULL>', '<https://…|NULL>', <daily_rate_usd|NULL>, 'manual',
  '<original one-sentence summary>'
FROM regions reg, ski_resorts res WHERE reg.slug = '<region-slug>' AND res.slug = '<resort-slug>';
```

**Alternate template (no resort within ~30 miles in the database):**

```sql
-- Sources: <source A> ; <source B>
INSERT OR IGNORE INTO ski_rentals (slug, name, region_id, nearest_resort_id, lat, lng, address, phone, website, daily_rate_usd, source, summary)
SELECT '<slug>', '<Name>', id, NULL, <lat>, <lng>, '<address|NULL>', '<phone|NULL>', '<https://…|NULL>', <daily_rate_usd|NULL>, 'manual',
  '<original one-sentence summary>'
FROM regions WHERE slug = '<region-slug>';
```

### SQL formatting requirements

- **Escape single quotes** by doubling them: `Bob's Skis` → `'Bob''s Skis'`.
- Use `NULL` (no quotes) for unknown `address`, `phone`, `website`, or `daily_rate_usd`.
- `daily_rate_usd` is a bare whole number (`52`), never quoted, never with cents.
- The `res.slug` you join on must exist in `migrations/` — check first. If it does not,
  use the alternate template; do not invent a resort.
- Keep `source` as `'manual'`.
- A `-- Sources:` comment above each entry with 2+ references, including the rates page
  and any price note (tier, conversion, summation).
- One blank line between entries. UTF-8, no BOM. No transactions, no `CREATE TABLE`.

---

## 8. How the human applies your output

For reference (you do not run these — the maintainer does):

```bash
# validate locally first
npx wrangler d1 migrations apply ski-slop-db --local
# then production
npx wrangler d1 migrations apply ski-slop-db --remote
```

`INSERT OR IGNORE` means re-running is safe: existing slugs are skipped.

---

## 9. Final checklist (self-verify before returning output)

Facts & scope:
- [ ] Every shop is real, currently operating, and rents alpine ski/snowboard gear.
- [ ] `lat`/`lng` land on the storefront; each chain location is its own row.
- [ ] `nearest_resort_id` joins on a resort slug that exists in `migrations/`, or the
      `NULL` template is used.
- [ ] No duplicates vs existing migrations (checked by slug, name, and coordinates).

Prices:
- [ ] Every `daily_rate_usd` is the adult **standard** ski package, **one day**,
      walk-in, whole USD — or `NULL` if the shop publishes no prices.
- [ ] Every price traces to the shop's own rates page cited in `-- Sources:`.
- [ ] CAD conversions, snowboard-only packages, and summed à-la-carte prices are noted
      in the sources comment.

Descriptions:
- [ ] Each `summary` is one original sentence, ~80–160 chars, house voice, no marketing.
- [ ] No run of ~6+ consecutive words matches any single source.

Output:
- [ ] Single SQL file, next `NNNN_` prefix, matching the §7 templates exactly.
- [ ] All single quotes doubled; `NULL` unquoted; `source = 'manual'`.

---

## 10. Quick copy-paste task prompt

> You are adding ski rental shops in Idaho to the Skier Slop database. Read
> `docs/rental-research-guide.md` in this repo and follow it exactly. Find
> currently-operating ski/snowboard rental shops serving the resorts of **<REGION(S)>**
> that are not already present in the `migrations/` folder. For each, verify facts
> against at least two credible sources, record the adult standard one-day ski package
> price from the shop's own rates page (`daily_rate_usd`, whole USD), link the nearest
> resort by slug, and write one original, non-copied summary sentence in the house
> voice. Return a single ready-to-commit SQL migration file named
> `NNNN_<region>_rentals.sql` using the `INSERT OR IGNORE ... SELECT ... FROM regions
> reg, ski_resorts res WHERE ...` pattern, with a `-- Sources:` comment above each
> entry. Do not edit existing files.

# Ski Slop — Resort Research & Description Guide

> **Purpose:** This is a complete, self-contained task specification for an AI model
> (any model, TBD) to **find new ski resorts** in North America and write **accurate,
> original (non-copied) descriptions** that drop directly into the Ski Slop database.
>
> Treat everything below as your instructions. Follow the data contract and the
> originality rules exactly. When you are done, your output must be a single SQL
> migration file that a human can commit to this repo without editing.

---

## 1. What Ski Slop is

Ski Slop is a directory of North American ski resorts, rental shops, and gear, running
on Cloudflare (Astro site + Pages Functions API + D1 SQLite database). Resort listings
power:

- `/resorts/` — searchable list, filterable by region
- `/resorts/{slug}/` — a detail page per resort
- `/api/resorts/nearest` — "resorts near me" geo search

Your job is to expand and improve the **`ski_resorts`** table with real resorts and
trustworthy, original copy.

---

## 2. The data contract (`ski_resorts`)

Every resort is one row. This is the exact schema (SQLite / Cloudflare D1):

```sql
CREATE TABLE ski_resorts (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  slug          TEXT UNIQUE NOT NULL,   -- URL id, e.g. "sun-valley"
  name          TEXT NOT NULL,          -- official resort name
  region_id     INTEGER,                -- FK -> regions.id (resolved via region slug, see §3)
  lat           REAL NOT NULL,          -- decimal degrees, WGS84
  lng           REAL NOT NULL,          -- decimal degrees, WGS84 (negative in the Americas)
  elevation_ft  INTEGER,                -- SUMMIT elevation in feet, or NULL if unknown
  trail_count   INTEGER,                -- number of named runs/trails, or NULL if unknown
  website       TEXT,                   -- official homepage (https://), or NULL
  source        TEXT,                   -- provenance: use 'manual' for researched entries
  summary       TEXT,                   -- ORIGINAL 1-sentence description (see §6)
  raw_json      TEXT,                   -- leave unset for researched entries
  updated_at    TEXT DEFAULT CURRENT_TIMESTAMP
);
```

### Field rules

| Field | Rule |
|-------|------|
| `slug` | lowercase, ASCII, words joined by hyphens, no punctuation. Derive from `name`: lowercase → replace any run of non-alphanumeric chars with `-` → trim leading/trailing `-`. Example: `"Taos Ski Valley"` → `taos-ski-valley`. Must be globally unique across ALL regions. |
| `name` | The resort's real, current official name. Prefer the operator's own spelling. If recently renamed (e.g. Squaw Valley → Palisades Tahoe), use the current name. |
| `region_id` | Do NOT hardcode a number. Resolve it at insert time from the region `slug` (see the SQL template in §7). |
| `lat` / `lng` | Coordinates of the base area / main lodge. 4–5 decimal places. Longitude is **negative** in the US and Canada. Sanity-check they fall inside the claimed region. |
| `elevation_ft` | **Summit** elevation, in feet (not base, not vertical drop). Convert meters → feet with `× 3.28084` and round to a whole number. `NULL` if you cannot verify it. |
| `trail_count` | Count of trails/runs the resort advertises. `NULL` if unknown. Never guess a number. |
| `website` | Official site only, with scheme (`https://`). Not a booking aggregator, not a Wikipedia/OnTheSnow link. `NULL` if the resort has no site. |
| `source` | Use the string `'manual'` for anything you research (keeps it distinct from OSM-imported rows, which use `'osm'`). |
| `summary` | See §6 — this is the part that must be original. |
| `raw_json`, `updated_at` | Omit; let defaults apply. |

**Golden rule for facts:** if you cannot verify a numeric field from a credible source,
set it to `NULL`. A `NULL` is correct; a confident wrong number is a bug.

---

## 3. Region slugs (for `region_id` lookup)

A resort's `region_id` is resolved from one of these region slugs. Use the slug for the
US state or Canadian province the resort physically sits in. (Source of truth:
[`shared/regions-data.ts`](../shared/regions-data.ts).)

| Slug | Region | Slug | Region |
|------|--------|------|--------|
| `us-ak` | Alaska | `us-nc` | North Carolina |
| `us-az` | Arizona | `us-nh` | New Hampshire |
| `us-ca` | California | `us-nm` | New Mexico |
| `us-co` | Colorado | `us-ny` | New York |
| `us-ct` | Connecticut | `us-or` | Oregon |
| `us-id` | Idaho | `us-pa` | Pennsylvania |
| `us-ma` | Massachusetts | `us-ut` | Utah |
| `us-me` | Maine | `us-vt` | Vermont |
| `us-mi` | Michigan | `us-wa` | Washington |
| `us-mn` | Minnesota | `us-wi` | Wisconsin |
| `us-mt` | Montana | `us-wv` | West Virginia |
| `us-al` | Alabama | `us-wy` | Wyoming |
| `ca-ab` | Alberta | `ca-nl` | Newfoundland and Labrador |
| `ca-bc` | British Columbia | `ca-ns` | Nova Scotia |
| `ca-mb` | Manitoba | `ca-on` | Ontario |
| `ca-nb` | New Brunswick | `ca-qc` | Quebec |
| | | `ca-sk` | Saskatchewan |

If a resort is in a region not listed here, STOP and flag it in your output as a comment
(the human will add the region first). Do not invent a slug.

---

## 4. Avoid duplicates before you add anything

You must not re-add resorts that already exist. Before proposing a resort:

1. Read the existing entries so you know what's already covered:
   - [`migrations/0002_seed_data.sql`](../migrations/0002_seed_data.sql) (flagship resorts)
   - [`migrations/0003_idaho_resorts.sql`](../migrations/0003_idaho_resorts.sql) (Idaho set)
   - Any later `NNNN_*.sql` migrations in [`migrations/`](../migrations/)
   - [`shared/resorts-seed.ts`](../shared/resorts-seed.ts)
2. Compute the `slug` you would use and confirm it does not already appear.
3. Also treat a resort as a duplicate if a row already exists with the **same name** or
   coordinates within ~1 km, even if the slug differs. The `INSERT OR IGNORE` in the
   template protects against slug collisions, but you should still avoid near-duplicates
   (e.g. `taos` vs `taos-ski-valley`).

When in doubt, prefer the operator's current official name for both `name` and `slug`.

---

## 5. How to find new resorts (accuracy first)

Goal: real, currently-operating, lift-served public ski areas. For each candidate,
gather facts from **at least two independent, credible sources** and cross-check them.

**Preferred sources (most authoritative first):**

1. The resort's **official website** — for name, website, and often trail count.
2. **OpenStreetMap** (`leisure=ski_resort`) — good for coordinates. Overpass query:
   ```
   [out:json][timeout:60];
   area["ISO3166-2"="US-XX"]->.a;   /* e.g. US-VT, CA-BC */
   ( node["leisure"="ski_resort"](area.a);
     way["leisure"="ski_resort"](area.a); );
   out center tags;
   ```
3. **Wikipedia** / regional ski associations / state tourism boards — for elevation,
   vertical, history. Use them as **facts to verify**, never as text to copy.

**Accuracy checks before you accept a resort:**

- It is open and operating (not permanently closed, not a proposed/defunct area). If
  you cannot confirm current operation, drop it.
- It is a public, lift-served alpine area (exclude private clubs, pure Nordic/cross-country
  centers, terrain parks with no lifts, and backcountry-only zones — unless notable and
  clearly labeled).
- Coordinates land on the actual base area and inside the claimed region.
- Elevation and trail counts agree across your sources; if they conflict and you can't
  resolve it, set that field to `NULL`.

**Batch size:** aim for a coherent set (e.g. "all lift-served resorts in Oregon"). Quality
over quantity — 8 verified resorts beat 30 shaky ones.

---

## 6. Writing the `summary` — ACCURATE and NOT COPIED

This is the most important rule in this document. The `summary` must be **your own original
sentence built from verified facts** — never text lifted or lightly reworded from a website,
Wikipedia, brochure, or review site.

### What "not copied" means (hard rules)

- **Do not copy or paraphrase sentences.** Start from a list of facts (location, vertical,
  terrain character, notable feature) and compose a fresh sentence from those facts.
- **No marketing copy.** Never reuse a resort's slogan, tagline, or promotional phrasing
  ("world-class", "something for everyone", "winter wonderland", "premier destination").
- **Facts aren't copyrightable; expression is.** You may state that a resort has 2,500 ft of
  vertical. You may not reuse the sentence a source used to say it.
- **Plagiarism self-check:** before finalizing, confirm no run of ~6+ consecutive words
  matches any single source. If it does, rewrite.
- **Two-source synthesis:** the sentence should reflect facts you confirmed in 2+ sources,
  combined in your own words. This naturally avoids copying any one of them.

### Style (match the existing house voice)

Existing summaries are one factual, place-anchored sentence with no fluff. Match this:

Good (existing rows — use as your target style):
- "North Idaho's largest ski area with views of three states, Lake Pend Oreille, and Canada."
- "Boise's local ski hill with night skiing and affordable access from the Treasure Valley."
- "Steep terrain above Pocatello with deep snow and minimal crowds."

**Rules for your summaries:**

- **One sentence**, roughly **90–170 characters**. No trailing period is fine (match rows above).
- Lead with what makes it distinct: location/landmark, size, terrain character, or a
  verifiable notable feature (e.g. longest season, a famous run, night skiing, tram).
- Concrete over generic. "1,600 ft of vertical above Lake Champlain" beats "great skiing."
- Neutral, informative tone — like a knowledgeable local, not an ad.
- No superlatives you can't back up. "One of the largest" is fine only if verifiable.
- American English. Spell out the region/landmark so it reads well on the detail page.
- No emojis, no exclamation marks, no first person, no calls to action.

### Good vs bad

| Bad (why) | Good |
|-----------|------|
| "A world-class resort with something for every skier!" (marketing, generic, exclamation) | "Wasatch resort known for light, dry powder and quick access from Salt Lake City." |
| "Nestled in the heart of the Green Mountains, offering an unforgettable experience." (copied-brochure voice, no facts) | "Green Mountain resort with 2,000+ ft of vertical and a long lift-served season." |
| "Whitefish Mountain Resort is a ski resort in Montana." (says nothing) | "Northwest Montana resort above Whitefish Lake, known for tree skiing and frequent fog-frosted 'snow ghosts'." |

---

## 7. Output format — a ready-to-commit SQL migration

Produce **one** SQL file. Do not modify existing migrations. Name it with the next unused
4-digit prefix (current highest is `0003`, so the next is typically `0004`) and a short
descriptive suffix, e.g. `0004_oregon_resorts.sql`.

Follow this exact pattern (matches [`migrations/0003_idaho_resorts.sql`](../migrations/0003_idaho_resorts.sql)).
Note the `region_id` is resolved by the `SELECT ... FROM regions WHERE slug = '...'`:

```sql
-- <Region> ski resorts — researched, original descriptions.
-- Each entry verified against >=2 sources (cited in the comment above it).

-- Sources: skibachelor.com ; en.wikipedia.org/wiki/Mount_Bachelor_ski_area
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT 'mount-bachelor', 'Mount Bachelor', id, 43.9793, -121.6884, 9065, 121, 'https://www.mtbachelor.com', 'manual',
  'Central Oregon volcano offering 360-degree summit skiing and one of the Northwest''s longest seasons.'
FROM regions WHERE slug = 'us-or';

-- Sources: <source A> ; <source B>
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT '<slug>', '<Name>', id, <lat>, <lng>, <elevation_ft|NULL>, <trail_count|NULL>, '<https://…|NULL>', 'manual',
  '<original one-sentence summary>'
FROM regions WHERE slug = '<region-slug>';
```

### SQL formatting requirements

- **Escape single quotes** in any text by doubling them: `O'Reilly` → `'O''Reilly'`,
  `Northwest''s`. This is the #1 cause of broken migrations.
- Use `NULL` (no quotes) for unknown `elevation_ft`, `trail_count`, or `website`.
- Keep `source` as `'manual'`.
- Put a `-- Sources: …` comment line directly above each `INSERT` listing the URLs/works
  you verified it against. This keeps provenance in git without changing the schema.
- One blank line between entries. UTF-8, no BOM.
- Do not wrap the file in a transaction or add `CREATE TABLE`; only `INSERT OR IGNORE`
  statements plus comments.

---

## 8. How the human applies your output

For reference (you do not run these — the maintainer does):

```bash
# validate locally first
npx wrangler d1 migrations apply ski-slop-db --local
# then production
npx wrangler d1 migrations apply ski-slop-db --remote
```

`INSERT OR IGNORE` means re-running is safe: existing slugs are skipped, so a partial or
repeated apply won't error or duplicate rows.

---

## 9. Final checklist (self-verify before returning output)

Facts & scope:
- [ ] Every resort is real, currently operating, public, and lift-served.
- [ ] Each resort's `region-slug` is from the table in §3 and matches its physical location.
- [ ] `lat`/`lng` are decimal degrees, longitude negative, and fall inside the region.
- [ ] `elevation_ft` is the **summit** in feet (converted from meters if needed) or `NULL`.
- [ ] `trail_count` verified or `NULL`. `website` is the official site or `NULL`.
- [ ] No duplicates vs existing migrations / seed (checked by slug, name, and coordinates).

Descriptions:
- [ ] Each `summary` is one original sentence, ~90–170 chars, house voice, no marketing.
- [ ] No run of ~6+ consecutive words matches any single source (plagiarism check passed).
- [ ] Every distinctive claim (size, vertical, "longest season", etc.) is verifiable.

Output:
- [ ] Single SQL file, next `NNNN_` prefix, `INSERT OR IGNORE ... SELECT ... FROM regions`.
- [ ] All single quotes doubled; `NULL` unquoted; `source = 'manual'`.
- [ ] A `-- Sources:` comment with 2+ references above each entry.
- [ ] Any resort in an unlisted region is flagged as a comment, not invented.

---

## 10. Quick copy-paste task prompt

> You are adding ski resorts to the Ski Slop database. Read
> `docs/resort-research-guide.md` in this repo and follow it exactly. Find
> currently-operating, lift-served public ski resorts in **<REGION(S)>** that are not
> already present in the `migrations/` folder. For each, verify facts against at least two
> credible sources and write one original, non-copied summary sentence in the house voice.
> Return a single ready-to-commit SQL migration file named `NNNN_<region>_resorts.sql`
> using the `INSERT OR IGNORE ... SELECT ... FROM regions WHERE slug = '...'` pattern,
> with a `-- Sources:` comment above each entry. Do not edit existing files.

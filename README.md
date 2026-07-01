# Skier Slop

North America's ski directory — resorts, rentals, and gear. Built on Cloudflare Pages with D1 SQL and production Cloudflare Agents for automated data enrichment.

## Stack

- **Frontend:** Astro (static) on Cloudflare Pages
- **API:** Pages Functions (`functions/api/`)
- **Database:** Cloudflare D1 (SQLite)
- **Agents:** Cloudflare Agents SDK + Workers AI + Queues + Cron

## Prerequisites

- Node.js 22+ (required by Wrangler 4.106+)
- Cloudflare account
- [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/) v4+

## Quick start

```bash
npm install

# Create D1 database (first time only — copy database_id into wrangler.jsonc)
npm run db:create

# Apply migrations locally
npm run db:migrate:local

# Astro only (no API / D1)
npm run dev

# Full stack: static site + API + local D1
cp .dev.vars.example .dev.vars
npm run dev:pages
```

## Cloudflare Workers Builds (dashboard settings)

If deploying via **Workers & Pages → ski-slop → Settings → Builds**:

| Setting | Value |
|---------|--------|
| Build command | `npm run build` |
| **Deploy command** | `npm run deploy:ci` |
| Root directory | `/` |
| **Build variable** | `NODE_VERSION` = `22` |

Do **not** use `wrangler pages deploy` — this project deploys as a **Worker with static assets**.

- **Deploy command:** `npm run deploy:ci`

## Fix authentication error [10000]

This almost always means the **build API token lacks permissions**, not that the account ID is wrong.

### 1. Remove conflicting build variables

In **Settings → Builds → Build variables**, **delete** these if you added them manually:

- `CLOUDFLARE_API_TOKEN` (unless you created a custom token on purpose)
- `CLOUDFLARE_ACCOUNT_ID` (now set in `wrangler.jsonc` instead)

A wrong or empty `CLOUDFLARE_API_TOKEN` overrides the build token and causes auth failures.

### 2. Create a custom API token with D1 access

The auto-generated build token often **does not include D1**. This project binds D1, so you need a custom token:

1. [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens) → **Create Token** → **Custom token**
2. Permissions:
   - **Account → Workers Scripts → Edit**
   - **Account → D1 → Edit**
   - **Account → Workers Queues → Edit**
   - **Account → Workers AI → Read**
   - **Account → Account Settings → Read**
3. Account resources: **Include → your account**
4. In **ski-slop → Settings → Builds → API token**, select this new token (or paste as `CLOUDFLARE_API_TOKEN` secret)

### 3. Regenerate if the token was rolled

If the token was edited or rolled, create a new one and re-select it in Build settings.

## Deploy

### One-time setup

```bash
npm run db:create
# Update database_id in wrangler.jsonc
npm run db:migrate:remote
# Only if the queue does not exist yet:
npm run queues:create
```

### Cloudflare Workers Builds (dashboard)

| Setting | Value |
|---------|--------|
| Build command | `npm run build` |
| Deploy command | `npm run deploy:ci` |

Or deploy manually:

```bash
npm run deploy:pages
```

### Secrets

**Cloudflare Workers Builds** uses the build token in the dashboard (see above).

**GitHub Actions** (`.github/workflows/deploy.yml`) needs these repository secrets:

| Secret | Value |
|--------|--------|
| `CLOUDFLARE_API_TOKEN` | API token with Workers Scripts, D1, Queues, Workers AI, Account Read |
| `CLOUDFLARE_ACCOUNT_ID` | `c537fdc75bc4ff82c03a0744a319875c` |

Add them at **GitHub repo → Settings → Secrets and variables → Actions → New repository secret**.

Use **either** Cloudflare Workers Builds **or** GitHub Actions for deploy — not both on every push.

```bash
echo "your-secret" | wrangler secret put ADMIN_TOKEN
```

```bash
curl -X POST https://your-site.pages.dev/api/admin/enqueue \
  -H "Authorization: Bearer your-secret" \
  -H "Content-Type: application/json" \
  -d '{"regionSlug":"us-co","type":"both"}'
```

## Idaho resort agent

The **ResortEnrichmentAgent** scans OpenStreetMap across Idaho (`us-id`), normalizes results with Workers AI, and saves them to D1. Listings appear on:

- [/idaho/](https://your-site/idaho/) — Idaho landing page
- [/resorts/?region=us-id](https://your-site/resorts/?region=us-id) — filterable list
- `/resorts/{slug}/` — dynamic detail pages for agent-discovered resorts

### Run the Idaho scan

1. Set the admin secret on your Worker:
   ```bash
   echo "your-secret" | wrangler secret put ADMIN_TOKEN
   ```

2. Apply migrations (includes extra Idaho seed resorts):
   ```bash
   npm run db:migrate:remote
   ```

3. Trigger the agent (replace `SITE` with your deployed URL):
   ```bash
   set ADMIN_TOKEN=your-secret
   set SITE=https://ski-slop.YOUR_SUBDOMAIN.workers.dev
   npm run enrich:idaho
   ```

   Or with curl:
   ```bash
   curl -X POST "$SITE/api/admin/enqueue" \
     -H "Authorization: Bearer $ADMIN_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"regionSlug":"us-id","type":"both"}'
   ```

4. Check progress:
   ```bash
   curl "$SITE/api/regions/us-id"
   ```

The agent queries the full **US-ID** boundary in OpenStreetMap, then queues a rental scan for the same region.

## Adding resorts with an AI model

To hand resort research off to any AI model, point it at
[`docs/resort-research-guide.md`](docs/resort-research-guide.md). That file is a complete,
self-contained spec: it defines the `ski_resorts` data contract, region slugs, how to find
and verify real resorts, strict rules for writing **original (non-copied)** descriptions,
and the exact `INSERT OR IGNORE` migration format to return. The model's output is a
ready-to-commit `migrations/NNNN_<region>_resorts.sql` file.

For rental shops, use [`docs/rental-research-guide.md`](docs/rental-research-guide.md)
instead. It follows the same pattern but adds strict pricing rules: every shop records a
comparable `daily_rate_usd` (adult standard one-day ski package) so `/rentals/` and
`/api/rentals/?sort=price` can sort listings by price. Resort detail pages use
`?sort=value` (price + $2/mi travel) for best-value nearby rentals.

A future **Deal Scanner Agent** will refresh prices automatically — see
[`docs/deal-scanner-agent.md`](docs/deal-scanner-agent.md). Enqueue with
`POST /api/admin/enqueue` and `"type": "deal"` (stub logs to `agent_runs` today).

## API endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/resorts` | List/search resorts (`?region=`, `?q=`) |
| GET | `/api/resorts/nearest` | Nearest resorts (`?lat=&lng=`) |
| GET | `/api/resorts/:slug` | Resort detail + nearby rentals |
| GET | `/api/rentals` | List rentals |
| GET | `/api/rentals/nearest` | Nearest rentals |
| GET | `/api/products` | List products |
| POST | `/api/admin/enqueue` | Queue region enrichment (auth required) |
| POST | `/api/admin/regions/:slug/reset` | Reset region scan status (auth required) |
| GET | `/api/regions/:slug` | Region stats + resort list |
| GET | `/resorts/:slug` | HTML resort detail (agent-populated) |

## Project structure

```
src/           Astro pages and layouts
functions/     Pages Functions API
workers/       Agent worker (resort + rental enrichment)
migrations/    D1 SQL migrations
shared/        Shared types, seed data, utilities
scripts/       Seed SQL generator
```

## License

MIT

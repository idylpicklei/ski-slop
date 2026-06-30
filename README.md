# Ski Slop

North America's ski directory — resorts, rentals, and gear. Built on Cloudflare Pages with D1 SQL and production Cloudflare Agents for automated data enrichment.

## Stack

- **Frontend:** Astro (static) on Cloudflare Pages
- **API:** Pages Functions (`functions/api/`)
- **Database:** Cloudflare D1 (SQLite)
- **Agents:** Cloudflare Agents SDK + Workers AI + Queues + Cron

## Prerequisites

- Node.js 18+
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

# Full stack: static site + Pages Functions + local D1
cp .dev.vars.example .dev.vars
npm run dev:pages
```

> **Note:** This is a **Cloudflare Pages** project. Do not run bare `wrangler dev` or
> `wrangler deploy` — use `npm run dev:pages`, `npm run deploy:pages`, and
> `npm run deploy:agents` instead.

## Deploy

### 1. D1 database

```bash
npm run db:create
# Update database_id in wrangler.jsonc and wrangler.agents.jsonc
npm run db:migrate:remote
```

### 2. Agent worker (deploy first)

```bash
# Create queue in Cloudflare dashboard or via wrangler
wrangler queues create ski-slop-enrichment

npm run deploy:agents
```

### 3. Cloudflare Pages

Connect the GitHub repo (`idylpicklei/ski-slop`) in the Cloudflare dashboard:

- **Build command:** `npm run build`
- **Build output:** `dist`
- **Root directory:** `/`

Or deploy manually:

```bash
npm run deploy:pages
```

### 4. Secrets

```bash
echo "your-secret" | wrangler pages secret put ADMIN_TOKEN --project-name=ski-slop
echo "your-secret" | wrangler secret put ADMIN_TOKEN -c wrangler.agents.jsonc
```

### 5. Trigger enrichment (admin)

```bash
curl -X POST https://your-site.pages.dev/api/admin/enqueue \
  -H "Authorization: Bearer your-secret" \
  -H "Content-Type: application/json" \
  -d '{"regionSlug":"us-co","type":"both"}'
```

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

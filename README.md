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

```bash
echo "your-secret" | wrangler secret put ADMIN_TOKEN
```

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

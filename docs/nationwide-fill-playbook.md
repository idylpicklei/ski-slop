# Nationwide fill playbook

Fill the US ski directory with capped cloud-agent jobs that spend tokens on prices, not on context. Idaho (`us-id`) and the two research guides are the template. Each future state job is a copy-paste prompt from the templates at the end of this page. You launch the job, review the migration PR, and apply the migration yourself.

## Three-tier pipeline

Each tier is its own job with its own budget. Never mix tiers in one prompt.

1. **Skeleton (cheap).** Name, slug, lat, lng, region, and website. Sources are OpenStreetMap, state ski association lists, and the enrich agents in `workers/agents/`. No prices in this tier.
2. **Comparable prices (the token budget).** Adult peak `ticket_price_usd` for resorts, adult standard one-day ski package `daily_rate_usd` for rentals, and original summaries. The agent delivers SQL migrations that follow `docs/resort-research-guide.md` and `docs/rental-research-guide.md`. This tier is where the tokens go.
3. **Freshness (later).** The Deal Scanner refreshes `daily_rate_usd` on a schedule. It is not implemented. The queue stub in `workers/agents/index.ts` records a failed run with "DealScannerAgent not implemented yet". See `docs/deal-scanner-agent.md`.

## Region ship bar

A skeleton alone is not a finished region for a directory site. A region page with names but no prices, no summaries, and no rentals gives a skier nothing to compare. Majors are the region's destination resorts, not its town hills. Before you call a region usable, check that each major has the following:

- a filled `ticket_price_usd`, or an explicit `NULL` with a `-- Sources:` comment that says why
- an original summary
- at least one rental nearby

Run the templates as one loop per region. After template 1 lands, run template 2 for the region's majors. Template 2 fills tickets and missing summaries. Then run template 3 for the same slugs. Finish that loop before you move to another region you care about.

## Token rules

- Work one region at a time.
- Do resorts before rentals. Rental rows join on `ski_resorts.slug`, so the resort rows must exist first.
- Do big hills first. More users look up a destination resort than a town hill, so its price is worth more per token.
- Reuse the research guides as the prompt. Name the guide and let the agent read it. Do not paste the schema, the region table, or old migrations into the prompt.
- Batch writes in one migration per job. Use `INSERT OR IGNORE` for new rows and `UPDATE ... SET ticket_price_usd = ? WHERE slug = ? AND ticket_price_usd IS NULL` for prices. Both are safe to re-run.
- Never re-research a filled price. A non-NULL `ticket_price_usd` or `daily_rate_usd` is done until the freshness tier exists.
- Prefer `NULL` to a guess. Dynamic pricing calendars are the usual trap. If no regular adult day rate is visible, leave the field `NULL`.
- Do not treat enrich-agent output as price truth. The agents find resorts and shops and fill skeleton fields. A price comes only from the operator's own rates page, cited in a `-- Sources:` comment.
- Cap every job. "Top 10 missing tickets in `us-xx`" and "rentals for these six resort slugs" are caps. "Research Colorado" is not.
- Gate the merge yourself. Read the migration. Spot-check two prices against the cited pages. Then merge.
- Apply migrations yourself. Run `npm run db:migrate:local`, check `/resorts/?region=us-xx` under `npm run dev:pages`, then run `npm run db:migrate:remote` as its own step. Agents never run the remote step.

## Rollout order

1. Build the skeleton for a US region. Run `scripts/enrich-region.mjs us-xx` (needs `ADMIN_TOKEN` and `SITE`) or launch template 1. Run the enrich agent before any price job for that region. Its upsert in `workers/agents/tools/d1.ts` overwrites `summary`, `name`, `lat`, and `lng` on a slug collision and leaves `ticket_price_usd` and `daily_rate_usd` alone. The skeleton may land first. The next jobs for that region are template 2 and then template 3 for its majors. Run both before you move to another region you care about.
2. Price the top 50 to 100 national day-trip resorts. Use template 2 in batches of about 10 slugs, the size of `0009_idaho_ticket_prices.sql`. One migration per batch.
3. Fill rentals around those resorts. Use template 3, resort-outward, a few resorts per job.
4. Move to the next tier of hills. Repeat steps 2 and 3 with smaller resorts.
5. Do Canada last, with the same pipeline. The guides already cover CAD to USD conversion.

Idaho (`us-id`) is the worked example. Migrations `0003` through `0010` run the pipeline in order:

| Migration | Tier | Change |
|---|---|---|
| `0003_idaho_resorts.sql`, `0004_idaho_resorts.sql` | Skeleton | Insert resorts and summaries with `INSERT OR IGNORE`, no prices |
| `0005_add_ticket_price.sql`, `0006_add_rental_rate.sql` | Schema | Add `ticket_price_usd` and `daily_rate_usd` |
| `0007_idaho_rentals.sql` | Prices | Insert priced rental shops resort-outward |
| `0008_add_price_checked_at.sql` | Schema | Add `price_checked_at` for the freshness tier |
| `0009_idaho_ticket_prices.sql` | Prices | Fill `ticket_price_usd` with `UPDATE ... WHERE ticket_price_usd IS NULL` |
| `0010_idaho_rentals_gaps.sql` | Prices | Add rentals for the resorts `0007` missed |

## Anti-pattern

Do not launch one "research North America" agent. It spends the budget on skeleton facts, mixes tiers, and returns a migration too large to review. Every job covers one region, one tier, and one capped list, and returns one migration PR.

## Agent prompt templates

Copy a block, replace the angle-bracket placeholders, and launch. Each template names the guide to follow, asks for one migration PR, and lists what is out of scope.

### 1. Skeleton gap audit for a region

```text
Skeleton gap audit for <REGION> (region slug us-xx) in the Skier Slop repo.

Read docs/resort-research-guide.md. Follow its slug, region, duplicate, and SQL rules.
Skip section 6 and skip prices. This is a cheap skeleton pass.

Find every currently operating, lift-served public ski area in us-xx that has no row
in migrations/ or shared/resorts-seed.ts. Check by slug, name, and coordinates within
1 km. For each missing resort, record slug, name, lat, lng, region slug, and official
website. Leave elevation_ft, trail_count, ticket_price_usd, and summary NULL.

Deliver one PR that adds one file, migrations/NNNN_<region>_skeleton.sql, with the next
unused prefix, using INSERT OR IGNORE ... SELECT ... FROM regions WHERE slug = 'us-xx'.
Put a -- Sources: comment above each row. In the PR description list the resorts
already present, the resorts added, and the resorts skipped with the reason.

Out of scope:
- other states, rentals, prices, and summaries
- UI or worker code, and edits to existing files or existing rows
- merging the PR
- running wrangler d1 migrations against the remote database
```

### 2. Ticket price fill for a capped list of resorts

```text
Ticket price fill for these Skier Slop resorts in us-xx: <slug-1>, <slug-2>, <slug-3>.

Read docs/resort-research-guide.md. Follow the ticket_price_usd rule in section 2 and
the summary rules in section 6. Use only the slugs above. Do not add resorts.

For each slug, take the adult full-day peak walk-up price from the resort's own tickets
page for the current or most recent season. If the page is a dynamic calendar, take the
highest regular adult day rate you can see. If no rate is visible, use NULL and say so
in the Sources comment.

Deliver one PR that adds one file, migrations/NNNN_<region>_ticket_prices.sql, with the
next unused prefix, shaped like migrations/0009_idaho_ticket_prices.sql:
UPDATE ski_resorts SET ticket_price_usd = <n> WHERE slug = '<slug>' AND ticket_price_usd IS NULL;
If the row has no summary yet, also add
UPDATE ski_resorts SET summary = '<original sentence>' WHERE slug = '<slug>' AND summary IS NULL;
Put a -- Sources: comment with two references above each statement.

Out of scope:
- other resorts or states, and rentals
- UI or worker code, and edits to existing files
- merging the PR
- running wrangler d1 migrations against the remote database
- any UPDATE without the IS NULL guard, which would overwrite a filled price
```

### 3. Rental fill around a capped list of resorts

```text
Rental fill around these Skier Slop resorts in us-xx: <resort-slug-1>, <resort-slug-2>.
Cap at <N> shops per resort, nearest to the base area first.

Read docs/rental-research-guide.md and follow it exactly. Work resort-outward from the
slugs above and no others.

For each shop, record daily_rate_usd as the adult standard one-day ski package (skis,
boots, poles, walk-in, whole USD) from the shop's own rates page, or NULL if the shop
publishes no price. Link nearest_resort_id by resort slug. Write one original summary
in the house voice.

Deliver one PR that adds one file, migrations/NNNN_<region>_rentals.sql, with the next
unused prefix, shaped like migrations/0007_idaho_rentals.sql:
INSERT OR IGNORE ... SELECT ... FROM regions reg, ski_resorts res
WHERE reg.slug = 'us-xx' AND res.slug = '<resort-slug>';
Put a -- Sources: comment with the rates page URL above each row.

Out of scope:
- other resorts or states, and resort rows
- UI or worker code, and edits to existing files
- merging the PR
- running wrangler d1 migrations against the remote database
- changing any existing daily_rate_usd
```

## Related docs

- [Resort research guide](./resort-research-guide.md) owns the `ski_resorts` contract, the region slugs, and the `ticket_price_usd` rule.
- [Rental research guide](./rental-research-guide.md) owns the `ski_rentals` contract and the `daily_rate_usd` definition.
- [Deal Scanner agent](./deal-scanner-agent.md) is the planned freshness tier.

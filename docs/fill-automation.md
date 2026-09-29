# How to run the next fill job

`npm run gap:next` reads `migrations/*.sql` and `docs/fill-priority.json`, then prints one cloud-agent prompt. Paste that prompt, review the pull request, merge it, and apply D1 yourself.

Live D1 can lag the SQL files. Coverage comes from `migrations/` on disk.

## Print the next job

1. From the repo root, run `npm run gap:next`.
2. Read the coverage table. Rows follow `priorityRegions`.
3. Copy the prompt under the next job. It is one tier for one region.

To inspect one region, run `node scripts/gap-audit.mjs --region us-or`.

To print JSON for a bot, run `node scripts/gap-audit.mjs --json`. The object has `regions`, `nextJob`, and `prompt`.

## Walk the tier rules

The script walks `priorityRegions` from the top. The first region that matches a tier rule is the job. Later regions wait.

For that region, the first matching rule wins.

1. No resort rows in `migrations/` means a skeleton job. The prompt is template 1 from the [Nationwide fill playbook](./nationwide-fill-playbook.md).
2. Resort rows exist and `majors` is missing or empty means you still need majors in `docs/fill-priority.json`. The prompt is template 1, plus a note to name majors before a ticket or rental job.
3. A listed major lacks a ticket attempt or a summary means a ticket job. The prompt is template 2, at most 10 slugs.
4. A listed major lacks a rental means a rental job. The prompt is template 3, at most 6 slugs, with 3 shops per resort.
5. Every listed major has a ticket attempt, a summary, and a rental. The script moves to the next region.

A ticket attempt is an `UPDATE` that sets `ticket_price_usd`, or a `-- Sources:` line that says `ticket_price_usd left NULL` for that slug. A summary is a quoted summary on the resort `INSERT`, or a later `UPDATE` that sets `summary`. One `ski_rentals` insert with that `res.slug` counts, even when `daily_rate_usd` is NULL.

The reader matches `INSERT` and `UPDATE` text. If a row looks wrong, open the migration file.

## Launch the cloud agent

1. Copy the printed prompt.
2. Start a cloud agent with that prompt as the task.
3. Let the agent open one migration pull request.

Merge the pull request yourself. After you review and apply the local migration, run `npm run db:migrate:remote` yourself.

## Review, merge, and apply

Follow the [Nationwide fill playbook](./nationwide-fill-playbook.md) for review, `npm run db:migrate:local`, the page check, and `npm run db:migrate:remote`. You run the remote migrate after the local check.

## Choose enrich or a research prompt

Use `npm run enrich:region` or the skeleton prompt for names, coordinates, and websites. Enrich writes those fields into live D1. Ticket and rental prices stay in a research migration that cites the resort or shop page. The playbook links the resort and rental research guides. Name the guides in the prompt and let the agent read them.

## Leave freshness for later

Deal Scanner is not part of this loop. The plan is in [Deal Scanner agent](./deal-scanner-agent.md).

## Change region order or majors

Edit `docs/fill-priority.json`, then run `npm run gap:next` and confirm the next job.

`priorityRegions` is the walk order. Put the region you want next at the front. Keep `us-id` and `us-wa` out of this list. Their fill loop already ran. Their slugs stay under `majors` so `node scripts/gap-audit.mjs --region us-id` still audits them.

`majors` maps a region slug to resort slugs. Name the destination resorts for that region. A missing key means an empty list. Trail counts and existing rental rows stay out of this list.

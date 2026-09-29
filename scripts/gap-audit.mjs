#!/usr/bin/env node
/**
 * Print migration coverage and the next nationwide-fill prompt.
 *
 * Usage:
 *   node scripts/gap-audit.mjs
 *   node scripts/gap-audit.mjs --next
 *   node scripts/gap-audit.mjs --json
 *   node scripts/gap-audit.mjs --region us-or
 *   npm run gap:next
 */
import { readdirSync, readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

/** @typedef {{ priorityRegions: string[], majors: Record<string, string[]> }} FillPriority */

/** @typedef {{
 *   slug: string,
 *   regionSlug: string | null,
 *   hasSummary: boolean,
 *   ticketAttempted: boolean,
 *   hasRental: boolean
 * }} ResortFacts */

/** @typedef {{
 *   regionSlug: string,
 *   resortCount: number,
 *   majors: string[],
 *   majorsMissingTicket: string[],
 *   majorsMissingSummary: string[],
 *   majorsMissingRental: string[]
 * }} RegionCoverage */

/** @typedef {{
 *   tier: 'skeleton' | 'define-majors' | 'tickets' | 'rentals' | 'done',
 *   regionSlug: string | null,
 *   slugs: string[],
 *   note?: string,
 *   shopsPerResort?: number
 * }} NextJob */

const root = join(dirname(fileURLToPath(import.meta.url)), "..");

const SKELETON_TEMPLATE = `Skeleton gap audit for <REGION> (region slug us-xx) in the Skier Slop repo.

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
`;

const TICKETS_TEMPLATE = `Ticket price fill for these Skier Slop resorts in us-xx: <slug-1>, <slug-2>, <slug-3>.

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
`;

const RENTALS_TEMPLATE = `Rental fill around these Skier Slop resorts in us-xx: <resort-slug-1>, <resort-slug-2>.
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
`;

const PROMPT_TEMPLATES = {
  skeleton: SKELETON_TEMPLATE,
  tickets: TICKETS_TEMPLATE,
  rentals: RENTALS_TEMPLATE,
};

function missingTicketOrSummary(coverage) {
  const missing = new Set([
    ...coverage.majorsMissingTicket,
    ...coverage.majorsMissingSummary,
  ]);
  return coverage.majors.filter((slug) => missing.has(slug));
}

const TIER_RULES = [
  {
    tier: "skeleton",
    when: (coverage) => coverage.resortCount === 0,
    slugs: () => [],
    cap: 0,
  },
  {
    tier: "define-majors",
    when: (coverage) => coverage.majors.length === 0,
    slugs: () => [],
    cap: 0,
    note: "define majors in docs/fill-priority.json",
  },
  {
    tier: "tickets",
    when: (coverage) => missingTicketOrSummary(coverage).length > 0,
    slugs: (coverage) => missingTicketOrSummary(coverage),
    cap: 10,
  },
  {
    tier: "rentals",
    when: (coverage) => coverage.majorsMissingRental.length > 0,
    slugs: (coverage) => coverage.majorsMissingRental,
    cap: 6,
    shopsPerResort: 3,
  },
];

function parseArgs(argv) {
  let json = false;
  let region = null;
  let next = false;
  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === "--json") {
      json = true;
    } else if (arg === "--next") {
      next = true;
    } else if (arg === "--region") {
      const value = argv[i + 1];
      if (!value || value.startsWith("--")) {
        fail("Missing value for --region.");
      }
      region = value;
      i += 1;
    } else if (arg.startsWith("--region=")) {
      region = arg.slice("--region=".length);
      if (!region) fail("Missing value for --region.");
    } else {
      fail(`Unknown argument ${arg}.`);
    }
  }
  if (!region) next = true;
  return { json, region, next };
}

function loadPriority(path) {
  let data;
  try {
    data = JSON.parse(readFileSync(path, "utf8"));
  } catch (err) {
    fail(`Cannot read ${path}: ${err instanceof Error ? err.message : String(err)}`);
  }
  if (!Array.isArray(data.priorityRegions) || data.majors === null || typeof data.majors !== "object" || Array.isArray(data.majors)) {
    fail("fill-priority.json must have priorityRegions and majors.");
  }
  for (const slug of data.priorityRegions) {
    if (typeof slug !== "string" || slug.length === 0) {
      fail("priorityRegions entries must be non-empty strings.");
    }
  }
  for (const [key, list] of Object.entries(data.majors)) {
    if (!Array.isArray(list) || list.some((slug) => typeof slug !== "string")) {
      fail(`majors.${key} must be an array of strings.`);
    }
  }
  return { priorityRegions: data.priorityRegions, majors: data.majors };
}

function loadRegionSlugs(regionsDataPath) {
  const text = readFileSync(regionsDataPath, "utf8");
  const regions = [];
  const re = /\{\s*slug:\s*"(us-[a-z]{2})",\s*name:\s*"([^"]+)"/g;
  for (const match of text.matchAll(re)) {
    regions.push({ slug: match[1], name: match[2] });
  }
  if (regions.length === 0) {
    fail(`No US regions matched in ${regionsDataPath}.`);
  }
  return regions;
}

/**
 * Sources comments contain semicolons, so drop full-line comments before splitting.
 */
function stripSqlComments(text) {
  return text
    .split("\n")
    .filter((line) => !line.trimStart().startsWith("--"))
    .join("\n");
}

function selectHasSummary(selectBody) {
  const body = selectBody.trim();
  if (/\bNULL$/i.test(body)) return false;
  return /'(?:[^']|'')*'$/.test(body);
}

function whereSlug(stmt) {
  const match = stmt.match(/WHERE\s+slug\s*=\s*'([^']+)'/i);
  return match ? match[1] : null;
}

function ensureResort(resorts, slug) {
  let facts = resorts.get(slug);
  if (!facts) {
    facts = {
      slug,
      regionSlug: null,
      hasSummary: false,
      ticketAttempted: false,
      hasRental: false,
    };
    resorts.set(slug, facts);
  }
  return facts;
}

function applyStatement(resorts, stmt) {
  if (/INSERT\s+(?:OR\s+IGNORE\s+)?INTO\s+ski_resorts\b/i.test(stmt)) {
    const fromMatch = stmt.match(/FROM\s+regions\s+WHERE\s+slug\s*=\s*'([^']+)'/i);
    const selectIdx = stmt.search(/\bSELECT\b/i);
    if (!fromMatch || selectIdx < 0 || selectIdx > fromMatch.index) return;
    const selectBody = stmt.slice(selectIdx, fromMatch.index).replace(/^\s*SELECT\s+/i, "");
    const slugMatch = selectBody.match(/'((?:[^']|'')*)'/);
    if (!slugMatch) return;
    const facts = ensureResort(resorts, slugMatch[1].replace(/''/g, "'"));
    if (!facts.regionSlug) facts.regionSlug = fromMatch[1];
    if (selectHasSummary(selectBody)) facts.hasSummary = true;
    return;
  }

  if (/UPDATE\s+ski_resorts\b/i.test(stmt) && /\bSET\s+ticket_price_usd\s*=/i.test(stmt)) {
    const slug = whereSlug(stmt);
    if (slug) ensureResort(resorts, slug).ticketAttempted = true;
    return;
  }

  if (/UPDATE\s+ski_resorts\b/i.test(stmt) && /\bSET\s+summary\s*=\s*'/i.test(stmt)) {
    const slug = whereSlug(stmt);
    if (slug) ensureResort(resorts, slug).hasSummary = true;
    return;
  }

  if (/INSERT\s+(?:OR\s+IGNORE\s+)?INTO\s+ski_rentals\b/i.test(stmt)) {
    const resortMatch = stmt.match(/\bres\.slug\s*=\s*'([^']+)'/i);
    if (!resortMatch) return;
    const facts = ensureResort(resorts, resortMatch[1]);
    facts.hasRental = true;
    const regionMatch = stmt.match(/\breg\.slug\s*=\s*'([^']+)'/i);
    if (!facts.regionSlug && regionMatch) facts.regionSlug = regionMatch[1];
  }
}

/**
 * A Sources line that says the price was left NULL is a ticket attempt.
 * Migrations never assign ticket_price_usd to NULL.
 */
function markIntentionalNullTickets(raw, resorts) {
  const lines = raw.split("\n");
  for (let i = 0; i < lines.length; i += 1) {
    if (!lines[i].includes("ticket_price_usd left NULL")) continue;
    const window = lines.slice(i, i + 8).join("\n");
    const match = window.match(/WHERE\s+slug\s*=\s*'([^']+)'/i);
    if (match) ensureResort(resorts, match[1]).ticketAttempted = true;
  }
}

function parseMigrations(dir) {
  const resorts = new Map();
  const files = readdirSync(dir)
    .filter((name) => name.endsWith(".sql"))
    .sort();
  for (const name of files) {
    const raw = readFileSync(join(dir, name), "utf8");
    const statements = stripSqlComments(raw).split(";");
    for (const statement of statements) {
      if (statement.trim()) applyStatement(resorts, statement);
    }
    markIntentionalNullTickets(raw, resorts);
  }
  return resorts;
}

function applyKnownRegionMap(resorts, majors) {
  /** @type {Map<string, string>} */
  const slugToRegion = new Map();
  for (const [regionSlug, slugs] of Object.entries(majors)) {
    for (const slug of slugs) {
      if (!slugToRegion.has(slug)) slugToRegion.set(slug, regionSlug);
    }
  }
  for (const facts of resorts.values()) {
    if (facts.regionSlug) continue;
    const known = slugToRegion.get(facts.slug);
    if (known) facts.regionSlug = known;
  }
}

function buildCoverage(priority, resorts, onlyRegion) {
  const regionSlugs = onlyRegion ? [onlyRegion] : priority.priorityRegions;
  return regionSlugs.map((regionSlug) => {
    const majors = priority.majors[regionSlug] ?? [];
    const inRegion = [...resorts.values()].filter((facts) => facts.regionSlug === regionSlug);
    const bySlug = new Map(inRegion.map((facts) => [facts.slug, facts]));
    return {
      regionSlug,
      resortCount: inRegion.length,
      majors,
      majorsMissingTicket: majors.filter((slug) => !bySlug.get(slug)?.ticketAttempted),
      majorsMissingSummary: majors.filter((slug) => !bySlug.get(slug)?.hasSummary),
      majorsMissingRental: majors.filter((slug) => !bySlug.get(slug)?.hasRental),
    };
  });
}

function pickNext(coverages, opts) {
  for (const coverage of coverages) {
    const rule = TIER_RULES.find((candidate) => candidate.when(coverage));
    if (!rule) continue;
    /** @type {NextJob} */
    const job = {
      tier: rule.tier,
      regionSlug: coverage.regionSlug,
      slugs: rule.cap > 0 ? rule.slugs(coverage).slice(0, rule.cap) : [],
    };
    if (rule.note) job.note = rule.note;
    if (rule.shopsPerResort) job.shopsPerResort = rule.shopsPerResort;
    return job;
  }
  return { tier: "done", regionSlug: opts.region, slugs: [] };
}

function fillTemplate(key, job, regionName) {
  let text = PROMPT_TEMPLATES[key];
  text = text.replaceAll("us-xx", job.regionSlug ?? "");
  text = text.replaceAll("<REGION>", regionName);
  if (key === "tickets") {
    text = text.replace("<slug-1>, <slug-2>, <slug-3>", job.slugs.join(", "));
  }
  if (key === "rentals") {
    text = text.replace("<resort-slug-1>, <resort-slug-2>", job.slugs.join(", "));
    text = text.replaceAll("<N>", String(job.shopsPerResort ?? 3));
  }
  return text;
}

function fillPrompt(job, regionName) {
  switch (job.tier) {
    case "skeleton":
      return fillTemplate("skeleton", job, regionName);
    case "define-majors":
      return `${fillTemplate("skeleton", job, regionName)}\nMajors for ${job.regionSlug} are not listed in docs/fill-priority.json. Add them before a ticket or rental job. This prompt is the skeleton pass.\n`;
    case "tickets":
      return fillTemplate("tickets", job, regionName);
    case "rentals":
      return fillTemplate("rentals", job, regionName);
    case "done":
      return "";
    default: {
      /** @type {never} */
      const unknown = job.tier;
      fail(`Unknown tier ${String(unknown)}.`);
    }
  }
}

function printHuman(coverages, job, prompt) {
  const headers = ["slug", "resorts", "missing ticket", "missing summary", "missing rental"];
  const rows = coverages.map((coverage) => [
    coverage.regionSlug,
    String(coverage.resortCount),
    String(coverage.majorsMissingTicket.length),
    String(coverage.majorsMissingSummary.length),
    String(coverage.majorsMissingRental.length),
  ]);
  const widths = headers.map((header, index) =>
    Math.max(header.length, ...rows.map((row) => row[index].length)),
  );
  const format = (cols) => cols.map((col, index) => col.padEnd(widths[index])).join("  ");
  console.log(format(headers).trimEnd());
  for (const row of rows) console.log(format(row).trimEnd());
  console.log("");
  console.log("Next job");
  console.log(`tier ${job.tier}`);
  console.log(`region ${job.regionSlug ?? ""}`);
  console.log(`slugs ${job.slugs.length > 0 ? job.slugs.join(", ") : "none"}`);
  if (job.note) console.log(`note ${job.note}`);
  if (job.shopsPerResort) console.log(`shops per resort ${job.shopsPerResort}`);
  if (prompt) {
    console.log("");
    console.log(prompt.trimEnd());
  }
}

function printJson(coverages, job, prompt) {
  console.log(JSON.stringify({ regions: coverages, nextJob: job, prompt }, null, 2));
}

function assertKnownRegions(priority, regions, onlyRegion) {
  const known = new Set(regions.map((region) => region.slug));
  for (const slug of priority.priorityRegions) {
    if (!known.has(slug)) fail(`priorityRegions slug ${slug} is not in shared/regions-data.ts.`);
  }
  for (const slug of Object.keys(priority.majors)) {
    if (!known.has(slug)) fail(`majors key ${slug} is not in shared/regions-data.ts.`);
  }
  if (onlyRegion && !known.has(onlyRegion)) {
    fail(`Unknown region ${onlyRegion}.`);
  }
}

function fail(message) {
  console.error(message);
  console.error(`Usage:
  node scripts/gap-audit.mjs
  node scripts/gap-audit.mjs --next
  node scripts/gap-audit.mjs --json
  node scripts/gap-audit.mjs --region us-or
  npm run gap:next`);
  process.exit(1);
}

function main() {
  const opts = parseArgs(process.argv.slice(2));
  const priority = loadPriority(join(root, "docs/fill-priority.json"));
  const regions = loadRegionSlugs(join(root, "shared/regions-data.ts"));
  assertKnownRegions(priority, regions, opts.region);
  const resorts = parseMigrations(join(root, "migrations"));
  applyKnownRegionMap(resorts, priority.majors);
  const coverages = buildCoverage(priority, resorts, opts.region);
  const job = pickNext(coverages, opts);
  const regionName = regions.find((region) => region.slug === job.regionSlug)?.name ?? job.regionSlug ?? "";
  const prompt = fillPrompt(job, regionName);
  if (opts.json) printJson(coverages, job, prompt);
  else printHuman(coverages, job, prompt);
}

main();

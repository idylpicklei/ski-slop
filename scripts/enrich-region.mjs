#!/usr/bin/env node
/**
 * Trigger resort/rental enrichment for a region.
 *
 * Usage:
 *   ADMIN_TOKEN=secret SITE=https://ski-slop.workers.dev node scripts/enrich-region.mjs us-id
 *   npm run enrich:idaho
 */
const regionSlug = process.argv[2] ?? "us-id";
const site = (process.env.SITE ?? process.env.CF_PAGES_URL ?? "http://127.0.0.1:8787").replace(/\/$/, "");
const token = process.env.ADMIN_TOKEN;

if (!token) {
  console.error("Set ADMIN_TOKEN environment variable.");
  process.exit(1);
}

const reset = process.argv.includes("--reset");
const type = process.argv.includes("--rentals-only") ? "rental" : "both";

async function main() {
  if (reset) {
    console.log(`Resetting enrichment status for ${regionSlug}…`);
    const resetRes = await fetch(`${site}/api/admin/regions/${regionSlug}/reset`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}` },
    });
    const resetBody = await resetRes.json();
    if (!resetRes.ok) {
      console.error("Reset failed:", resetBody);
      process.exit(1);
    }
    console.log("Reset OK");
  }

  console.log(`Queueing ${type} enrichment for ${regionSlug}…`);
  const res = await fetch(`${site}/api/admin/enqueue`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${token}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ regionSlug, type }),
  });

  const body = await res.json();
  if (!res.ok) {
    console.error("Enqueue failed:", body);
    process.exit(1);
  }

  console.log("Queued:", body);
  console.log(`\nWatch results at: ${site}/resorts/?region=${regionSlug}`);
  console.log(`Region stats:   ${site}/api/regions/${regionSlug}`);
}

main();

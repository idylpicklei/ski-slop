/**
 * Generates seed SQL from shared data files.
 * Run: npx tsx scripts/seed-regions.ts > migrations/generated_seed.sql
 * Or apply existing migrations/0002_seed_data.sql via wrangler d1 migrations apply.
 */
import { NA_REGIONS } from "../shared/regions-data.js";
import { FLAGSHIP_RESORTS, SEED_PRODUCTS } from "../shared/resorts-seed.js";

console.log("-- Auto-generated seed (reference only; use migrations/0002_seed_data.sql)");
console.log("INSERT OR IGNORE INTO regions (slug, name, country, center_lat, center_lng) VALUES");
console.log(
  NA_REGIONS.map(
    (r) =>
      `  ('${r.slug}', '${r.name.replace(/'/g, "''")}', '${r.country}', ${r.center_lat}, ${r.center_lng})`,
  ).join(",\n") + ";",
);

for (const resort of FLAGSHIP_RESORTS) {
  console.log(`
INSERT OR IGNORE INTO ski_resorts (slug, name, region_id, lat, lng, elevation_ft, trail_count, website, source, summary)
SELECT '${resort.slug}', '${resort.name.replace(/'/g, "''")}', id, ${resort.lat}, ${resort.lng}, ${resort.elevation_ft}, ${resort.trail_count}, '${resort.website}', 'manual', '${resort.summary.replace(/'/g, "''")}'
FROM regions WHERE slug = '${resort.region_slug}';`);
}

console.log("\n-- Products");
for (const p of SEED_PRODUCTS) {
  console.log(
    `INSERT OR IGNORE INTO products (slug, category, brand, name, description) VALUES ('${p.slug}', '${p.category}', '${p.brand}', '${p.name.replace(/'/g, "''")}', '${p.description.replace(/'/g, "''")}');`,
  );
}

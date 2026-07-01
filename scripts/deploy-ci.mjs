/**
 * CI deploy for the single ski-slop Worker (site + API + agents).
 */
import { spawnSync } from "node:child_process";

function run(args, { allowFailure = false } = {}) {
  console.log(`\n▶ npx wrangler ${args.join(" ")}`);
  const result = spawnSync("npx", ["wrangler", ...args], {
    stdio: "inherit",
    shell: true,
    env: process.env,
  });
  if (result.status !== 0 && !allowFailure) {
    process.exit(result.status ?? 1);
  }
  return result.status ?? 1;
}

if (process.env.CLOUDFLARE_API_TOKEN === "") {
  delete process.env.CLOUDFLARE_API_TOKEN;
}

// Create queue once; ignore error if it already exists.
run(["queues", "create", "ski-slop-enrichment"], { allowFailure: true });

run(["deploy"]);

console.log("\n✔ Deploy complete");

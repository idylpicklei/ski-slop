/**
 * Cloudflare Workers Builds deploy script.
 * Deploy agents first (so the service binding exists), then the site worker.
 */
import { spawnSync } from "node:child_process";

function run(label, args) {
  console.log(`\n▶ ${label}: npx wrangler ${args.join(" ")}`);
  const result = spawnSync("npx", ["wrangler", ...args], {
    stdio: "inherit",
    shell: true,
    env: process.env,
  });
  if (result.status !== 0) {
    console.error(`\n✘ ${label} failed (exit ${result.status})`);
    process.exit(result.status ?? 1);
  }
}

// If a stale/wrong token was added as a build variable, unset it when empty.
if (process.env.CLOUDFLARE_API_TOKEN === "") {
  delete process.env.CLOUDFLARE_API_TOKEN;
}

console.log("Deploy env:", {
  hasApiToken: Boolean(process.env.CLOUDFLARE_API_TOKEN),
  accountId: process.env.CLOUDFLARE_ACCOUNT_ID ?? "(using wrangler.jsonc account_id)",
});

run("agents worker", ["deploy", "-c", "wrangler.agents.jsonc"]);
run("site worker", ["deploy"]);

console.log("\n✔ Deploy complete");

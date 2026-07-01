/**
 * GitHub Actions / CI deploy: validate secrets, migrate D1, deploy Worker.
 */
import { spawnSync } from "node:child_process";

function requireEnv(name) {
  const value = process.env[name];
  if (!value) {
    console.error(`::error::Missing ${name}. Add it as a GitHub repository secret.`);
    process.exit(1);
  }
  return value;
}

function run(args) {
  console.log(`\n▶ npx wrangler ${args.join(" ")}`);
  const result = spawnSync("npx", ["wrangler", ...args], {
    stdio: "inherit",
    shell: true,
    env: process.env,
  });
  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}

requireEnv("CLOUDFLARE_API_TOKEN");
requireEnv("CLOUDFLARE_ACCOUNT_ID");

console.log("Cloudflare CI deploy starting…");
console.log("Account:", process.env.CLOUDFLARE_ACCOUNT_ID);

run(["d1", "migrations", "apply", "ski-slop-db", "--remote"]);
run(["deploy"]);

console.log("\n✔ CI deploy complete");

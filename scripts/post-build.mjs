import { copyFileSync, mkdirSync, writeFileSync } from "node:fs";

mkdirSync("dist/styles", { recursive: true });
copyFileSync("src/styles/global.css", "dist/styles/global.css");
writeFileSync("dist/.assetsignore", "_worker.js\n");

// Type stub so tsconfig.workers.json can type-check workers/site/index.ts,
// which imports the compiled Pages Functions bundle.
writeFileSync(
  "dist/_worker.js/index.d.ts",
  "declare const worker: unknown;\nexport default worker;\n",
);

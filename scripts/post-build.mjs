import { copyFileSync, mkdirSync, writeFileSync } from "node:fs";

mkdirSync("dist/styles", { recursive: true });
copyFileSync("src/styles/global.css", "dist/styles/global.css");
writeFileSync("dist/.assetsignore", "_worker.js\n");

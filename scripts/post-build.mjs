import { writeFileSync } from "node:fs";

// Prevent the compiled Pages Functions bundle from being served as a static file.
writeFileSync("dist/.assetsignore", "_worker.js\n");

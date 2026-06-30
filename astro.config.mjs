import { defineConfig } from "astro/config";

export default defineConfig({
  output: "static",
  site: "https://ski-slop.pages.dev",
  build: {
    format: "directory",
  },
});

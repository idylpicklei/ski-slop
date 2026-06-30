declare global {
  interface Env {
    DB: D1Database;
    AGENTS?: Fetcher;
    ADMIN_TOKEN?: string;
  }
}

export {};

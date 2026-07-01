declare global {
  interface Env {
    DB: D1Database;
    ENRICHMENT_QUEUE?: Queue;
    ADMIN_TOKEN?: string;
  }
}

export {};

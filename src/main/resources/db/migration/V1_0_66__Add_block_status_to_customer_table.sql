ALTER TABLE "web".customer ADD IF NOT EXISTS "blocked_inflows" boolean NOT NULL DEFAULT(false);
ALTER TABLE "web".customer ADD IF NOT EXISTS "blocked_outflows" boolean NOT NULL DEFAULT(false);
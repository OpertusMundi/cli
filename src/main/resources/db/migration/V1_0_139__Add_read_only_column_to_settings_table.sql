ALTER TABLE web.settings ADD COLUMN IF NOT EXISTS "read_only" boolean DEFAULT(false);
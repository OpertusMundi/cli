ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "ipr_protection_enabled" boolean NOT NULL DEFAULT(false);

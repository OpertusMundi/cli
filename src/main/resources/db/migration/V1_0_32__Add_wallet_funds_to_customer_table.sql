ALTER TABLE "web".customer ADD IF NOT EXISTS "wallet_funds" numeric(20,6) NOT NULL DEFAULT(0);
ALTER TABLE "web".customer ADD IF NOT EXISTS "wallet_funds_updated_on" timestamp NULL;
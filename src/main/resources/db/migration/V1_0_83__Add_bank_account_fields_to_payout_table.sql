ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_provider_id"                    character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_name"                     character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_line1"            character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_line2"            character varying;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_city"             character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_region"           character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_postal_code"      character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_owner_address_country"          character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_iban"                           character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_bic"                            character varying NOT NULL;
ALTER TABLE "billing".payout ADD COLUMN IF NOT EXISTS "bank_account_tag"                            character varying NOT NULL;
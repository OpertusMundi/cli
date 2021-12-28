ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_name" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_address_line1" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_address_city" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_address_region" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_address_postal_code" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_owner_address_country" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_iban" DROP NOT NULL;
ALTER TABLE "web".customer_professional ALTER COLUMN "bank_account_bic" DROP NOT NULL;

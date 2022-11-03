ALTER TABLE "billing".subscription_billing ADD IF NOT EXISTS "key" UUID NULL;

UPDATE "billing".subscription_billing SET "key" = uuid_generate_v4();

ALTER TABLE "billing".subscription_billing ALTER COLUMN "key" SET NOT NULL;

CREATE INDEX "idx_subscription_billing_key" ON "billing".subscription_billing USING btree ("key");

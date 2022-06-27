ALTER TABLE "web".account_subscription ADD IF NOT EXISTS "key" UUID NULL;

update "web".account_subscription set "key" = uuid_generate_v4();

ALTER TABLE "web".account_subscription ALTER COLUMN "key" SET NOT NULL;

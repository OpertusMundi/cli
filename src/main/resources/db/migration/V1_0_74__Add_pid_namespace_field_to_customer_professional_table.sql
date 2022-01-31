ALTER TABLE "web".customer_professional ADD IF NOT EXISTS "pid_namespace" character varying NULL;

UPDATE "web".customer_professional set "pid_namespace" = "name" where "pid_namespace" is null;

ALTER TABLE "web".customer_professional ALTER COLUMN "pid_namespace" SET NOT NULL;

ALTER TABLE "web".customer_professional DROP CONSTRAINT IF EXISTS uq_customer_professional_pid_namespace;

ALTER TABLE "web".customer_professional ADD CONSTRAINT uq_customer_professional_pid_namespace UNIQUE ("pid_namespace");
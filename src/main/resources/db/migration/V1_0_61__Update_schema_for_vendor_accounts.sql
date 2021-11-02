-- Add field `type` to account table
ALTER TABLE "web".account ADD IF NOT EXISTS "type" character varying(20);

-- Initialize `type` field
update "web".account set "type" = 'OPERTUSMUNDI';

-- Add new constraint for field `type`
ALTER TABLE "web".account DROP CONSTRAINT IF EXISTS chk_account_type_enum;

ALTER TABLE "web".account ADD CONSTRAINT chk_account_type_enum CHECK
  ("type" IN ('OPERTUSMUNDI', 'VENDOR'));

-- Do not allow null values for new field `type`
ALTER TABLE "web".account ALTER COLUMN "type" SET NOT NULL;

-- Add field `parent` to account table
ALTER TABLE "web".account ADD IF NOT EXISTS "parent" integer;

-- Add foreign key constraint for field `parent`
ALTER TABLE "web".account DROP CONSTRAINT IF EXISTS fk_account_parent_account;

ALTER TABLE "web".account ADD CONSTRAINT fk_account_parent_account FOREIGN KEY ("parent")
  REFERENCES "web".account (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE SET NULL;

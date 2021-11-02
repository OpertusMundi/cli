-- Add field `account_vendor` to asset draft table
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "account_vendor" integer;

-- Add foreign key constraint for field `parent`
ALTER TABLE "provider".asset_draft DROP CONSTRAINT IF EXISTS fk_asset_draft_account_vendor;

ALTER TABLE "provider".asset_draft ADD CONSTRAINT fk_asset_draft_account_vendor FOREIGN KEY ("account_vendor")
  REFERENCES "web".account (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE SET NULL;

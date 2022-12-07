ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "helpdesk_review_account"    integer NULL;
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "provider_review_account"    integer NULL;
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "helpdesk_set_error_account" integer NULL;

ALTER TABLE "provider".asset_draft DROP CONSTRAINT IF EXISTS fk_asset_draft_helpdesk_review_account;
ALTER TABLE "provider".asset_draft DROP CONSTRAINT IF EXISTS fk_asset_draft_provider_review_account;
ALTER TABLE "provider".asset_draft DROP CONSTRAINT IF EXISTS fk_asset_draft_helpdesk_set_error_account;

ALTER TABLE "provider".asset_draft
  ADD CONSTRAINT fk_asset_draft_helpdesk_review_account FOREIGN KEY ("helpdesk_review_account")
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "provider".asset_draft
  ADD CONSTRAINT fk_asset_draft_provider_review_account FOREIGN KEY ("provider_review_account")
      REFERENCES "web".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "provider".asset_draft
  ADD CONSTRAINT fk_asset_draft_helpdesk_set_error_account FOREIGN KEY ("helpdesk_set_error_account")
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "web".account_user_service ADD IF NOT EXISTS "helpdesk_set_error_account" integer NULL;

ALTER TABLE "web".account_user_service DROP CONSTRAINT IF EXISTS fk_account_user_service_helpdesk_set_error_account;

ALTER TABLE "web".account_user_service
  ADD CONSTRAINT fk_account_user_service_helpdesk_set_error_account FOREIGN KEY ("helpdesk_set_error_account")
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE web.account_profile DROP CONSTRAINT IF EXISTS fk_account_profile_provider_registartion;
ALTER TABLE web.account_profile DROP CONSTRAINT IF EXISTS fk_account_profile_provider_registration;

ALTER TABLE web.account_profile ADD CONSTRAINT fk_account_profile_provider_registration
  FOREIGN KEY ("provider_registration")
  REFERENCES web.customer_draft_professional ("id") MATCH SIMPLE;
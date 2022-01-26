ALTER TABLE "billing".payin_recurring_registration DROP CONSTRAINT IF EXISTS uq_payin_recurring_registration_provider_id;

ALTER TABLE "billing".payin_recurring_registration ADD CONSTRAINT uq_payin_recurring_registration_provider_id UNIQUE ("provider_registration");
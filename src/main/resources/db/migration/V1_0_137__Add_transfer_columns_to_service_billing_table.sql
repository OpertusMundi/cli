ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_provider_id"     character varying(64);
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_credited_funds"  numeric(20,6);
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_platform_fees"   numeric(20,6);
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_executed_on"     timestamp;
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_year"            integer;
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_month"           integer;
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_week"            integer;
ALTER TABLE billing.service_billing ADD COLUMN IF NOT EXISTS "transfer_day"             integer;
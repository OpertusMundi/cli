ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "transfer_result_code"    character varying;
ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "transfer_result_message" character varying;
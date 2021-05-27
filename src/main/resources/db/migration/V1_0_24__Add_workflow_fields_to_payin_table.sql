ALTER TABLE "billing".payin ADD IF NOT EXISTS "process_definition" character varying;
ALTER TABLE "billing".payin ADD IF NOT EXISTS "process_instance"   character varying;
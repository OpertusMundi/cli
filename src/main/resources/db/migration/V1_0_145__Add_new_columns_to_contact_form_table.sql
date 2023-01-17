ALTER TABLE "messaging".contact_form ADD IF NOT EXISTS "country_code" character varying(2);
ALTER TABLE "messaging".contact_form ADD IF NOT EXISTS "type"         character varying(20) DEFAULT('NONE') NOT NULL;

ALTER TABLE "messaging".contact_form DROP CONSTRAINT IF EXISTS chk_contact_form_type_enum;

ALTER TABLE "messaging".contact_form ADD CONSTRAINT chk_contact_form_type_enum CHECK
  ("type" IN ('NONE', 'DATA_MATCH'));

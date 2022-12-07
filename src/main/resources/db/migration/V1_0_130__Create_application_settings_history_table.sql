DROP TABLE IF EXISTS "web".setting_history;
DROP SEQUENCE IF EXISTS "web".setting_history_id_seq cascade;

CREATE SEQUENCE "web".setting_history_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".setting_history
(
  "id"              integer                 NOT NULL  DEFAULT nextval('web.setting_history_id_seq'::regclass),
  "service"         character varying(60)   NOT NULL,
  "key"             character varying(256)  NOT NULL,
  "type"            character varying(30)   NOT NULL,
  "value"           character varying,
  "updated_by"      integer,
  "updated_on"      timestamp               NOT NULL,
  CONSTRAINT pk_setting_history_key PRIMARY KEY ("id"),
  CONSTRAINT chk_setting_history_service_enum CHECK
    ("service" IN ('API_GATEWAY', 'ADMIN_GATEWAY', 'BPM_ENGINE', 'BPM_WORKER')),
  CONSTRAINT chk_setting_history_type_enum CHECK
    ("type" IN ('TEXT', 'NUMERIC', 'BOOLEAN', 'DATE', 'DATE_TIME', 'JSON', 'HTML'))
);

CREATE INDEX idx_setting_history_service_key ON "web".setting_history USING btree ("service", "key");

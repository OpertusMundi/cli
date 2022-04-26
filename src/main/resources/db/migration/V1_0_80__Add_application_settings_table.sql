DROP TABLE IF EXISTS "web".settings;

CREATE TABLE "web".settings
(
    "service"       character varying(60)         NOT NULL,
    "key"           character varying(30)         NOT NULL,
    "type"          character varying(30)         NOT NULL    DEFAULT('TEXT'),
    "value"         character varying,
    "updated_by"    integer,
    "updated_on"    timestamp without time zone   NOT NULL,
    CONSTRAINT pk_settings_key PRIMARY KEY ("service", "key"),
    CONSTRAINT fk_settings_account FOREIGN KEY (updated_by)
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
    CONSTRAINT chk_settings_service_enum CHECK
      ("service" IN ('API_GATEWAY', 'ADMIN_GATEWAY', 'BPM_ENGINE', 'BPM_WORKER')),
    CONSTRAINT chk_settings_type_enum CHECK
      ("type" IN ('TEXT', 'NUMERIC', 'BOOLEAN', 'DATE', 'DATE_TIME', 'JSON', 'HTML'))
);

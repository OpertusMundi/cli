CREATE SCHEMA IF NOT EXISTS "messaging";

DROP TABLE IF EXISTS "messaging".notification_template CASCADE;
DROP SEQUENCE IF EXISTS "messaging".notification_template_id_seq CASCADE;

CREATE SEQUENCE messaging.notification_template_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE messaging.notification_template
(
  "id"                  integer                     NOT NULL  DEFAULT nextval('messaging.notification_template_id_seq'::regclass),
  "type"                character varying           NOT NULL,
  "text"                character varying           NOT NULL,
  "modified_on"         timestamp                   NOT NULL,
  CONSTRAINT pk_notification_template      PRIMARY KEY ("id"),
  CONSTRAINT uq_notification_template_type UNIQUE ("type")
);

CREATE SCHEMA IF NOT EXISTS "messaging";

DROP TABLE IF EXISTS "messaging".mail_template CASCADE;
DROP SEQUENCE IF EXISTS "messaging".mail_template_id_seq CASCADE;

CREATE SEQUENCE messaging.mail_template_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE messaging.mail_template
(
  "id"                  integer                     NOT NULL  DEFAULT nextval('messaging.mail_template_id_seq'::regclass),
  "type"                character varying           NOT NULL,
  "subject_template"    character varying           NOT NULL,
  "content_template"    character varying,
  "sender_name"         character varying           NOT NULL,
  "sender_email"        character varying           NOT NULL,
  "modified_on"         timestamp                   NOT NULL,
  CONSTRAINT pk_mail_template      PRIMARY KEY ("id"),
  CONSTRAINT uq_mail_template_type UNIQUE ("type")
);

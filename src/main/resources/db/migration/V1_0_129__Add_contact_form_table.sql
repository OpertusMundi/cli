DROP TABLE IF EXISTS "messaging".contact_form CASCADE;
DROP SEQUENCE IF EXISTS "messaging".contact_form_id_seq CASCADE;

CREATE SEQUENCE "messaging".contact_form_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "messaging".contact_form
(
  "id"                              integer                     NOT NULL  DEFAULT nextval('messaging.contact_form_id_seq'::regclass),
  "key"                             uuid                        NOT NULL,
  "company_name"                    character varying(64),
  "firstname"                       character varying(64),
  "lastname"                        character varying(64),
  "email"                           character varying(120)      NOT NULL,
  "phone_country_code"              character varying(4),
  "phone_number"                    character varying(14),
  "message"                         character varying           NOT NULL,
  "created_at"                      timestamp                   NOT NULL  DEFAULT now(),
  "updated_at"                      timestamp                   NOT NULL  DEFAULT now(),
  "status"                          character varying(20)       NOT NULL  DEFAULT ('PENDING'),
  "privacy_terms_accepted"          boolean                     NOT NULL,
  "registration_process_definition" character varying,
  "registration_process_instance"   character varying,
  CONSTRAINT pk_contact_form PRIMARY KEY (id),
  CONSTRAINT uq_contact_form_key UNIQUE ("key")
);

CREATE INDEX idx_contact_form_key ON "messaging".contact_form USING btree ("key");
CREATE INDEX idx_contact_form_email ON "messaging".contact_form USING btree ("email");

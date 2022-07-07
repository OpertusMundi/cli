--
-- User service table
--

DROP TABLE IF EXISTS "web".account_user_service CASCADE;
DROP SEQUENCE IF EXISTS "web".account_user_service_id_seq CASCADE;

CREATE SEQUENCE "web".account_user_service_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_user_service
(
  "id"                          integer                     NOT NULL  DEFAULT nextval('web.account_user_service_id_seq'::regclass),
  "account"                     integer                     NOT NULL,
  "key"                         uuid                        NOT NULL,
  "title"                       character varying           NOT NULL,
  "abstract_text"               character varying,
  "version"                     character varying           NOT NULL,
  "crs"                         character varying           NOT NULL,
  "encoding"                    character varying,
  "format"                      character varying           NOT NULL,
  "path"                        character varying           NOT NULL,
  "file_name"                   character varying           NOT NULL,
  "file_size"                   bigint                      NOT NULL,
  "geometry"                    geometry,
  "service_type"                character varying           NOT NULL,
  "automated_metadata"          jsonb,
  "ingest_data"                 jsonb,
  "status"                      character varying (30)      NOT NULL,
  "created_on"                  timestamp without time zone NOT NULL,
  "updated_on"                  timestamp without time zone NOT NULL,
  "process_definition"          character varying,
  "process_instance"            character varying,
  "workflow_error_details"      character varying,
  "workflow_error_messages"     jsonb,
  "helpdesk_error_message"      character varying,
  "computed_geometry"           boolean                     NOT NULL,

  CONSTRAINT pk_private_service PRIMARY KEY (id),
  CONSTRAINT uq_account_user_service_key UNIQUE ("key"),
  CONSTRAINT fk_account_user_service_account FOREIGN KEY ("account")
      REFERENCES "web".account ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE INDEX idx_provider_account_user_service_key ON  "web".account_user_service USING btree ("key");

comment on column "web".account_user_service.key is
  'Unique service identifier. The key is also the business key of the publication workflow instance';

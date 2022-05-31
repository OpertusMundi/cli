DROP TABLE    IF EXISTS "file".file_copy_resource;
DROP SEQUENCE IF EXISTS "file".file_copy_resource_id_seq;

CREATE SEQUENCE "file".file_copy_resource_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "file".file_copy_resource
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('file.file_copy_resource_id_seq'::regclass),
  "idempotent_key"                  uuid                    NOT NULL,
  "account_key"                     uuid                    NOT NULL,
  "asset_pid"                       character varying       NOT NULL,
  "resource_key"                    character varying       NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "completed_on"                    timestamp,
  "source_path"                     character varying       NOT NULL,
  "target_path"                     character varying       NOT NULL,
  "size"                            bigint                  NOT NULL,
  "error_message"                   character varying,
  CONSTRAINT pk_file_copy_resource PRIMARY KEY (id),
  CONSTRAINT uq_file_copy_resource_key UNIQUE ("idempotent_key")
);

CREATE INDEX idx_file_copy_resource_idempotent_key ON "file".file_copy_resource USING btree ("idempotent_key");

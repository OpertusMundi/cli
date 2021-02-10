--
-- Drop existing objects
--

DROP TABLE IF EXISTS "file".asset_resource CASCADE;
DROP SEQUENCE IF EXISTS "file".asset_resource_id_seq CASCADE;

DROP TABLE IF EXISTS "file".asset_additional_resource CASCADE;
DROP SEQUENCE IF EXISTS "file".asset_additional_resource_id_seq CASCADE;

--
-- Asset resources
--

CREATE SEQUENCE "file".asset_resource_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "file".asset_resource
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('file.asset_resource_id_seq'::regclass),
  "key"                             uuid                    NOT NULL,
  "pid"                             character varying,
  "draft_key"                       uuid                    NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "uploaded_by"                     integer,
  "file_name"                       character varying       NOT NULL,
  "size"                            bigint                  NOT NULL,
  "category"                        character varying,
  "format"                          character varying       NOT NULL,
  CONSTRAINT pk_asset_resource PRIMARY KEY (id),
  CONSTRAINT uq_asset_resource_key UNIQUE ("key"),
  CONSTRAINT fk_asset_resource_uploaded_by FOREIGN KEY ("uploaded_by")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE INDEX idx_asset_resource_key ON "file".asset_resource USING btree ("key");
CREATE INDEX idx_asset_resource_pid ON "file".asset_resource USING btree ("pid");
CREATE INDEX idx_asset_resource_owning_entity_key ON "file".asset_resource USING btree ("draft_key");

--
-- Asset additional file resources
--

CREATE SEQUENCE "file".asset_additional_resource_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "file".asset_additional_resource
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('file.asset_additional_resource_id_seq'::regclass),
  "key"                             uuid                    NOT NULL,
  "pid"                             character varying,  
  "draft_key"                       uuid                    NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "uploaded_by"                     integer                 NULL,
  "file_name"                       character varying       NOT NULL,
  "size"                            bigint                  NOT NULL,
  "description"                     character varying       NOT NULL,
  CONSTRAINT pk_asset_additional_resource PRIMARY KEY (id),
  CONSTRAINT uq_asset_additional_resource_key UNIQUE ("key"),
  CONSTRAINT fk_asset_additional_resource_uploaded_by FOREIGN KEY ("uploaded_by")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE INDEX idx_asset_additional_resource_key ON "file".asset_additional_resource USING btree ("key");
CREATE INDEX idx_asset_additional_resource_pid ON "file".asset_additional_resource USING btree ("pid");
CREATE INDEX idx_asset_additional_resource_owning_entity_key ON "file".asset_additional_resource USING btree ("draft_key");

--
-- Drop existing objects
--

DROP TABLE IF EXISTS "file".asset_contract_annex CASCADE;
DROP SEQUENCE IF EXISTS "file".asset_contract_annex_id_seq CASCADE;

-- Asset contract annex
--

CREATE SEQUENCE "file".asset_contract_annex_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "file".asset_contract_annex
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('file.asset_contract_annex_id_seq'::regclass),
  "key"                             character varying       NOT NULL,
  "pid"                             character varying,  
  "draft_key"                       uuid                    NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "uploaded_by"                     integer                 NULL,
  "file_name"                       character varying       NOT NULL,
  "size"                            bigint                  NOT NULL,
  "description"                     character varying       NOT NULL,
  CONSTRAINT pk_asset_contract_annex PRIMARY KEY (id),
  CONSTRAINT uq_asset_contract_annex_key UNIQUE ("key"),
  CONSTRAINT fk_asset_contract_annex_uploaded_by FOREIGN KEY ("uploaded_by")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE INDEX idx_asset_contract_annex_key ON "file".asset_contract_annex USING btree ("key");
CREATE INDEX idx_asset_contract_annex_pid ON "file".asset_contract_annex USING btree ("pid");
CREATE INDEX idx_asset_contract_annex_owning_entity_key ON "file".asset_contract_annex USING btree ("draft_key");

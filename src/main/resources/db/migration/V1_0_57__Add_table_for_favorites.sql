-- Drop
DROP TABLE IF EXISTS web."favorite_provider";
DROP TABLE IF EXISTS web."favorite_asset";

DROP TABLE IF EXISTS web."favorite";

DROP SEQUENCE IF EXISTS web."favorite_id_seq";


-- Create
CREATE SEQUENCE web."favorite_id_seq" INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE web."favorite"
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('web.favorite_id_seq'::regclass),
  -- Unique key used by the UI
  "key"                             uuid                    NOT NULL,
  -- Owner of the record
  "account"                         integer                 NOT NULL,
  -- Favorite type type:
  -- PROVIDER
  -- ASSET
  "type"                            character varying(64)   NOT NULL,
  "title"                           character varying       NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  CONSTRAINT pk_favorite PRIMARY KEY (id),
  CONSTRAINT uq_favorite_key UNIQUE ("key"),
  CONSTRAINT fk_favorite_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_favorite_type_enum CHECK
      ("type" IN ('PROVIDER', 'ASSET'))
);

CREATE TABLE web."favorite_provider"
(
  "id"                              integer                 PRIMARY KEY,
  "provider"                        integer                 NOT NULL,
  CONSTRAINT fk_favorite_provider_favorite FOREIGN KEY ("id")
      REFERENCES web."favorite" ("id")
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_favorite_provider_provider FOREIGN KEY ("provider")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE web."favorite_asset"
(
  "id"                              integer                 PRIMARY KEY,
  "asset_id"                        character varying(64)   NOT NULL,
  "asset_version"                   character varying(64)   NOT NULL,
  CONSTRAINT fk_favorite_asset_favorite FOREIGN KEY ("id")
      REFERENCES web."favorite" ("id")
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE INDEX idx_favorite_asset_asset_id ON web."favorite_asset" USING btree ("asset_id");

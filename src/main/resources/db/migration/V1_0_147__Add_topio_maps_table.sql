DROP TABLE IF EXISTS "spatial".map CASCADE;
DROP SEQUENCE IF EXISTS "spatial".map_id_seq CASCADE;

CREATE SEQUENCE "spatial".map_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "spatial".map
(
    "id"                  integer                     NOT NULL  DEFAULT nextval('spatial.map_id_seq'::regclass),
    "key"                 uuid                        NOT NULL,
    "account"             integer                     NOT NULL,
    "created_at"          timestamp                   NOT NULL,
    "updated_at"          timestamp                   NOT NULL,
    "title"               character varying           NOT NULL,
    "thumbnail_url"       character varying,
    "map_url"             character varying           NOT NULL,
    "attributes"          jsonb,
    CONSTRAINT pk_map            PRIMARY KEY (id),
    CONSTRAINT uq_map_key        UNIQUE (key),
    CONSTRAINT fk_map_account    FOREIGN KEY ("account")
      REFERENCES "web".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE INDEX idx_map_key ON "spatial".map USING btree ("key");

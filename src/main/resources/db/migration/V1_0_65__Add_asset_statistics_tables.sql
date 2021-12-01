-- Drop
DROP TABLE IF EXISTS analytics."asset_statistics_country";
DROP TABLE IF EXISTS analytics."asset_statistics";

DROP SEQUENCE IF EXISTS analytics.asset_statistics_country_id_seq;
DROP SEQUENCE IF EXISTS analytics.asset_statistics_id_seq;

--
-- Asset Statistics
--
-- Keep statistics regarding sales, prices, downloads, etc.
--

CREATE SEQUENCE "analytics".asset_statistics_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE analytics."asset_statistics"
(
  "id"                  integer                     NOT NULL  DEFAULT nextval('analytics.asset_statistics_id_seq'::regclass),
  "pid"                 character varying           NOT NULL,
  "segment"             character varying(40),
  "publication_date"    timestamp                   NOT NULL,
  "year"                integer                     NOT NULL,
  "month"               integer                     NOT NULL,
  "week"                integer                     NOT NULL,
  "day"                 integer                     NOT NULL,
  "max_price"           numeric(20,6),
  "downloads"           integer                     NOT NULL DEFAULT 0,
  "sales"               integer                     NOT NULL DEFAULT 0,
  "active"              boolean                     NOT NULL DEFAULT true,
  CONSTRAINT pk_asset_statistics PRIMARY KEY (id)
);

CREATE INDEX asset_statistics_pid ON analytics."asset_statistics" USING btree ("pid");

--
-- Asset Statistics Country
--
-- When a new file asset is published, a new record for every country that the asset intersects with, is inserted.
-- When a file asset is unpublished, the corresponding records are deleted.
--

CREATE SEQUENCE "analytics".asset_statistics_country_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE analytics."asset_statistics_country"
(
  "id"                  integer                     NOT NULL  DEFAULT nextval('analytics.asset_statistics_country_id_seq'::regclass),
  "statistic"           integer                     NOT NULL,
  "country_code"        character varying(3)        NOT NULL,
  CONSTRAINT pk_asset_statistics_country PRIMARY KEY (id),
  CONSTRAINT uq_asset_statistics_country_key UNIQUE (statistic, country_code),
  CONSTRAINT fk_asset_statistics_countries_asset_statistics FOREIGN KEY (statistic)
    REFERENCES analytics."asset_statistics" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
);

CREATE INDEX asset_statistics_country_pid ON analytics."asset_statistics_country" USING btree ("statistic");

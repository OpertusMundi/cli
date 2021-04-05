--
-- Create schema for spatial data
--

CREATE SCHEMA IF NOT EXISTS "spatial"; 

--
-- Table for NUTS regions with population information
--
-- NUTS       (2016, GDB)  source: https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts
-- POPULATION (2019, 2020) source: https://ec.europa.eu/eurostat/databrowser/view/demo_r_pjangrp3/default/table?lang=en
--

DROP TABLE IF EXISTS "spatial".nuts;

CREATE TABLE "spatial".nuts (
  "gid"           serial,
  "objectid"      numeric,
  "lvl_code"      int8,
  "nuts_id"       varchar(5),
  "name_asci"     varchar(254),
  "name_latin"    varchar(254),
  "nuts_name"     varchar(254),
  "country"       varchar(254),
  "population"    int8,
  "pop_year"      int8,
  "geom"          geometry(MULTIPOLYGON, 4326),
  "geom_simple"   geometry(MULTIPOLYGON, 4326),
  CONSTRAINT pk_nuts PRIMARY KEY (gid)
);

CREATE INDEX idx_nuts_name_latin ON "spatial".nuts USING btree ("name_latin");
CREATE INDEX idx_nuts_nuts_name ON "spatial".nuts USING btree ("nuts_name");

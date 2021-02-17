--
-- Drop existing objects
--

DROP TABLE IF EXISTS "provider".asset_metadata_property CASCADE;
DROP SEQUENCE IF EXISTS "provider".asset_metadata_property_id_seq CASCADE;

--
-- Asset metadata property table
--

CREATE SEQUENCE "provider".asset_metadata_property_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "provider".asset_metadata_property
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('provider.asset_metadata_property_id_seq'::regclass),
  -- VECTOR, RASTER or NETCDF
  "asset_type"                      character varying(10)   NOT NULL,
  "name"                            character varying(30)   NOT NULL,
  -- PNG or JSON
  "type"                            character varying(20)   NOT NULL,
  CONSTRAINT pk_asset_metadata_property PRIMARY KEY (id),
  CONSTRAINT uq_asset_metadata_property_name UNIQUE ("asset_type", "name")
);

CREATE INDEX idx_asset_metadata_property_name ON "provider".asset_metadata_property USING btree ("asset_type", "name");

-- Insert defaults
insert into "provider".asset_metadata_property (asset_type, "name", "type") values
 ('VECTOR', 'mbrStatic',        'PNG'),
 ('VECTOR', 'convexHullStatic', 'PNG'),
 ('VECTOR', 'thumbnail',        'PNG'),
 ('VECTOR', 'heatmapStatic',    'PNG'),
 ('VECTOR', 'clustersStatic',   'PNG'),
 ('VECTOR', 'heatmap',          'JSON'),
 ('NETCDF', 'mbrStatic',        'PNG'),
 ('RASTER', 'mbrStatic',        'PNG')
 ;

ALTER TABLE "file".asset_resource ADD IF NOT EXISTS "source" character varying(30) NOT NULL DEFAULT('NONE');

comment on column "file".asset_resource.source is
  'Indicates the source of the resource file';

ALTER TABLE "file".asset_resource DROP CONSTRAINT IF EXISTS chk_asset_resource_source_enum;

ALTER TABLE "file".asset_resource ADD CONSTRAINT chk_asset_resource_source_enum CHECK
  ("source" IN ('NONE', 'PARENT_DATASOURCE', 'FILE_SYSTEM', 'UPLOAD'));
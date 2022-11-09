ALTER TABLE "file".asset_resource DROP CONSTRAINT IF EXISTS chk_asset_resource_source_enum;

ALTER TABLE "file".asset_resource ADD CONSTRAINT chk_asset_resource_source_enum CHECK
  ("source" IN ('NONE', 'PARENT_DATASOURCE', 'FILE_SYSTEM', 'UPLOAD', 'EXTERNAL_URL'));
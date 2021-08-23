-- Drop existing columns
ALTER TABLE provider.asset_draft DROP COLUMN IF EXISTS "type";
ALTER TABLE provider.asset_draft DROP COLUMN IF EXISTS "service_type";

-- Create columns
ALTER TABLE provider.asset_draft ADD COLUMN "type" character varying;
ALTER TABLE provider.asset_draft ADD COLUMN "service_type" character varying;

-- Set defaults for existing rows
update provider.asset_draft set "type" = data::json->>'type', "service_type" = data::json->>'spatialDataServiceType';

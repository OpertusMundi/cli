-- Drop existing columns
ALTER TABLE file.asset_resource DROP COLUMN IF EXISTS "encoding";
ALTER TABLE file.asset_resource DROP COLUMN IF EXISTS "crs";

-- Create columns
ALTER TABLE file.asset_resource ADD COLUMN "encoding" character varying;
ALTER TABLE file.asset_resource ADD COLUMN "crs" character varying;

-- Drop existing column
ALTER TABLE provider.asset_draft DROP COLUMN IF EXISTS "parent_id";

-- Create column
ALTER TABLE provider.asset_draft ADD COLUMN "parent_id" character varying;

-- Set defaults for existing rows
update provider.asset_draft set "parent_id" = data::json->>'parentId';
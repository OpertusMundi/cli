ALTER TABLE "web".favorite_asset DROP CONSTRAINT IF EXISTS chk_favorite_asset_action_enum;
ALTER TABLE "web".favorite_asset ADD IF NOT EXISTS "action" character varying(15) NULL;

update "web".favorite_asset set action = 'FAVORITE' where "action" IS NULL;

ALTER TABLE "web".favorite_asset ALTER COLUMN "action" SET NOT NULL;
ALTER TABLE "web".favorite_asset ADD CONSTRAINT chk_favorite_asset_action_enum CHECK
  ("action" IN ('FAVORITE', 'PURCHASE')
);

ALTER TABLE "web".account_asset DROP CONSTRAINT IF EXISTS fk_account_asset_provider;

ALTER TABLE "web".account_asset ADD IF NOT EXISTS "provider" integer;

-- Update existing records
update	web.account_asset u
set 	provider = (
	select	i.provider
	from	web.account_asset a
				inner join "order".order o
					on a."order" = o.id
				inner join "order".order_item i
					on o.id = i."order" and a.asset = i.asset_pid and a.asset = u.asset
	where u.id = a.id
);

ALTER TABLE "web".account_asset ALTER COLUMN "provider" SET NOT NULL;

ALTER TABLE "web".account_asset ADD CONSTRAINT fk_account_asset_provider FOREIGN KEY ("provider")
  REFERENCES "web".account (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE;
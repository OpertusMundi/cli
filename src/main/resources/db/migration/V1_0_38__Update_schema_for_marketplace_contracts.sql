--
-- Add contract fields to order item
--

ALTER TABLE "order".order_item ADD IF NOT EXISTS "contract_template_id"      integer;
ALTER TABLE "order".order_item ADD IF NOT EXISTS "contract_template_version" integer;
ALTER TABLE "order".order_item ADD IF NOT EXISTS "contract_signed_on"        timestamp;

--
-- Alter table order item, rename item to `asset_pid` and version to `asset_version`
--

ALTER TABLE "order".order_item RENAME COLUMN "item"     to "asset_pid";
ALTER TABLE "order".order_item RENAME COLUMN "version"  to "asset_version";

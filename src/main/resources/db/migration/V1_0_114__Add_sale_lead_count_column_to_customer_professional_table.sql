ALTER TABLE "web".customer_professional ADD IF NOT EXISTS "sale_lead_count" integer DEFAULT(0) NOT NULL;

UPDATE  "web".customer_professional cp
SET     sale_lead_count = (
  SELECT  count(*)
  FROM    "web".favorite_asset f INNER JOIN web.customer c ON f.asset_provider = c.account and c.id = cp.id
  WHERE   "action" = 'PURCHASE' and f.asset_provider = c.account
);
ALTER TABLE "order".order_item DROP CONSTRAINT IF EXISTS chk_order_item_type_enum;

update "order".order_item set "type" = 'SUBSCRIPTION' where "type" = 'SERVICE';

ALTER TABLE "order".order_item ADD CONSTRAINT chk_order_item_type_enum CHECK
  ("type" IN (
    'ASSET', 'SUBSCRIPTION'
  ));

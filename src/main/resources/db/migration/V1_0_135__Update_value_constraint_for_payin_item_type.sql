ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS chk_payin_item_type_enum;

update "billing".payin_item set "type" = 'SERVICE_BILLING' where "type" = 'SUBSCRIPTION_BILLING';

ALTER TABLE "billing".payin_item ADD CONSTRAINT chk_payin_item_type_enum CHECK
  ("type" IN ('ORDER', 'SERVICE_BILLING'));

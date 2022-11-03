ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS chk_payin_item_type_enum;

ALTER TABLE "billing".payin_item ADD CONSTRAINT chk_payin_item_type_enum CHECK
  ("type" IN ('ORDER', 'SUBSCRIPTION_BILLING'));

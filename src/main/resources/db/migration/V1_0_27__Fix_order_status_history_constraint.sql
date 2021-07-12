ALTER TABLE "order".order_status_hist DROP CONSTRAINT IF EXISTS chk_order_status_hist_status_enum;

ALTER TABLE "order".order_status_hist ADD CONSTRAINT chk_order_status_hist_status_enum CHECK
  ("status" IN ('CREATED', 'CHARGED' ,'PENDING', 'CANCELLED', 'REFUNDED', 'SUCCEEDED'));

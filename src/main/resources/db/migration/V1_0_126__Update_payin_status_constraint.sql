ALTER TABLE "billing".payin DROP CONSTRAINT IF EXISTS chk_payin_status_enum;

ALTER TABLE "billing".payin ADD CONSTRAINT chk_payin_status_enum CHECK
  ("status" IN ('NotSpecified', 'CREATED', 'FAILED', 'SUCCEEDED'));

ALTER TABLE "billing".payin_status_hist DROP CONSTRAINT IF EXISTS chk_payin_status_hist_status_enum;

ALTER TABLE "billing".payin_status_hist ADD CONSTRAINT chk_payin_status_hist_status_enum CHECK
  ("status" IN ('NotSpecified', 'CREATED', 'FAILED', 'SUCCEEDED'))

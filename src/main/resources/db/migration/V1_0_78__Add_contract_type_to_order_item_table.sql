ALTER TABLE "order".order_item ADD IF NOT EXISTS "contract_type"  character varying(64) NOT NULL DEFAULT ('MASTER_CONTRACT');

ALTER TABLE "order".order_item ADD CONSTRAINT chk_order_item_contract_type_enum CHECK
  ("contract_type" IN ('MASTER_CONTRACT', 'UPLOADED_CONTRACT' ));
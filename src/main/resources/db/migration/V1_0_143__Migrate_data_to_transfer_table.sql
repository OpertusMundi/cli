select * from billing.payin_item;

-- Migrate data only if column `transfer_key` from older schema version exists
DO $$
BEGIN
  IF EXISTS(
    SELECT  *
    FROM    information_schema.columns
    WHERE   "table_schema" = 'billing' and "table_name"='payin_item' and "column_name"='transfer_key')
  THEN
    -- Create temp copy of the transfer transaction id
    ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "transfer_transaction_id" character varying(20);

    UPDATE "billing".payin_item set transfer_transaction_id = transfer;

    -- Change transfer column type
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer";
    ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "transfer" integer;

    -- Create new transfer records
    INSERT INTO "billing".transfer (
            "debited_funds",
            "credited_funds",
            "fees",
            "currency",
            "transaction_id",
            "transaction_status",
            "creation_date",
            "execution_date",
            "result_code",
            "result_message",
            "key",
            "refund"
    )
    SELECT  "transfer_credited_funds" + "transfer_platform_fees",
            "transfer_credited_funds",
            "transfer_platform_fees",
            'EUR',
            "transfer_transaction_id",
            "transfer_status",
            "transfer_created_on",
            "transfer_executed_on",
            "transfer_result_code",
            "transfer_result_message",
            "transfer_key",
            "transfer_refund"
    FROM    "billing".payin_item
    WHERE   "transfer_transaction_id" is not null;

    -- Update payin_item transfer column
    UPDATE "billing".payin_item set transfer = (
      SELECT "id" from "billing".transfer where transaction_id = transfer_transaction_id
    );

    -- Cleanup columns
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_transaction_id";

    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_credited_funds";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_platform_fees";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_status";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_created_on";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_executed_on";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_result_code";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_result_message";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_key";
    ALTER TABLE "billing".payin_item DROP COLUMN IF EXISTS "transfer_refund";
  END IF;
END $$;

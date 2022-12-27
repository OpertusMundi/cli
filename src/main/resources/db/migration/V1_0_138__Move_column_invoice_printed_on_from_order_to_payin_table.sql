DO $$
BEGIN
  IF NOT EXISTS(SELECT *
    FROM information_schema.columns
    WHERE "table_schema" = 'billing' and "table_name"='payin' and "column_name"='invoice_printed_on')
  THEN
    ALTER TABLE "billing".payin ADD "invoice_printed_on" timestamp;

    UPDATE "billing".payin SET invoice_printed_on = (
      select  o.invoice_printed_on
      from    "order".order o
      where   o.payin = "billing".payin.id
    );
  END IF;

  ALTER TABLE "order".order DROP COLUMN IF EXISTS "invoice_printed_on";
END $$;

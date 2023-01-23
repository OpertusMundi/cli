ALTER TABLE "billing".refund ADD IF NOT EXISTS "initial_transaction_key" uuid NOT NULL;

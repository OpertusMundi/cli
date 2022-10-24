ALTER TABLE web.account_client  DROP CONSTRAINT "uq_account_client_key";
DROP INDEX web."idx_account_client_account_key";
DROP INDEX web."idx_account_client_key";
CREATE UNIQUE INDEX "idx_account_client_id" ON web.account_client ("client_id");


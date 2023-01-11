-- Create refund table
DROP TABLE IF EXISTS billing.refund;
DROP SEQUENCE IF EXISTS billing.refund_id_seq CASCADE;

CREATE SEQUENCE "billing".refund_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE IF NOT EXISTS billing.refund
(
    "id"                          integer                  NOT NULL  DEFAULT nextval('billing.refund_id_seq'::regclass),
    "key"                         uuid                     NOT NULL,
    "reference_number"            character varying(20),
    "initiator"                   integer,
    "consumer"                    integer,
    "provider"                    integer,
    "debited_funds"               numeric(20,6)            NOT NULL,
    "credited_funds"              numeric(20,6)            NOT NULL,
    "fees"                        numeric(20,6)            NOT NULL,
    "currency"                    character varying(3)     NOT NULL,
    "debited_wallet_id"           character varying(20),
    "credited_wallet_id"          character varying(20),
    "author_id"                   character varying(20),
    "credited_user_id"            character varying(20),
    "creation_date"               timestamp                NOT NULL,
    "execution_date"              timestamp                NOT NULL,
    "result_code"                 character varying,
    "result_message"              character varying,
    "transaction_id"              character varying(20)    NOT NULL,
    "transaction_status"          character varying(64)    NOT NULL,
    "transaction_nature"          character varying(64)    NOT NULL,
    "transaction_type"            character varying(64)    NOT NULL,
    "initial_transaction_id"      character varying(20)    NOT NULL,
    "initial_transaction_type"    character varying(64)    NOT NULL,
    "refund_reason_type"          character varying(64)    NOT NULL,
    "refund_reason_message"       character varying,
    CONSTRAINT pk_refund PRIMARY KEY (id),
    CONSTRAINT uq_refund_key UNIQUE (key),
    CONSTRAINT fk_refund_initiator FOREIGN KEY (initiator)
        REFERENCES "admin".account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_refund_consumer FOREIGN KEY (consumer)
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_refund_provider FOREIGN KEY (provider)
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT chk_refund_transaction_nature_enum CHECK
      ("transaction_nature" IN ('REGULAR', 'REPUDIATION', 'REFUND', 'SETTLEMENT')),
    CONSTRAINT chk_refund_transaction_status_enum CHECK
      ("transaction_status" IN ('CREATED', 'SUCCEEDED', 'FAILED')),
    CONSTRAINT chk_refund_transaction_type_enum CHECK
      ("transaction_type" IN ('PAYIN', 'TRANSFER', 'PAYOUT')),
    CONSTRAINT chk_refund_initial_transaction_type_enum CHECK
      ("initial_transaction_type" IN ('PAYIN', 'TRANSFER', 'PAYOUT')),
    CONSTRAINT chk_refund_refund_reason_type_enum CHECK
      ("refund_reason_type" IN (
        'INITIALIZED_BY_CLIENT', 'BANKACCOUNT_INCORRECT', 'OWNER_DO_NOT_MATCH_BANKACCOUNT',
        'BANKACCOUNT_HAS_BEEN_CLOSED', 'WITHDRAWAL_IMPOSSIBLE_ON_SAVINGS_ACCOUNTS', 'OTHER'
      ))
);

-- Create/Update columns for refunds to other tables
ALTER TABLE "analytics".payin_item_hist ADD IF NOT EXISTS "refund" boolean NOT NULL DEFAULT(false);

ALTER TABLE "billing".payin ADD IF NOT EXISTS "refund" integer;

ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "transfer_refund" integer;

ALTER TABLE "billing".payout ADD         IF NOT EXISTS "refund"  integer;
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund";
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund_created_on";
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund_executed_on";
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund_status";
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund_reason_type";
ALTER TABLE "billing".payout DROP COLUMN IF EXISTS     "provider_refund_reason_message";

ALTER TABLE "billing".service_billing ADD IF NOT EXISTS "refund" boolean NOT NULL DEFAULT(false);

-- Create/Drop indexes
CREATE INDEX idx_refund_key ON "billing".refund USING btree ("key");
CREATE INDEX idx_refund_transaction_id ON "billing".refund USING btree ("transaction_id");
CREATE INDEX idx_refund_initial_transaction_id ON "billing".refund USING btree ("initial_transaction_id");

DROP INDEX IF EXISTS "billing".idx_payin_refund;
CREATE INDEX idx_payin_refund ON "billing".payin USING btree ("refund");

DROP INDEX IF EXISTS "billing".idx_payin_item_provider_transfer;
DROP INDEX IF EXISTS "billing".idx_payin_item_transfer;
DROP INDEX IF EXISTS "billing".idx_payin_item_transfer_refund;
CREATE INDEX idx_payin_item_transfer ON "billing".payin_item USING btree ("transfer");
CREATE INDEX idx_payin_item_transfer_refund ON "billing".payin_item USING btree ("transfer_refund");

DROP INDEX IF EXISTS "billing".idx_payout_refund;
CREATE INDEX idx_payout_refund ON "billing".payout USING btree ("refund");

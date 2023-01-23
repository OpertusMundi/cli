DROP TABLE IF EXISTS billing.dispute;
DROP SEQUENCE IF EXISTS billing.dispute_id_seq CASCADE;

CREATE SEQUENCE "billing".dispute_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE IF NOT EXISTS billing.dispute
(
    "id"                              integer                  NOT NULL  DEFAULT nextval('billing.dispute_id_seq'::regclass),
    "key"                             uuid                     NOT NULL,
    "creation_date"                   timestamp                NOT NULL,
    "transaction_id"                  character varying(20)    NOT NULL,
    "repudiation_id"                  character varying(20)    NOT NULL,
    "type"                            character varying(64)    NOT NULL,
    "status"                          character varying(64)    NOT NULL,
    "status_message"                  character varying(64),
    "contest_deadline_date"           timestamp,
    "disputed_funds"                  numeric(20,6)            NOT NULL,
    "contested_funds"                 numeric(20,6)            NOT NULL,
    "reason_type"                     character varying(64)    NOT NULL,
    "reason_message"                  character varying,
    "result_code"                     character varying,
    "result_message"                  character varying,
    "payin"                           integer,
    "initial_transaction_id"          character varying(20)    NOT NULL,
    "initial_transaction_key"         uuid                     NOT NULL,
    "initial_transaction_ref_number"  character varying(20)    NOT NULL,
    "initial_transaction_type"        character varying(64)    NOT NULL,
    CONSTRAINT pk_dispute PRIMARY KEY (id),
    CONSTRAINT uq_dispute_key UNIQUE (key),
    CONSTRAINT fk_dispute_payin FOREIGN KEY (payin)
      REFERENCES billing.payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION
      ON DELETE SET NULL,
    CONSTRAINT chk_dispute_type_enum CHECK
      ("type" IN ('CONTESTABLE', 'NOT_CONTESTABLE', 'RETRIEVAL')),
    CONSTRAINT chk_dispute_initial_transaction_type_enum CHECK
      ("initial_transaction_type" IN ('PAYIN', 'TRANSFER', 'PAYOUT')),
    CONSTRAINT chk_dispute_status_enum CHECK
      ("status" IN (
        'CREATED', 'PENDING_CLIENT_ACTION', 'SUBMITTED', 'PENDING_BANK_ACTION', 'REOPENED_PENDING_CLIENT_ACTION', 'CLOSED'
      )),
    CONSTRAINT chk_dispute_reason_type_enum CHECK
      ("reason_type" IN (
        'DUPLICATE', 'FRAUD', 'PRODUCT_UNACCEPTABLE', 'UNKNOWN', 'OTHER', 'REFUND_CONVERSION_RATE',
        'LATE_FAILURE_INSUFFICIENT_FUNDS', 'LATE_FAILURE_CONTACT_USER', 'LATE_FAILURE_BANKACCOUNT_CLOSED',
        'LATE_FAILURE_BANKACCOUNT_INCOMPATIBLE', 'LATE_FAILURE_BANKACCOUNT_INCORRECT', 'AUTHORISATION_DISPUTED',
        'TRANSACTION_NOT_RECOGNIZED', 'PRODUCT_NOT_PROVIDED', 'CANCELED_REOCCURING_TRANSACTION', 'REFUND_NOT_PROCESSED'
      ))
);

CREATE INDEX idx_dispute_key ON "billing".dispute USING btree ("key");
CREATE INDEX idx_dispute_transaction_id ON "billing".dispute USING btree ("transaction_id");
CREATE INDEX idx_dispute_initial_transaction_id ON "billing".dispute USING btree ("initial_transaction_id");

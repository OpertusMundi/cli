-- Drop & Create transfer table
DROP TABLE IF EXISTS billing.transfer;
DROP SEQUENCE IF EXISTS billing.transfer_id_seq CASCADE;

CREATE SEQUENCE "billing".transfer_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE IF NOT EXISTS billing.transfer
(
    "id"                          integer                  NOT NULL  DEFAULT nextval('billing.transfer_id_seq'::regclass),
    "key"                         uuid                     NOT NULL,
    "initiator"                   integer,
    "consumer"                    integer,
    "provider"                    integer,
    "author_id"                   character varying(20),
    "credited_user_id"            character varying(20),
    "debited_funds"               numeric(20,6)            NOT NULL,
    "credited_funds"              numeric(20,6)            NOT NULL,
    "fees"                        numeric(20,6)            NOT NULL,
    "currency"                    character varying(3)     NOT NULL,
    "transaction_id"              character varying(20)    NOT NULL,
    "transaction_status"          character varying(64)    NOT NULL,
    "transaction_nature"          character varying(64),
    "transaction_type"            character varying(64),
    "result_code"                 character varying,
    "result_message"              character varying,
    "creation_date"               timestamp                NOT NULL,
    "execution_date"              timestamp                NOT NULL,
    "debited_wallet_id"           character varying(20),
    "credited_wallet_id"          character varying(20),
    "refund"                      integer,
    CONSTRAINT pk_transfer                PRIMARY KEY ("id"),
    CONSTRAINT uq_transfer_key            UNIQUE ("key"),
    CONSTRAINT uq_transfer_transaction_id UNIQUE ("transaction_id"),
    CONSTRAINT fk_transfer_initiator      FOREIGN KEY ("initiator")
        REFERENCES "admin".account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_transfer_consumer FOREIGN KEY ("consumer")
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_transfer_provider FOREIGN KEY ("provider")
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_transfer_refund FOREIGN KEY ("refund")
        REFERENCES billing.refund (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT chk_transfer_transaction_nature_enum CHECK
      ("transaction_nature" IN ('REGULAR', 'REPUDIATION', 'REFUND', 'SETTLEMENT')),
    CONSTRAINT chk_transfer_transaction_status_enum CHECK
      ("transaction_status" IN ('CREATED', 'SUCCEEDED', 'FAILED')),
    CONSTRAINT chk_transfer_transaction_type_enum CHECK
      ("transaction_type" IN ('PAYIN', 'TRANSFER', 'PAYOUT'))
);

-- Create indexes
CREATE INDEX idx_transfer_key ON "billing".transfer USING btree ("key");
CREATE INDEX idx_transfer_transaction_id ON "billing".transfer USING btree ("transaction_id");

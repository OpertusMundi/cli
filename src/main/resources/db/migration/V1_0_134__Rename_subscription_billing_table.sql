-- Disable constraints
ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS fk_payin_item_subscription_billing;
ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS fk_payin_item_service_billing;

-- DROP and CREATE subscription billing table
DROP TABLE IF EXISTS "billing".subscription_billing CASCADE;
DROP SEQUENCE IF EXISTS "billing".subscription_billing_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".service_billing CASCADE;
DROP SEQUENCE IF EXISTS "billing".service_billing_id_seq CASCADE;

CREATE SEQUENCE "billing".service_billing_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".service_billing
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.
  service_billing_id_seq'::regclass),
  "key"                             uuid                    NOT NULL,
  "type"                            character varying(64)   NOT NULL,
  "billed_account"                  integer                 NOT NULL,
  "subscription"                    integer,
  "user_service"                    integer,
  "pricing_model"					          jsonb                   NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "updated_on"                      timestamp               NOT NULL,
  "from_date"                       date                    NOT NULL,
  "to_date"                         date                    NOT NULL,
  "due_date"                        date                    NOT NULL,
  "total_rows"                      integer                 NOT NULL,
  "total_calls"                     integer                 NOT NULL,
  "sku_total_rows"                  integer                 NOT NULL,
  "sku_total_calls"                 integer                 NOT NULL,
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  "status"                          character varying(64)   NOT NULL,
  "payin"                           integer,
  "stats"                           jsonb                   NOT NULL,
  CONSTRAINT pk_service_billing PRIMARY KEY (id),
  CONSTRAINT fk_service_billing_billed_account FOREIGN KEY ("billed_account")
      REFERENCES "web".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_service_billing_subscription FOREIGN KEY ("subscription")
      REFERENCES "web".account_subscription (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_service_billing_user_service FOREIGN KEY ("user_service")
      REFERENCES "web".account_user_service (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_service_billing_payin FOREIGN KEY ("payin")
      REFERENCES "billing".payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_service_billing_type_enum CHECK
      ("type" IN ('SUBSCRIPTION', 'PRIVATE_OGC_SERVICE')),
  CONSTRAINT chk_service_billing_status_enum CHECK
      ("status" IN ('NO_CHARGE', 'DUE', 'FAILED', 'PAID'))
);

-- Rename column "subscription_billing" in table payin_item
DO $$
BEGIN
  IF EXISTS(SELECT *
    FROM information_schema.columns
    WHERE "table_schema" = 'billing' and "table_name"='payin_item' and "column_name"='subscription_billing')
  THEN
      ALTER TABLE "billing".payin_item RENAME COLUMN subscription_billing TO service_billing;
  END IF;
END $$;



-- Enable constraints
ALTER TABLE "billing".payin_item ADD CONSTRAINT fk_payin_item_service_billing FOREIGN KEY ("service_billing")
  REFERENCES "billing".service_billing (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE CASCADE;

-- Indexes
CREATE INDEX "idx_service_billing_key" ON "billing".service_billing USING btree ("key");

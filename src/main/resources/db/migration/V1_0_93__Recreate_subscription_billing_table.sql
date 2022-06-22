-- Disable constraints
ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS fk_payin_item_subscription_billing;

-- DROP and CREATE subscription billing table
DROP TABLE IF EXISTS "billing".subscription_billing CASCADE;
DROP SEQUENCE IF EXISTS "billing".subscription_billing_id_seq CASCADE;

CREATE SEQUENCE "billing".subscription_billing_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".subscription_billing
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.subscription_billing_id_seq'::regclass),
  "subscription"                    integer                 NOT NULL,
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
  CONSTRAINT pk_subscription_billing PRIMARY KEY (id),
  CONSTRAINT fk_subscription_billing_subscription FOREIGN KEY ("subscription")
      REFERENCES "web".account_subscription (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_subscription_billing_payin FOREIGN KEY ("payin")
      REFERENCES "billing".payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_subscription_billing_status_enum CHECK
      ("status" IN ('NO_CHARGE', 'DUE', 'FAILED', 'PAID'))
);

-- Enable constraints
ALTER TABLE "billing".payin_item ADD CONSTRAINT fk_payin_item_subscription_billing FOREIGN KEY ("subscription_billing")
  REFERENCES "billing".subscription_billing (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE CASCADE;
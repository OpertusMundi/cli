--
-- Disable dependant constraints
--

ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS fk_payin_item_subscription_billing;
ALTER TABLE "billing".payin_recurring_registration DROP CONSTRAINT IF EXISTS fk_payin_recurring_registration_subscription;

--
-- Drop existing schema objects
--

DROP TABLE IF EXISTS "billing".subscription_billing CASCADE;
DROP SEQUENCE IF EXISTS "billing".subscription_billing_id_seq CASCADE;

DROP TABLE IF EXISTS "web".account_subscription_sku CASCADE;
DROP SEQUENCE IF EXISTS "web".account_subscription_sku_id_seq CASCADE;

DROP TABLE IF EXISTS "web".account_subscription CASCADE;
DROP SEQUENCE IF EXISTS "web".account_sub_id_seq CASCADE;

--
-- User purchased subscriptions
--

CREATE SEQUENCE "web".account_sub_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_subscription
(
  "id"                              integer                NOT NULL   DEFAULT nextval('web.account_sub_id_seq'::regclass),
  "consumer"                        integer                NOT NULL,
  "provider"                        integer                NOT NULL,
  "order"                           integer                NOT NULL,
  "asset"                           character varying      NOT NULL,
  "added_on"                        timestamp              NOT NULL,
  "expires_on"                      timestamp,
  "updated_on"                      timestamp              NOT NULL,
  "cancelled_on"                    timestamp,
  "last_payin_date"                 timestamp              NOT NULL,
  "next_payin_date"                 timestamp,
  "source"                          character varying(32)  NOT NULL,
  "segment"                         character varying(64),
  "status"                          character varying(20)  NOT NULL   DEFAULT('CREATED'),
  "payin_recurring_registration"    int,
  CONSTRAINT pk_account_sub PRIMARY KEY (id),
  CONSTRAINT fk_account_sub_consumer FOREIGN KEY ("consumer")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_account_sub_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_account_subscription_payin_recurring_reg FOREIGN KEY ("payin_recurring_registration")
      REFERENCES "billing".payin_recurring_registration (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_account_subscription_source_enum CHECK
      ("source" IN ('PURCHASE', 'UPDATE')),
  CONSTRAINT chk_account_subscription_status_enum CHECK
      ("status" IN ('CREATED', 'ACTIVE', 'INACTIVE'))
);

comment on column "web".account_subscription.consumer is
  'Reference to the subscription owner account';
comment on column "web".account_subscription.provider is
  'Reference to the subscription asset seller account';
comment on column "web".account_subscription.order is
  'Order of purchase. For updated assets the order is copied';
comment on column "web".account_subscription.asset is
  'The PID of the subscription asset';
comment on column "web".account_subscription.added_on is
  'Date subscription added to user account. Next billing date is computed based on this date';
comment on column "web".account_subscription.expires_on is
  'When the subscription will expire. Applicable only for subscription with recurring payments';
comment on column "web".account_subscription.updated_on is
  'Date updated i.e. add new SKU records';
comment on column "web".account_subscription.last_payin_date is
  'The date of the first payin';
comment on column "web".account_subscription.next_payin_date is
  'The date of the next payin';
comment on column "web".account_subscription.source is
  'Service source: PURCHASE (new asset), UPDATE (version update of existing asset)';
comment on column "web".account_subscription.segment is
  'Item segment (first topic if any exist)';
comment on column "web".account_subscription.status is
  'Subscription status: CREATED=Subscription has been created but a CIT payin is required, ACTIVE=Subscription is active and billed periodically, INACTIVE=Subscription has been cancelled by the user or ended';

--
-- Subscription SKUs
--

CREATE SEQUENCE "web".account_subscription_sku_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_subscription_sku
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('web.account_subscription_sku_id_seq'::regclass),
  -- Parent subscription
  "subscription"                    integer                 NOT NULL,
  -- Order item
  "order"                           integer                 NOT NULL,
  -- Available calls/rows
  "purchased_rows"                  integer                 NOT NULL,
  "purchased_calls"                 integer                 NOT NULL,
  -- Used calls/rows (computed during billing)
  "used_rows"                       integer                 NOT NULL,
  "used_calls"                      integer                 NOT NULL,
  CONSTRAINT pk_account_sub_sku PRIMARY KEY (id),
  CONSTRAINT fk_account_sub_sku_subscription FOREIGN KEY ("subscription")
      REFERENCES web.account_subscription (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_account_sub_sku_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

--
-- Subscription billing
--

CREATE SEQUENCE "billing".subscription_billing_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".subscription_billing
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.subscription_billing_id_seq'::regclass),
  -- Parent subscription
  "subscription"                    integer                 NOT NULL,
  -- Billing interval
  "from_date"                       timestamp               NOT NULL,
  "to_date"                         timestamp               NOT NULL,
  -- Calls/Rows used
  "total_rows"                      integer                 NOT NULL,
  "total_calls"                     integer                 NOT NULL,
  -- Pre-purchased Calls/Rows
  "sku_total_rows"                  integer                 NOT NULL,
  "sku_total_calls"                 integer                 NOT NULL,
  -- Price
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  CONSTRAINT pk_subscription PRIMARY KEY (id),
  CONSTRAINT fk_subscription_subscription FOREIGN KEY ("subscription")
      REFERENCES "web".account_subscription (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

--
-- Enable constraints
--

ALTER TABLE "billing".payin_item ADD CONSTRAINT fk_payin_item_subscription_billing FOREIGN KEY ("subscription_billing")
  REFERENCES "billing".subscription_billing (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "billing".payin_recurring_registration ADD CONSTRAINT fk_payin_recurring_registration_subscription FOREIGN KEY ("subscription")
  REFERENCES "web".account_subscription (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE CASCADE;

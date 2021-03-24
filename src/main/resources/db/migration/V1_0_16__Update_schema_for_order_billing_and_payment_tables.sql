CREATE SCHEMA IF NOT EXISTS "billing";

--
-- Drop existing objects
--

DROP TABLE IF EXISTS "web".account_asset CASCADE;
DROP SEQUENCE IF EXISTS "web".account_asset_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".payin_item CASCADE;
DROP SEQUENCE IF EXISTS "billing".payin_item_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".subscription_billing CASCADE;
DROP SEQUENCE IF EXISTS "billing".subscription_billing_id_seq CASCADE;

DROP TABLE IF EXISTS "web".account_subscription_sku CASCADE;
DROP SEQUENCE IF EXISTS "web".account_subscription_sku_id_seq CASCADE;

DROP TABLE IF EXISTS "web".account_subscription CASCADE;
DROP SEQUENCE IF EXISTS "web".account_sub_id_seq CASCADE;

DROP TABLE IF EXISTS "order".order_status_hist CASCADE;
DROP SEQUENCE IF EXISTS "order".order_status_hist_id_seq CASCADE;

DROP TABLE IF EXISTS "order".order_item CASCADE;
DROP SEQUENCE IF EXISTS "order".order_item_id_seq CASCADE;

DROP TABLE IF EXISTS "order".order CASCADE;
DROP SEQUENCE IF EXISTS "order".order_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".payin_status_hist CASCADE;
DROP SEQUENCE IF EXISTS "billing".payin_status_hist_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".payin_bankwire;
DROP TABLE IF EXISTS "billing".payin_card_direct;
DROP TABLE IF EXISTS "billing".payin CASCADE;
DROP SEQUENCE IF EXISTS "billing".payin_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".payout CASCADE;
DROP SEQUENCE IF EXISTS "billing".payout_id_seq CASCADE;

--
-- PayIn
--
-- A PayIn is created during a purchase from the marketplace or
-- periodically by the platform for charging service subscriptions

CREATE SEQUENCE "billing".payin_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".payin
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.payin_id_seq'::regclass),
  "key"                             uuid                    NOT NULL, 
  -- Reference to the platform user
  "account"                         integer                 NOT NULL,
  -- Price aggregate values from payment items
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  -- Payment currency. Currently only EUR is supported
  "currency"                        character varying(3)    NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "executed_on"                     timestamp,
  -- PayIn status
  -- 
  -- CREATED   Created new PayIn
  -- FAILED    PayIn execution has failed
  -- SUCCEEDED PayIn exeuction has succeeded
  --
  -- Status is updated either manually after a successful PayIn e.g. Card Direct or
  -- by a webhook e.g. BankWire transfer
  "status"                          character varying(64)   NOT NULL,
  "status_updated_on"               timestamp               NOT NULL,
  -- Payment method: CARD_DIRECT, BANKWIRE
  "payment_method"                  character varying(20)   NOT NULL,
  -- Payment provider PayIn unique identifier
  "provider_payin"                  character varying(64)   NOT NULL,
  -- User friendly reference code for support
  "reference_number"                character varying       NOT NULL,
  "result_code"                     character varying,
  "result_message"                  character varying,
  CONSTRAINT pk_payin PRIMARY KEY ("id"),
  CONSTRAINT uq_payin_key UNIQUE ("key"),
  CONSTRAINT uq_payin_reference_number UNIQUE ("reference_number"),
  CONSTRAINT fk_payin_account FOREIGN KEY ("account")
      REFERENCES web.account ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_payin_status_enum CHECK
      ("status" IN ('CREATED', 'FAILED', 'SUCCEEDED')),
  CONSTRAINT chk_payin_payment_method_enum CHECK
      ("payment_method" IN ('CARD_DIRECT', 'BANKWIRE'))
);

CREATE TABLE "billing".payin_card_direct
(
  "id"                              integer                  PRIMARY KEY,
  "alias"                           character varying,
  "card"                            character varying,
  "statement_descriptor"            character varying(10),
  CONSTRAINT fk_payin_card_direct_payin FOREIGN KEY ("id")
      REFERENCES "billing".payin ("id")
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE "billing".payin_bankwire
(
  "id"                                     integer                 PRIMARY KEY,
  "wire_reference"                         character varying       NOT NULL,
  "bank_account_owner_name"                character varying       NOT NULL,
  "bank_account_owner_address_line1"       character varying       NOT NULL,
  "bank_account_owner_address_line2"       character varying,
  "bank_account_owner_address_city"        character varying       NOT NULL,
  "bank_account_owner_address_region"      character varying,
  "bank_account_owner_address_postal_code" character varying       NOT NULL,
  "bank_account_owner_address_country"     character varying       NOT NULL,
  "bank_account_iban"                      character varying       NOT NULL,
  "bank_account_bic"                       character varying       NOT NULL,
  CONSTRAINT fk_payin_bankwire_payin FOREIGN KEY ("id")
      REFERENCES "billing".payin ("id")
      ON UPDATE NO ACTION ON DELETE CASCADE
);

--
-- PayIn status history
--

CREATE SEQUENCE "billing".payin_status_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".payin_status_hist
(
  "id"                    integer                 NOT NULL   DEFAULT nextval('billing.payin_status_hist_id_seq'::regclass),
  "payin"                 integer                 NOT NULL,  
  "status"                character varying(64)   NOT NULL,
  "status_updated_on"     timestamp               NOT NULL,
  CONSTRAINT pk_payin_status_hist PRIMARY KEY (id),
  CONSTRAINT fk_payin_status_hist_order FOREIGN KEY ("payin")
      REFERENCES "billing".payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_payin_status_hist_status_enum CHECK
      ("status" IN ('CREATED', 'FAILED', 'SUCCEEDED'))
);

--
-- Order
--

CREATE SEQUENCE "order".order_id_seq INCREMENT 1 MINVALUE 1000000 START 1000000 CACHE 1;

CREATE TABLE "order".order
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('order.order_id_seq'::regclass),
  -- Unique key used as a business key for the purchase workflow
  "key"                             uuid                    NOT NULL, 
  "account"                         integer                 NOT NULL,   
  -- Reference to the cart instance used during the checkout operation
  "cart"                            integer                 NOT NULL,  
  "payin"                           integer,
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  "tax_percent"                     integer                 NOT NULL,
  "currency"                        character varying(3)    NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  -- Order status:
  -- CREATED    Order placed
  -- CHARGED    PayIn has been created
  -- PENDING    Order payment has been received, asset delivery/subscription registration is pending
  -- CANCELLED  Order has been cancelled, not payment received
  -- REFUNDED   Order has been refunded
  -- SUCCEEDED  Order has been completed
  "status"                          character varying(64)   NOT NULL,
  "status_updated_on"               timestamp               NOT NULL,
  "delivery_method"                 character varying(64)   NOT NULL,
  -- User friendly reference code for support
  "reference_number"                character varying,
  CONSTRAINT pk_order PRIMARY KEY (id),
  CONSTRAINT uq_order_key UNIQUE ("key"),
  CONSTRAINT uq_order_reference_number UNIQUE ("reference_number"),
  CONSTRAINT fk_order_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT fk_order_cart FOREIGN KEY ("cart")
      REFERENCES "order".cart (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT fk_order_payin FOREIGN KEY ("payin")
      REFERENCES "billing".payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_order_status_enum CHECK 
      ("status" IN ('CREATED', 'CHARGED' ,'PENDING', 'CANCELLED', 'REFUNDED', 'SUCCEEDED')),
  CONSTRAINT chk_order_delivery_method_enum CHECK 
      ("delivery_method" IN ('DIGITAL_PLATFORM', 'DIGITAL_PROVIDER', 'PHYSICAL_PROVIDER'))
);

--
-- Order status history
--

CREATE SEQUENCE "order".order_status_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "order".order_status_hist
(
  "id"                    integer                 NOT NULL   DEFAULT nextval('order.order_status_hist_id_seq'::regclass),
  "order"                 integer                 NOT NULL,  
  "status"                character varying(64)   NOT NULL,
  "status_updated_on"     timestamp               NOT NULL,
  -- Optional user id. If the property is updated by the system without user interaction,
  -- the value is set to null
  "status_updated_by"     integer,
  CONSTRAINT pk_order_status_hist PRIMARY KEY (id),
  CONSTRAINT fk_order_status_hist_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_order_status_hist_status_updated_by FOREIGN KEY ("status_updated_by")
      REFERENCES "web".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_order_status_hist_status_enum CHECK 
      ("status" IN ('CREATED', 'PENDING', 'CANCELLED', 'REFUNDED', 'SUCCEEDED'))
);

--
-- Order item
--

CREATE SEQUENCE "order".order_item_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "order".order_item
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('order.order_item_id_seq'::regclass),
  "order"                           integer                 NOT NULL,
  -- Invoice line number
  "index"                           integer				   	NOT NULL,
  -- Item type: Catalogue Asset, Service (WMS, WMS, Data API, etc), BUNDLE, Value-Added-Service (VAS)
  "type"                            character varying(64)   NOT NULL,
  -- Item unique persistent identifier
  "item"                            character varying       NOT NULL,
  -- Item description (at the time of the purchase)
  "description"                     character varying       NOT NULL,
  -- Pricing model (at the time of the purchase)
  "pricing_model"                   jsonb                   NOT NULL,
  -- Pricing computed using the pricing model (at the time of purchase)
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  -- Optional discount code
  "discount_code"                   character varying(64),
  CONSTRAINT pk_order_item PRIMARY KEY (id),
  CONSTRAINT fk_order_item_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_order_item_type_enum CHECK 
      ("type" IN ('ASSET', 'SERVICE', 'BUNDLE', 'VAS'))
);

--
-- User purchased assets
--

-- When a new version of an asset is added, this table is searched based on parent PID. If update_eligibility > today,
-- a new row is added with the asset = <new PID>. All other fields are copied from the parent record.
--
-- If a user purchase a new version with additional years of updates, a new row is added. Updated versions update the latest order.

CREATE SEQUENCE "web".account_asset_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_asset
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('web.account_asset_id_seq'::regclass),
  -- Asset owner
  "account"                         integer                 NOT NULL,   
  -- Order of purchase. For updated assets the order is copied
  "order"                           integer					NOT NULL,
  -- Asset PID (asset version derives from the PID)
  "asset"                           character varying       NOT NULL,
  -- Copied from the order
  "purchased_on"                    timestamp               NOT NULL,
  -- Date record added to user profile
  "added_on"                        timestamp               NOT NULL,
  -- Update interval (months)
  "update_interval"                 integer                 NOT NULL,
  -- Date until a customer is eligible for receiving updates.
  -- For new assets (source == "PURCHASE") the value is computed by the "added_on" and "updates_interval"
  -- fields.
  -- For updated assets, the value is copied by the parent asset
  "update_eligibility"              timestamp               NOT NULL,
  -- Asset source: PURCHASE (new asset), UPDATE (version update of existing asset)
  "source"                          character varying(32)   NOT NULL,
  CONSTRAINT pk_account_asset PRIMARY KEY (id),
    CONSTRAINT fk_account_asset_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_account_asset_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_account_asset_source_enum CHECK 
      ("source" IN ('PURCHASE', 'UPDATE'))
);

--
-- User purchased subscriptions
--

CREATE SEQUENCE "web".account_sub_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_subscription
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('web.account_sub_id_seq'::regclass),
  -- Subscription owner
  "account"                         integer                 NOT NULL,
  -- Order of purchase. For updated assets the order is copied
  "order"							              integer					        NOT NULL,
  -- Service PID
  "service" 					              character varying       NOT NULL,
  -- Date subscription added to user account. Next billing date is computed based on this date
  "added_on"						            timestamp               NOT NULL,
  -- Date updated i.e. add new SKU records
  "updated_on"                      timestamp               NOT NULL,
  -- Service source: PURCHASE (new asset), UPDATE (version update of existing asset)
  "source"							            character varying(32)	  NOT NULL,
  CONSTRAINT pk_account_sub PRIMARY KEY (id),
  CONSTRAINT fk_account_sub_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_account_sub_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_account_subscription_source_enum CHECK 
      ("source" IN ('PURCHASE', 'UPDATE'))
);

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
  CONSTRAINT pk_subscription PRIMARY KEY (id),
  CONSTRAINT fk_subscription_subscription FOREIGN KEY ("subscription")
      REFERENCES "web".account_subscription (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

--
-- PayIn items
--

CREATE SEQUENCE "billing".payin_item_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

-- A payment may be linked to either a single asset/service order or to one or
-- more subscription billing items.
CREATE TABLE "billing".payin_item
(
  "id"                             integer                 NOT NULL   DEFAULT nextval('billing.payin_item_id_seq'::regclass),
  "payin"                          integer                 NOT NULL,
  -- Invoice line number
  "index"                          integer                 NOT NULL,
  -- Item type: ORDER, SUBSCRIPTION
  "type"			                     character varying(64)   NOT NULL,
  "order"                          int,
  "subscription_billing"           int,
  -- Payment provider Tranfer unique identifier
  "tranfer"                        character varying(64),
  -- Funds transfered from the seller's wallet to her bank account
  "tranfer_credited_funds"         numeric(20,6),
  -- Fees collected
  "tranfer_platform_fees"          numeric(20,6),
  "tranfer_status"                 character varying(64),
  "tranfer_created_on"             timestamp,
  "tranfer_executed_on"            timestamp,
  CONSTRAINT pk_payin_item PRIMARY KEY (id),
  CONSTRAINT fk_payin_item_payin FOREIGN KEY ("payin")
      REFERENCES "billing".payin (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_payin_item_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_payin_item_subscription_billing FOREIGN KEY ("subscription_billing")
      REFERENCES "billing".subscription_billing (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_payin_item_type_enum CHECK 
      ("type" IN ('ORDER', 'SUBSCRIPTION')),
  CONSTRAINT chk_payin_item_tranfer_status_enum CHECK
      ("tranfer_status" IN ('CREATED', 'FAILED', 'SUCCEEDED'))
);

--
-- PayOut (Seller payments)
--

CREATE SEQUENCE "billing".payout_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".payout
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.payout_id_seq'::regclass),
  "key"                             uuid                    NOT NULL, 
  -- Reference to the platform user
  "account"                         integer                 NOT NULL,
  -- Payment provider PayOut id
  "provider_payout"         character varying(64),
  -- Funds transfered from the seller's wallet to her bank account
  "credited_funds"                  numeric(20,6)           NOT NULL,
  -- Fees collected
  "platform_fees"                   numeric(20,6)           NOT NULL,
  -- Payment currency. Currently only EUR is supported
  "currency"                        character varying(3)    NOT NULL,
  "status"                          character varying(64)   NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "executed_on"                     timestamp,
  "bankwire_ref"                    character varying (12)  NOT NULL,
  CONSTRAINT pk_payout PRIMARY KEY (id),
  CONSTRAINT uq_payout_key UNIQUE ("key"),
  CONSTRAINT uq_payout_bankwire_ref UNIQUE ("bankwire_ref"),
  CONSTRAINT fk_payout_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_payout_status_enum CHECK
      ("status" IN ('CREATED', 'FAILED', 'SUCCEEDED'))
);

--
-- Drop existing objects
--

ALTER TABLE "billing".payin_card_direct DROP CONSTRAINT IF EXISTS chk_recurring_type_enum;
ALTER TABLE "billing".payin_card_direct DROP CONSTRAINT IF EXISTS fk_payin_card_direct_recurring_reg;

DROP TABLE IF EXISTS "billing".payin_recurring_registration_status_hist CASCADE;
DROP SEQUENCE IF EXISTS "billing".payin_recurring_registration_status_hist_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".payin_recurring_registration CASCADE;
DROP SEQUENCE IF EXISTS "billing".payin_recurring_registration_id_seq CASCADE;

--
-- Create table for payin recurring registrations
--

CREATE SEQUENCE "billing".payin_recurring_registration_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".payin_recurring_registration
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.payin_recurring_registration_id_seq'::regclass),
  "key"                             uuid                    NOT NULL,
  "subscription"                    integer                 NOT NULL,
  "provider_card"                   character varying       NOT NULL,
  "provider_registration"           character varying       NOT NULL,
  "first_transaction_debited_funds" numeric(20,6)           NOT NULL,
  "next_transaction_debited_funds"  numeric(20,6)           NOT NULL,
  "currency"                        character varying(3)    NOT NULL   DEFAULT('EUR'),
  "end_date"                        timestamp               NOT NULL,
  "frequency"                       character varying(255)  NOT NULL,
  "fixed_next_amount"               boolean                 NOT NULL   DEFAULT(true),
  "fractioned_payment"              boolean                 NOT NULL   DEFAULT(false),
  "migration"                       boolean                 NOT NULL   DEFAULT(false),
  -- Billing address
  "billing_first_name"              character varying(255),
  "billing_last_name"               character varying(255),
  "billing_address_line_1"          character varying(255),
  "billing_address_line_2"          character varying(255),
  "billing_address_city"            character varying(255),
  "billing_address_region"          character varying(255),
  "billing_address_postal_code"     character varying(50),
  "billing_address_country"         character varying(2),
  -- Shipping address
  "shipping_first_name"             character varying(255),
  "shipping_last_name"              character varying(255),
  "shipping_address_line_1"         character varying(255),
  "shipping_address_line_2"         character varying(255),
  "shipping_address_city"           character varying(255),
  "shipping_address_region"         character varying(255),
  "shipping_address_postal_code"    character varying(50),
  "shipping_address_country"        character varying(2),
  -- Dates
  "created_on"                      timestamp               NOT NULL,
  -- Recurring payment registration status
  --
  -- CREATED                Registration has been created and the first CIT is pending
  -- IN_PROGRESS            Registration has been authenticated by a successful CIT
  -- AUTHENTICATION_NEEDED  User must authenticate the registration with a new CIT, e.g. this may happen if the user updates her card
  -- ENDED                  Registration has been ended. No new payments are accepted
  "status"                          character varying(64)   NOT NULL,
  "status_updated_on"               timestamp               NOT NULL,
  CONSTRAINT pk_payin_recurring_registration PRIMARY KEY ("id"),
  CONSTRAINT uq_payin_recurring_registration_key UNIQUE ("key"),
  CONSTRAINT fk_payin_recurring_registration_subscription FOREIGN KEY ("subscription")
      REFERENCES web.account_subscription ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_payin_recurring_registration_frequency_enum CHECK
      ("frequency" IN ('MONTHLY', 'ANNUAL' )),
  CONSTRAINT chk_payin_recurring_registration_status_enum CHECK
      ("status" IN ('CREATED', 'IN_PROGRESS', 'AUTHENTICATION_NEEDED', 'ENDED' ))
);

comment on column "billing".payin_recurring_registration.subscription is 'Reference to the subscription that created this registration';
comment on column "billing".payin_recurring_registration.provider_card is 'MANGOPAY card identifier';
comment on column "billing".payin_recurring_registration.provider_registration is 'MANGOPAY recurring payment registration identifier';

CREATE SEQUENCE "billing".payin_recurring_registration_status_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".payin_recurring_registration_status_hist
(
  "id"                    integer                 NOT NULL   DEFAULT nextval('billing.payin_recurring_registration_status_hist_id_seq'::regclass),
  "registration"          integer                 NOT NULL,
  "status"                character varying(64)   NOT NULL,
  "status_updated_on"     timestamp               NOT NULL,
  CONSTRAINT pk_payin_recurring_registration_status_hist PRIMARY KEY (id),
  CONSTRAINT fk_payin_recurring_registration_status_hist_payin FOREIGN KEY ("registration")
      REFERENCES "billing".payin_recurring_registration (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_payin_recurring_registration_status_hist_status_enum CHECK
      ("status" IN ('CREATED', 'IN_PROGRESS', 'AUTHENTICATION_NEEDED', 'ENDED' ))
);

--  Add new fields for recurring payments to card direct payin table
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "recurring_registration"  int;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "recurring_type"          character varying(10);

-- Add/Update constraint for field recurring_type
ALTER TABLE "billing".payin_card_direct ADD CONSTRAINT chk_recurring_type_enum CHECK
  ("recurring_type" IN ('NONE', 'CIT', 'MIT'));

-- Set default value for field recurring_type
update "billing".payin_card_direct set recurring_type = 'NONE';

-- Do not allow null values for field recurring_type
ALTER TABLE "billing".payin_card_direct ALTER COLUMN "recurring_type" SET NOT NULL;

-- Add foreign key constraint for recurring payments to card direct payin table
ALTER TABLE "billing".payin_card_direct ADD CONSTRAINT fk_payin_card_direct_recurring_reg FOREIGN KEY ("recurring_registration")
    REFERENCES "billing".payin_recurring_registration ("id") MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE SET NULL;

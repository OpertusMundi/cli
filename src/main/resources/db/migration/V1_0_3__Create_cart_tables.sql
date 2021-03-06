--
-- Drop existing objects
--

DROP SCHEMA IF EXISTS "order" CASCADE;

--
-- Order schema
--

CREATE SCHEMA IF NOT EXISTS "order"; 

--
-- Cart
--

CREATE SEQUENCE "order".cart_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "order".cart
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('order.cart_id_seq'::regclass),
  "key"                             uuid                    NOT NULL,  
  "account"                         integer,
  "total_price"                     numeric(20,6)           NOT NULL,
  "total_price_excluding_tax"       numeric(20,6)           NOT NULL,
  "total_tax"                       numeric(20,6)           NOT NULL,
  "currency"                        text                    NOT NULL,
  "created_on"                      timestamp               NOT NULL   DEFAULT now(),
  "modified_on"                     timestamp               NOT NULL   DEFAULT now(),
  CONSTRAINT pk_cart PRIMARY KEY (id),
  CONSTRAINT uq_cart_key UNIQUE ("key"),
  CONSTRAINT fk_cart_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL
);

--
-- Cart item
--

CREATE SEQUENCE "order".cart_item_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "order".cart_item
(
  "id"              integer                 NOT NULL   DEFAULT nextval('order.cart_item_id_seq'::regclass),
  "key"             uuid                    NOT NULL,  
  "cart"            integer                 NOT NULL,
  "product"         uuid                    NOT NULL,
  "pricing_model"   uuid                    NOT NULL,
  "added_on"        timestamp               NOT NULL   DEFAULT now(),
  "removed_on"      timestamp,
  CONSTRAINT pk_cart_item PRIMARY KEY (id),
  CONSTRAINT fk_cart_item_cart FOREIGN KEY ("cart")
      REFERENCES "order".cart (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

ALTER TABLE "order".order DROP CONSTRAINT IF EXISTS fk_order_cart;

DROP TABLE IF EXISTS "order".cart_item;
DROP TABLE IF EXISTS "order".cart;

--
-- Cart
--

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

CREATE TABLE "order".cart_item
(
  "id"              integer                 NOT NULL   DEFAULT nextval('order.cart_item_id_seq'::regclass),
  "key"             uuid                    NOT NULL,  
  "cart"            integer                 NOT NULL,
  -- Asset unique PID
  "asset"           character varying       NOT NULL,
  -- Quotation for the selected pricing model and user parameters
  "pricing_model"   jsonb                   NOT NULL,
  "added_on"        timestamp               NOT NULL   DEFAULT now(),
  "removed_on"      timestamp,
  CONSTRAINT pk_cart_item PRIMARY KEY (id),
  CONSTRAINT fk_cart_item_cart FOREIGN KEY ("cart")
      REFERENCES "order".cart (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

-- Recreate foreign key constraint
ALTER TABLE "order".order ADD CONSTRAINT fk_order_cart  FOREIGN KEY ("cart")
  REFERENCES "order".cart (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE SET NULL;
    
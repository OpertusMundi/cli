DROP TABLE IF EXISTS "order".cart_item;

CREATE TABLE "order".cart_item
(
  "id"              integer                 NOT NULL   DEFAULT nextval('order.cart_item_id_seq'::regclass),
  "key"             uuid                    NOT NULL,  
  "cart"            integer                 NOT NULL,
  "product"         character varying       NOT NULL,
  "pricing_model"   uuid                    NOT NULL,
  "added_on"        timestamp               NOT NULL   DEFAULT now(),
  "removed_on"      timestamp,
  CONSTRAINT pk_cart_item PRIMARY KEY (id),
  CONSTRAINT fk_cart_item_cart FOREIGN KEY ("cart")
      REFERENCES "order".cart (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

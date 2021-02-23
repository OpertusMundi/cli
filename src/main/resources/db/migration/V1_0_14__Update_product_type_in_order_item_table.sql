DROP TABLE IF EXISTS "order".order_item CASCADE;

CREATE TABLE "order".order_item
(
  "id"              integer                 NOT NULL   DEFAULT nextval('order.order_item_id_seq'::regclass),
  "order"           integer                 NOT NULL,
  -- Invoice line number
  "index"           integer					NOT NULL,
  -- Item type: Bundle, Value-Added-Service (VAS), API, Catalogue Asset
  "type"			character varying(64)   NOT NULL,
  "product"         character varying       NOT NULL,
  "pricing_model"   uuid                    NOT NULL,
  "discount_code"	character varying(64)   NULL,
  CONSTRAINT pk_order_item PRIMARY KEY (id),
  CONSTRAINT fk_order_item_order FOREIGN KEY ("order")
      REFERENCES "order".order (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

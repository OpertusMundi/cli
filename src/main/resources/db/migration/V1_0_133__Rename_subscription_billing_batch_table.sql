DROP TABLE IF EXISTS "billing".subscription_billing_batch CASCADE;
DROP SEQUENCE IF EXISTS "billing".subscription_billing_batch_id_seq CASCADE;

DROP TABLE IF EXISTS "billing".service_billing_batch CASCADE;
DROP SEQUENCE IF EXISTS "billing".service_billing_batch_id_seq CASCADE;

CREATE SEQUENCE "billing".service_billing_batch_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "billing".service_billing_batch
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('billing.service_billing_batch_id_seq'::regclass),
  "key"                             UUID                    NOT NULL,
  "created_by"                      int                     NOT NULL,
  "created_on"                      timestamp               NOT NULL,
  "updated_on"                      timestamp               NOT NULL,
  "status"                          character varying(64)   NOT NULL,
  "from_date"                       date                    NOT NULL,
  "to_date"                         date                    NOT NULL,
  "due_date"                        date                    NOT NULL,
  "total_subscriptions"             integer,
  "total_price"                     numeric(20,6),
  "total_price_excluding_tax"       numeric(20,6),
  "total_tax"                       numeric(20,6),
  "process_definition"              character varying,
  "process_instance"                character varying,
  CONSTRAINT pk_service_billing_batch PRIMARY KEY (id),
  CONSTRAINT fk_service_billing_batch_created_by FOREIGN KEY ("created_by")
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT chk_service_billing_batch_status_enum CHECK
      ("status" IN ('RUNNING', 'SUCCEEDED', 'FAILED'))
);

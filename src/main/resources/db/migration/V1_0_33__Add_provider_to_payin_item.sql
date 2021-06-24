ALTER TABLE "billing".payin_item ADD IF NOT EXISTS "provider" integer NOT NULL;

ALTER TABLE "billing".payin_item DROP CONSTRAINT IF EXISTS fk_payin_item_provider;

ALTER TABLE "billing".payin_item ADD CONSTRAINT fk_payin_item_provider FOREIGN KEY ("provider")
  REFERENCES "web".account (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE;
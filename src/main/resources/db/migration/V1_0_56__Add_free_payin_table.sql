DROP TABLE IF EXISTS "billing".payin_free;

CREATE TABLE "billing".payin_free
(
  "id"                                     integer                 PRIMARY KEY,
  CONSTRAINT fk_payin_free_payin FOREIGN KEY ("id")
      REFERENCES "billing".payin ("id")
      ON UPDATE NO ACTION ON DELETE CASCADE
);

ALTER TABLE "billing".payin DROP CONSTRAINT IF EXISTS chk_payin_payment_method_enum;

ALTER TABLE "billing".payin ADD CONSTRAINT chk_payin_payment_method_enum CHECK
  ("payment_method" IN ('FREE', 'CARD_DIRECT' ,'BANKWIRE'));

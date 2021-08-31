ALTER TABLE "order".order_item ALTER COLUMN segment DROP NOT NULL;
ALTER TABLE "analytics".payin_item_hist ALTER COLUMN segment DROP NOT NULL;
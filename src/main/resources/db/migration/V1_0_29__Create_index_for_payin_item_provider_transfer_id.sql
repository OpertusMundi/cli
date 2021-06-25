CREATE INDEX IF NOT EXISTS idx_payin_item_provider_transfer ON "billing".payin_item USING btree ("transfer");
CREATE INDEX IF NOT EXISTS idx_payin_item_hist_provider_transfer ON "analytics".payin_item_hist USING btree ("transfer_provider_id");
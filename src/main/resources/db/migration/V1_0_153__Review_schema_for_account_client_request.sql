ALTER TABLE  web.account_client_request
    ALTER COLUMN asset_keys SET DATA TYPE text[] USING string_to_array(asset_keys, ',');

ALTER TABLE  web.account_client_request 
    ADD COLUMN accounted timestamp;

CREATE INDEX "account_client_request_Y2022_Q4_asset_keys_idx" 
    ON web."account_client_request_Y2022_Q4" USING gin(asset_keys);
CREATE INDEX "account_client_request_Y2022_Q4_not_accounted_idx" 
    ON web."account_client_request_Y2022_Q4" USING btree(request_id) WHERE "accounted" is NULL;

CREATE INDEX "account_client_request_Y2023_Q1_asset_keys_idx" 
    ON web."account_client_request_Y2023_Q1" USING gin(asset_keys);
CREATE INDEX "account_client_request_Y2023_Q1_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q1" USING btree(request_id) WHERE "accounted" is NULL;

CREATE INDEX "account_client_request_Y2023_Q2_asset_keys_idx" 
    ON web."account_client_request_Y2023_Q2" USING gin(asset_keys);
CREATE INDEX "account_client_request_Y2023_Q2_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q2" USING btree(request_id) WHERE "accounted" is NULL;

CREATE INDEX "account_client_request_Y2023_Q3_asset_keys_idx" 
    ON web."account_client_request_Y2023_Q3" USING gin(asset_keys);
CREATE INDEX "account_client_request_Y2023_Q3_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q3" USING btree(request_id) WHERE "accounted" is NULL;



DROP INDEX web."account_client_request_Y2022_Q4_not_accounted_idx";
CREATE INDEX "account_client_request_Y2022_Q4_not_accounted_idx" 
    ON web."account_client_request_Y2022_Q4" USING btree(request_id) WHERE "accounted" is NULL AND "asset_keys" is not NULL;


DROP INDEX web."account_client_request_Y2023_Q1_not_accounted_idx";
CREATE INDEX "account_client_request_Y2023_Q1_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q1" USING btree(request_id) WHERE "accounted" is NULL AND "asset_keys" is not NULL;


DROP INDEX web."account_client_request_Y2023_Q2_not_accounted_idx";
CREATE INDEX "account_client_request_Y2023_Q2_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q2" USING btree(request_id) WHERE "accounted" is NULL AND "asset_keys" is not NULL;


DROP INDEX web."account_client_request_Y2023_Q3_not_accounted_idx";
CREATE INDEX "account_client_request_Y2023_Q3_not_accounted_idx" 
    ON web."account_client_request_Y2023_Q3" USING btree(request_id) WHERE "accounted" is NULL AND "asset_keys" is not NULL;


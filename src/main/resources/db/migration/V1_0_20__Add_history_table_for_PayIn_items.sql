--
-- Drop existing objects
--

DROP SCHEMA IF EXISTS "analytics" CASCADE;

--
-- Analytics schema
--

CREATE SCHEMA IF NOT EXISTS "analytics"; 

--
-- Successful PayIn history table
--

CREATE TABLE "analytics".payin_item_hist
(
  -- PayIn item primary key
  "id"                              integer                 NOT NULL,
  -- Consumer
  "consumer"                        integer                 NOT NULL,
  -- Provider
  "provider"                        integer                 NOT NULL,
  "provider_key"                    uuid                    NOT NULL,
  -- Asset
  "asset_pid"                       character varying       NOT NULL,
  "asset_type"                      character varying       NOT NULL,
  "segment"                         character varying(40)   NOT NULL,
  -- Payin
  "payin_op_id"                     integer                 NOT NULL,
  "payin_provider_id"               character varying(64)   NOT NULL,
  "payin_executed_on"               timestamp               NOT NULL,
  "payin_year"                      integer                 NOT NULL,
  "payin_month"                     integer                 NOT NULL,
  "payin_week"                      integer                 NOT NULL,
  "payin_day"                       integer                 NOT NULL,
  "payin_country"                   character varying(3)    NOT NULL,
  "payin_total_price"               numeric(20,6)           NOT NULL,
  "payin_total_price_excluding_tax" numeric(20,6)           NOT NULL,
  "payin_total_tax"                 numeric(20,6)           NOT NULL,
  -- Transfer
  "transfer_provider_id"             character varying(64),
  "transfer_credited_funds"          numeric(20,6),
  "transfer_platform_fees"           numeric(20,6),
  "transfer_executed_on"             timestamp,
  "transfer_year"                    integer,
  "transfer_month"                   integer,
  "transfer_week"                    integer,
  "transfer_day"                     integer,
  CONSTRAINT pk_payin_item_hist PRIMARY KEY (id)
);

CREATE INDEX idx_payin_item_hist_publisher_key ON "analytics".payin_item_hist USING btree ("provider_key");
CREATE INDEX idx_payin_item_hist_segment ON "analytics".payin_item_hist USING btree ("segment");
CREATE INDEX idx_payin_item_hist_payin_country ON "analytics".payin_item_hist USING btree ("payin_country");
CREATE INDEX idx_payin_item_hist_payin_executed_on ON "analytics".payin_item_hist USING btree ("payin_executed_on");

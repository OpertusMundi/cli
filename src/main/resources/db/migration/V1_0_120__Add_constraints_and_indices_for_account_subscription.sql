--
-- more constraints
--

ALTER TABLE web.account_subscription ADD CONSTRAINT "fk_account_subscription_provider" 
    FOREIGN KEY ("provider") REFERENCES web.account("id") 
    ON DELETE CASCADE;

--
-- indices for speeding up common queries
--

CREATE INDEX "idx_account_subscription_provider_and_consumer" 
    ON web.account_subscription USING btree ("provider", "consumer");

CREATE INDEX "idx_account_subscription_consumer" 
    ON web.account_subscription USING btree ("consumer");

CREATE INDEX "idx_account_subscription_asset" 
    ON web.account_subscription USING btree ("asset" varchar_pattern_ops);

CREATE INDEX "idx_account_subscription_key" 
    ON web.account_subscription USING btree ("key");

CREATE INDEX "idx_account_subscription_added" 
    ON web.account_subscription USING btree ("added_on");



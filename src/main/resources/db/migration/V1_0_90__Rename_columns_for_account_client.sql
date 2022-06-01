ALTER TABLE web.account_client RENAME COLUMN "key" TO "client_id";
COMMENT ON COLUMN web.account_client."client_id" IS 'The client-id as expected from oauth2 protocol';

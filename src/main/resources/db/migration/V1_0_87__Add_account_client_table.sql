DROP TABLE    IF EXISTS "web".account_client;
DROP SEQUENCE IF EXISTS "web".account_client_id_seq;

CREATE SEQUENCE "web".account_client_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_client
(
    "id"            integer                       NOT NULL    DEFAULT nextval('web.account_client_id_seq'::regclass),
    "account"       integer                       NOT NULL,
    "alias"         character varying(64)         NOT NULL,
    "key"           uuid                          NOT NULL,
    "created_on"    timestamp without time zone   NOT NULL,
    "revoked_on"    timestamp without time zone,
    CONSTRAINT pk_account_client PRIMARY KEY (id),
    CONSTRAINT fk_account_client_account FOREIGN KEY (account)
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT uq_account_client_key UNIQUE ("account", "key")
);

CREATE INDEX idx_account_client_key           ON "web".account_client USING btree ("key");
CREATE INDEX idx_account_client_account_key   ON "web".account_client USING btree ("account", "key");
CREATE INDEX idx_account_client_account_alias ON "web".account_client USING btree ("account", "alias");

comment on column "web".account_client.alias       is  'User-defined client name';
comment on column "web".account_client.key         is  'Keycloak client id';
comment on column "web".account_client.created_on  is  'Client creation date (API service)';
comment on column "web".account_client.revoked_on  is  'Client revocation date (API service)';
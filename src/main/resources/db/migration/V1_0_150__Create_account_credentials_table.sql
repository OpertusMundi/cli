DROP TABLE    IF EXISTS "web".account_credentials;
DROP SEQUENCE IF EXISTS "web".account_credentials_id_seq;

CREATE SEQUENCE "web".account_credentials_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_credentials
(
    "id"            integer                       NOT NULL    DEFAULT nextval('web.account_credentials_id_seq'::regclass),
    "account"       integer                       NOT NULL,
    "application"   character varying(64)         NOT NULL,
    "username"      character varying(64)         NOT NULL,
    "password"      character varying(64)         NOT NULL,
    "created_on"    timestamp without time zone   NOT NULL,
    CONSTRAINT pk_account_credentials PRIMARY KEY (id),
    CONSTRAINT fk_account_credentials_account FOREIGN KEY (account)
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT uq_account_credentials_key UNIQUE ("account", "application")
);

CREATE INDEX idx_account_credentials_account_application   ON "web".account_credentials USING btree ("account", "application");

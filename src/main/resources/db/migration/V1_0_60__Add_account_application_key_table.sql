DROP TABLE IF EXISTS "web".account_api_key;
DROP SEQUENCE IF EXISTS "web".account_api_key_id_seq;

CREATE SEQUENCE "web".account_api_key_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_api_key
(
    id              integer                       NOT NULL    DEFAULT nextval('web.account_api_key_id_seq'::regclass),
    account         integer                       NOT NULL,
    created_on      timestamp without time zone   NOT NULL,
    revoked_on      timestamp without time zone,
    "key"           character varying,
    CONSTRAINT pk_account_api_key PRIMARY KEY (id),
    CONSTRAINT fk_account_api_key_account FOREIGN KEY (account)
        REFERENCES web.account (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT uq_account_api_key_key UNIQUE ("key")
);

DROP TABLE IF EXISTS "web".account_recent_search;
DROP SEQUENCE IF EXISTS "web".account_recent_search_id_seq;

CREATE SEQUENCE "web".account_recent_search_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_recent_search
(
  "id"            integer                NOT NULL   DEFAULT nextval('web.account_recent_search_id_seq'::regclass),
  "account"       integer                NOT NULL,
  "value"         character varying      NOT NULL,
  "added_on"      timestamp              NOT NULL,
  CONSTRAINT pk_account_recent_search PRIMARY KEY (id),
  CONSTRAINT fk_account_recent_search_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE INDEX idx_account_recent_search_account_added_on ON "web".account_recent_search USING btree ("account", "added_on");

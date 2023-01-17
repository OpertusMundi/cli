DROP TABLE IF EXISTS "web".account_ticket CASCADE;
DROP SEQUENCE IF EXISTS "web".account_ticket_id_seq CASCADE;

CREATE SEQUENCE "web".account_ticket_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".account_ticket
(
    "id"                  integer                     NOT NULL  DEFAULT nextval('web.account_ticket_id_seq'::regclass),
    "key"                 uuid                        NOT NULL,
    "type"                character varying(20)       NOT NULL,
    "resource_key"        uuid,
    "subject"             character varying           NOT NULL,
    "message"             character varying           NOT NULL,
    "message_thread_key"  uuid,
    "created_at"          timestamp                   NOT NULL,
    "updated_at"          timestamp                   NOT NULL,
    "assigned_at"         timestamp,
    "status"              character varying(20)       NOT NULL  DEFAULT 'OPEN',
    "owner"               integer                     NOT NULL,
    "assignee"            integer,
    CONSTRAINT pk_account_ticket            PRIMARY KEY (id),
    CONSTRAINT uq_account_ticket_key        UNIQUE (key),
    CONSTRAINT fk_account_ticket_owner      FOREIGN KEY ("owner")
      REFERENCES "web".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT fk_account_ticket_assignee   FOREIGN KEY ("assignee")
      REFERENCES "admin".account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT chk_account_ticket_type_enum CHECK (
      "type" IN ('ORDER', 'PAYIN', 'SUBSCRIPTION', 'PRIVATE_OGC_SERVICE')
    ),
    CONSTRAINT chk_account_ticket_status_enum CHECK (
      "status" IN ('OPEN', 'REOPEN', 'CLOSED')
    )
);

CREATE INDEX idx_account_ticket_key   ON "web".account_ticket USING btree ("key");

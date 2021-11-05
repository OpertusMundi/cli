-- Drop
DROP TABLE IF EXISTS web."record_lock";

DROP SEQUENCE IF EXISTS web."record_lock_id_seq";

-- Create
CREATE SEQUENCE web."record_lock_id_seq" INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE web."record_lock"
(
  "id"                              bigint                  NOT NULL   DEFAULT nextval('web.record_lock_id_seq'::regclass),
  "record_type"                     character varying(64)   NOT NULL,
  "record_id"                       integer                 NOT NULL,
  "granted_on"                      timestamp               NOT NULL,
  "account"                         integer                 NOT NULL,
  CONSTRAINT pk_record_lock PRIMARY KEY (id),
  CONSTRAINT uq_record_lock_type_id UNIQUE ("record_type", "record_id"),
  CONSTRAINT fk_record_lock_account FOREIGN KEY ("account")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT chk_favorite_type_enum CHECK
      ("record_type" IN ('DRAFT'))
);

CREATE INDEX idx_record_lock_type_id ON web."record_lock" USING btree ("record_type", "record_id");

DROP SCHEMA IF EXISTS "contract" CASCADE;

CREATE SCHEMA IF NOT EXISTS "contract";

-- Platform contract templates

CREATE SEQUENCE "contract".master_contract_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".master_section_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".master_contract_history
(
  "id"                          integer     NOT NULL DEFAULT nextval('contract.master_contract_hist_id_seq'::regclass),
  "key"                         uuid        NOT NULL,
  "contract_root"               integer,
  "contract_parent"             integer,
  "owner"                       integer     NOT NULL,
  "title"                       text        NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp   NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  "status"                      text,
  CONSTRAINT pk_master_contract_history PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_history_owner FOREIGN KEY ("owner")
    REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT fk_master_contract_history_contract_root FOREIGN KEY ("contract_root")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT fk_master_contract_history_contract_parent FOREIGN KEY ("contract_parent")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_history_key UNIQUE ("key"),
  CONSTRAINT chk_master_contract_history_status CHECK
      ("status" IN ('HISTORY', 'ACTIVE', 'INACTIVE'))
);

CREATE TABLE "contract".master_section_history
(
  "id"                          integer     NOT NULL DEFAULT nextval('contract.master_section_hist_id_seq'::regclass),
  "contract"                    integer     NOT NULL,
  "title"                       text        NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options"                     text[],
  "styled_options"              text[],
  "sub_options"                  JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,
  CONSTRAINT pk_master_section_history  PRIMARY KEY (id),
  CONSTRAINT fk_master_section_contract FOREIGN KEY ("contract")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE
    ON DELETE CASCADE
);

CREATE SEQUENCE "contract".master_contract_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".master_section_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".master_contract
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.master_contract_id_seq'::regclass),
  "key"                         uuid          NOT NULL,
  "parent"                      integer       NOT NULL,
  "owner"                       integer       NOT NULL,
  "title"                       text          NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp     NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  CONSTRAINT pk_master_contract PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_owner FOREIGN KEY ("owner")
    REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT fk_master_contract_parent FOREIGN KEY ("parent")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_key UNIQUE ("key")
);

CREATE TABLE "contract".master_section
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.master_section_id_seq'::regclass),
  "contract"                    integer       NOT NULL,
  "title"                       text          NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options"                     text[],
  "styled_options"              text[],
  "sub_options"                  JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,
  CONSTRAINT pk_master_section PRIMARY KEY (id),
  CONSTRAINT fk_master_section_contract FOREIGN KEY ("contract")
    REFERENCES "contract".master_contract("id") MATCH SIMPLE
    ON DELETE CASCADE
);

CREATE SEQUENCE "contract".master_contract_draft_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".master_section_draft_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".master_contract_draft
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.master_contract_draft_id_seq'::regclass),
  "key"                         uuid          NOT NULL,
  "parent"                      integer,
  "owner"                       integer       NOT NULL,
  "title"                       text          NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp      NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  CONSTRAINT pk_master_contract_draft PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_draft_owner FOREIGN KEY ("owner")
      REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT fk_master_contract_draft_parent FOREIGN KEY ("parent")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_draft_key UNIQUE ("key")
);

CREATE TABLE "contract".master_section_draft
(
  "id"                          integer         NOT NULL DEFAULT nextval('contract.master_section_draft_id_seq'::regclass),
  "contract"                    integer         NOT NULL,
  "title"                       text            NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options"                     text[],
  "styled_options"              text[],
  "sub_options"                  JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_master_section_draft PRIMARY KEY (id),

  CONSTRAINT fk_master_section_draft_contract FOREIGN KEY ("contract")
    REFERENCES "contract".master_contract_draft("id") MATCH SIMPLE
    ON DELETE CASCADE
);

-- Provider contract templates

CREATE SEQUENCE "contract".provider_contract_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".provider_section_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".provider_contract_history
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_contract_hist_id_seq'::regclass),
  "key"                         uuid          NOT NULL,
  "template"                    integer       NOT NULL,
  "contract_root"               integer,
  "contract_parent"             integer,
  "owner"                       integer       NOT NULL,
  "title"                       text          NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp     NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  "status"                      text,
  CONSTRAINT pk_provider_contract_history PRIMARY KEY (id),
  CONSTRAINT fk_provider_contract_history_owner FOREIGN KEY ("owner")
    REFERENCES "web".account("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_history_parent_template FOREIGN KEY ("template")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_history_contract_root FOREIGN KEY ("contract_root")
    REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_history_contract_parent FOREIGN KEY ("contract_parent")
    REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_provider_contract_history_key UNIQUE ("key"),
  CONSTRAINT chk_provider_contract_history_status CHECK
      ("status" IN ('HISTORY', 'ACTIVE', 'INACTIVE'))
);

CREATE TABLE "contract".provider_section_history
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_section_hist_id_seq'::regclass),
  "contract"                    integer       NOT NULL,
  "master_section_id"           integer       NOT NULL,
  "optional"                    boolean,
  "option"                      integer,
  "sub_option"                   integer,
  CONSTRAINT pk_provider_section_history PRIMARY KEY (id),
  CONSTRAINT fk_provider_section_history_contract FOREIGN KEY ("contract")
    REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE
    ON DELETE CASCADE
);

CREATE SEQUENCE "contract".provider_contract_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".provider_section_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".provider_contract
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_contract_id_seq'::regclass),
  "key"                         uuid          NOT NULL,
  "parent"                      integer       NOT NULL,
  "owner"                       integer       NOT NULL,
  "title"                       text          NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp     NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  CONSTRAINT pk_provider_contract PRIMARY KEY (id),
  CONSTRAINT fk_provider_contract_owner FOREIGN KEY ("owner")
    REFERENCES "web".account("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_parent_ FOREIGN KEY ("parent")
    REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_provider_contract_key UNIQUE ("key")
);

CREATE TABLE "contract".provider_section
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_section_id_seq'::regclass),
  "contract"                    integer       NOT NULL,
  "master_section_id"           integer       NOT NULL,
  "optional"                    boolean,
  "option"                      integer,
  "sub_option"                   integer,
  CONSTRAINT pk_provider_section PRIMARY KEY (id),
  CONSTRAINT fk_provider_section_contract FOREIGN KEY ("contract")
    REFERENCES "contract".provider_contract("id") MATCH SIMPLE
    ON DELETE CASCADE
);

CREATE SEQUENCE "contract".provider_contract_draft_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;
CREATE SEQUENCE "contract".provider_section_draft_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".provider_contract_draft
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_contract_draft_id_seq'::regclass),
  "key"                         uuid          NOT NULL,
  "template"                    integer       NOT NULL,
  "parent"                      integer,
  "owner"                       integer       NOT NULL,
  "title"                       text          NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "created_at"                  timestamp     NOT NULL DEFAULT now(),
  "modified_at"                 timestamp,
  CONSTRAINT pk_provider_contract_draft PRIMARY KEY (id),
  CONSTRAINT fk_provider_contract_draft_owner FOREIGN KEY ("owner")
    REFERENCES "web".account("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_draft_template FOREIGN KEY ("template")
    REFERENCES "contract".master_contract_history("id") MATCH SIMPLE,
  CONSTRAINT fk_provider_contract_draft_parent FOREIGN KEY ("parent")
    REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE,
  CONSTRAINT uq_provider_contract_draft_key UNIQUE ("key")
);

CREATE TABLE "contract".provider_section_draft
(
  "id"                          integer       NOT NULL DEFAULT nextval('contract.provider_section_draft_id_seq'::regclass),
  "contract"                    integer       NOT NULL,
  "master_section_id"           integer       NOT NULL,
  "optional"                    boolean,
  "option"                      integer,
  "sub_option"                  integer,
  CONSTRAINT pk_provider_section_draft PRIMARY KEY (id),
  CONSTRAINT fk_provider_section_draft_contract FOREIGN KEY ("contract")
    REFERENCES "contract".provider_contract_draft("id") MATCH SIMPLE
    ON DELETE CASCADE
);

CREATE OR REPLACE VIEW contract.v_master_contract AS
  SELECT all_contracts.* FROM (
  SELECT id, key, contract_root, contract_parent, owner, title, subtitle, version, created_at, modified_at, status
  FROM contract.master_contract_history
  union
  SELECT id, key, null as contract_root, parent, owner, title, subtitle, version, created_at, modified_at, 'DRAFT'
  FROM contract.master_contract_draft
) AS all_contracts;

CREATE OR REPLACE VIEW contract.v_provider_contract AS
  SELECT all_contracts.* FROM (
  SELECT id, key, template, contract_root, contract_parent, owner, title, subtitle, version, created_at, modified_at, status
  FROM contract.provider_contract_history
  union
  SELECT id, key, template, null as contract_root, parent, owner, title, subtitle, version, created_at, modified_at, 'DRAFT'
  FROM contract.provider_contract_draft
) AS all_contracts;

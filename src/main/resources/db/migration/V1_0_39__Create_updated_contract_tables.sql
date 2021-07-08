CREATE SCHEMA IF NOT EXISTS "contract"; 

DROP TABLE IF EXISTS "contract".master_contract cascade;
DROP TABLE IF EXISTS "contract".master_section cascade;
DROP SEQUENCE IF EXISTS "contract".master_contract_id_seq cascade; 
DROP SEQUENCE IF EXISTS "contract".master_section_id_seq cascade;

﻿DROP TABLE IF EXISTS "contract".master_contract_draft cascade;
DROP TABLE IF EXISTS "contract".master_section_draft cascade;
DROP SEQUENCE IF EXISTS "contract".master_contract_draft_id_seq cascade; 
DROP SEQUENCE IF EXISTS "contract".master_section_draft_id_seq cascade;

DROP TABLE IF EXISTS "contract".master_contract_history cascade;
DROP TABLE IF EXISTS "contract".master_section_history cascade;
DROP SEQUENCE IF EXISTS "contract".master_contract_history_id_seq cascade;
DROP SEQUENCE IF EXISTS "contract".master_section_history_id_seq cascade;

CREATE SEQUENCE "contract".master_contract_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".master_contract
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "parent_id"		            integer,
  "account"                     integer NOT NULL,
  "title"                       text	NOT NULL,
  "subtitle"                    text,
  "state"                       text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_master_contract PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_account FOREIGN KEY ("account")
      REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_key UNIQUE ("key")
);

CREATE SEQUENCE "contract".master_section_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".master_section
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "title"                       text NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options" 		            text[],
  "styled_options"              text[],
  "suboptions" 					JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_master_section PRIMARY KEY (id),

  CONSTRAINT fk_master_section_contract FOREIGN KEY ("contract")
      REFERENCES "contract".master_contract("id") MATCH SIMPLE
);

CREATE TABLE "contract".master_contract_draft
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "parent_id"		            integer,
  "account"                     integer NOT NULL,
  "title"                       text	NOT NULL,
  "subtitle"                    text,
  "state"                       text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_master_contract_draft PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_draft_account FOREIGN KEY ("account")
      REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_draft_key UNIQUE ("key")
);

CREATE TABLE "contract".master_section_draft
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "title"                       text NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options" 		            text[],
  "styled_options"              text[],
  "suboptions" 					JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_master_section_draft PRIMARY KEY (id),

  CONSTRAINT fk_master_section_draft_contract FOREIGN KEY ("contract")
      REFERENCES "contract".master_contract_draft("id") MATCH SIMPLE
);


CREATE TABLE "contract".master_contract_history
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "parent_id"		            integer,
  "account"                     integer NOT NULL,
  "title"                       text NOT NULL,
  "subtitle"                    text,
  "state"                       text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_master_contract_history PRIMARY KEY (id),
  CONSTRAINT fk_master_contract_history_account FOREIGN KEY ("account")
      REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT uq_master_contract_history_key UNIQUE ("key")
);

CREATE TABLE "contract".master_section_history
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.master_section_id_seq'::regclass),
  "contract"                    integer NOT NULL,
  "title"                       text NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options"                     text[],
  "styled_options"              text[],
  "suboptions" 					JSON,
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_master_section_history  PRIMARY KEY (id),

  CONSTRAINT fk_master_section_contract FOREIGN KEY ("contract")
      REFERENCES "contract".master_contract_history("id") MATCH SIMPLE
);



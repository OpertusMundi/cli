DROP TABLE IF EXISTS "contract".provider_contract cascade;
DROP TABLE IF EXISTS "contract".provider_section cascade;
DROP SEQUENCE IF EXISTS "contract".provider_contract_id_seq cascade; 
DROP SEQUENCE IF EXISTS "contract".provider_section_id_seq cascade;

﻿DROP TABLE IF EXISTS "contract".provider_contract_draft cascade;
DROP TABLE IF EXISTS "contract".provider_section_draft cascade;
DROP SEQUENCE IF EXISTS "contract".provider_contract_draft_id_seq cascade; 
DROP SEQUENCE IF EXISTS "contract".provider_section_draft_id_seq cascade;

DROP TABLE IF EXISTS "contract".provider_contract_history cascade;
DROP TABLE IF EXISTS "contract".provider_section_history cascade;
DROP SEQUENCE IF EXISTS "contract".provider_contract_history_id_seq cascade;
DROP SEQUENCE IF EXISTS "contract".provider_section_history_id_seq cascade;


CREATE SEQUENCE "contract".provider_contract_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".provider_contract
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.provider_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "master_contract_id"			integer NOT NULL,
  "master_contract_version"		text	NOT NULL,
  "provider_key"                uuid	NOT NULL,
  "parent_id"		            integer,
  "asset_id"		            text,
  "title"                       text	NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_provider_contract PRIMARY KEY (id),
  CONSTRAINT uq_provider_contract_key UNIQUE ("key")
);

CREATE SEQUENCE "contract".provider_section_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "contract".provider_section
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.provider_section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "master_section_id"			integer NOT NULL,
  "optional"                    boolean,
  "option" 		            	integer,
  "suboption" 					integer,

  CONSTRAINT pk_provider_section PRIMARY KEY (id),

  CONSTRAINT fk_provider_section_contract FOREIGN KEY ("contract")
      REFERENCES "contract".provider_contract("id") MATCH SIMPLE
);


CREATE TABLE "contract".provider_contract_draft
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.provider_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "master_contract_id"			integer NOT NULL,
  "master_contract_version"		text	NOT NULL,
  "provider_key"                uuid	NOT NULL,
  "parent_id"		            integer,
  "asset_id"		            text,
  "title"                       text	NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_provider_contract_draft PRIMARY KEY (id),
  CONSTRAINT uq_provider_contract_draft_key UNIQUE ("key")
);


CREATE TABLE "contract".provider_section_draft
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.provider_section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "master_section_id"			integer NOT NULL,
  "optional"                    boolean,
  "option" 		            	integer,
  "suboption" 					integer,

  CONSTRAINT pk_provider_section_draft PRIMARY KEY (id),

  CONSTRAINT fk_provider_section_draft_contract FOREIGN KEY ("contract")
      REFERENCES "contract".provider_contract_draft("id") MATCH SIMPLE
);

CREATE TABLE "contract".provider_contract_history
(
  "id"                            integer NOT NULL DEFAULT nextval('contract.provider_contract_id_seq'::regclass),
  "key"                         uuid	NOT NULL,
  "master_contract_id"			integer NOT NULL,
  "master_contract_version"		text	NOT NULL,
  "provider_key"                uuid	NOT NULL,
  "parent_id"		            integer,
  "asset_id"		            text,
  "account"                     integer NOT NULL,
  "title"                       text NOT NULL,
  "subtitle"                    text,
  "version"                     text,
  "active"                    	boolean,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_provider_contract_history PRIMARY KEY (id),
  CONSTRAINT uq_provider_contract_history_key UNIQUE ("key")
);

CREATE TABLE "contract".provider_section_history
(
  "id"                          integer NOT NULL DEFAULT nextval('contract.provider_section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "master_section_id"			integer NOT NULL,
  "optional"                    boolean,
  "option" 		            	integer,
  "suboption" 					integer,

  CONSTRAINT pk_provider_section_history PRIMARY KEY (id),

  CONSTRAINT fk_provider_section_history_contract FOREIGN KEY ("contract")
      REFERENCES "contract".provider_contract_history("id") MATCH SIMPLE
);



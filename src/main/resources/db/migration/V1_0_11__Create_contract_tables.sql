DROP TABLE IF EXISTS "web".contract cascade;
DROP TABLE IF EXISTS "web".section cascade;
DROP SEQUENCE IF EXISTS "web".contract_id_seq cascade; 
DROP SEQUENCE IF EXISTS "web".section_id_seq cascade;

DROP TABLE IF EXISTS "web".contract_history cascade;
DROP TABLE IF EXISTS "web".section_history cascade;
DROP SEQUENCE IF EXISTS "web".contract_history_id_seq cascade;
DROP SEQUENCE IF EXISTS "web".section_history_id_seq cascade;

DROP TABLE IF EXISTS "web".image cascade;
DROP SEQUENCE IF EXISTS "web".image_id_seq cascade;

CREATE SEQUENCE "web".contract_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".contract
(
  id                            integer NOT NULL DEFAULT nextval('web.contract_id_seq'::regclass),
  "account"                     integer NOT NULL,
  "title"                       text NOT NULL,
  "subtitle"                    text,
  "state"                       text,
  "version"                     text,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_contract PRIMARY KEY (id),
  CONSTRAINT fk_contract_account FOREIGN KEY ("account")
      REFERENCES "admin".account("id") MATCH SIMPLE
);

CREATE SEQUENCE "web".section_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".section
(
   id                           integer NOT NULL DEFAULT nextval('web.section_id_seq'::regclass),
  "contract" 		            integer NOT NULL,
  "title"                       text NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options" 		            text[],
  "styled_options"              text[],
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_section PRIMARY KEY (id),

  CONSTRAINT fk_section_contract FOREIGN KEY ("contract")
      REFERENCES "web".contract("id") MATCH SIMPLE
);

CREATE SEQUENCE "web".contract_history_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".contract_history
(
  id                            integer NOT NULL DEFAULT nextval('web.contract_history_id_seq'::regclass),
  "parent_id"		            integer NOT NULL,
  "account"                     integer NOT NULL,
  "title"                       text NOT NULL,
  "subtitle"                    text,
  "state"                       text,
  "version"                     text,
  "created_at"                  timestamp NOT NULL DEFAULT now(),
  "modified_at"                 timestamp with time zone,

  CONSTRAINT pk_contract_history PRIMARY KEY (id),
  CONSTRAINT fk_contract_history_account FOREIGN KEY ("account")
      REFERENCES "admin".account("id") MATCH SIMPLE,
  CONSTRAINT fk_contract_history_parent_id FOREIGN KEY ("parent_id")
      REFERENCES "web".contract("id") MATCH SIMPLE
);

CREATE SEQUENCE "web".section_history_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".section_history
(
   id                           integer NOT NULL DEFAULT nextval('web.section_id_seq'::regclass),
  "contract"                    integer NOT NULL,
  "title"                       text NOT NULL,
  "indent"                      integer,
  "index"                       text,
  "variable"                    boolean,
  "optional"                    boolean,
  "dynamic"                     boolean,
  "options"                     text[],
  "styled_options"              text[],
  "summary"                     text[],
  "icons"                       text[],
  "description_of_change"       text,

  CONSTRAINT pk_section_history  PRIMARY KEY (id),

  CONSTRAINT fk_section_contract FOREIGN KEY ("contract")
      REFERENCES "web".contract_history("id") MATCH SIMPLE
);



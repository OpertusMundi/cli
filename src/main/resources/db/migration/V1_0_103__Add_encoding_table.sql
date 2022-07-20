DROP TABLE IF EXISTS "spatial".encoding;

CREATE TABLE "spatial".encoding (
  "code"        character varying(100)  NOT NULL,
  "code_lower"  character varying(100),
  "active"      boolean                 NOT NULL DEFAULT (true),
  CONSTRAINT pk_encoding PRIMARY KEY (code)
);

CREATE INDEX idx_encoding_code_lower ON "spatial".encoding USING btree ("code_lower");

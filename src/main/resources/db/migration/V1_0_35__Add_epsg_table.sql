DROP TABLE IF EXISTS "spatial".epsg;

CREATE TABLE "spatial".epsg (
  "code"      int                NOT NULL,
  "name"      character varying  NOT NULL,
  "active"    boolean            NOT NULL DEFAULT (true),
  CONSTRAINT pk_epsg PRIMARY KEY (code)
);

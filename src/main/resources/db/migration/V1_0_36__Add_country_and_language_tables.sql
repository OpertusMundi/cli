DROP TABLE IF EXISTS "spatial".country_all;

CREATE TABLE "spatial".country_all (
  "code"      character varying(3)          NOT NULL,
  "name"      character varying             NOT NULL,
  CONSTRAINT pk_country_all PRIMARY KEY (code)
);

DROP TABLE IF EXISTS "spatial".country_eu;

CREATE TABLE "spatial".country_eu (
  "code"      character varying(3)          NOT NULL,
  "name"      character varying             NOT NULL,
  "geom"      geometry(MULTIPOLYGON, 4326)  NOT NULL,
  CONSTRAINT pk_country_eu PRIMARY KEY (code)
);

DROP TABLE IF EXISTS "spatial".language_eu;

CREATE TABLE "spatial".language_eu (
  "code"      character varying(3) NOT NULL,
  "name"      character varying    NOT NULL,
  "active"    boolean              NOT NULL DEFAULT (true),
  CONSTRAINT pk_language_eu PRIMARY KEY (code)
);

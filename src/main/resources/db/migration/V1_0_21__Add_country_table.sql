DROP TABLE IF EXISTS "spatial".country;

CREATE TABLE "spatial".country (
  id              serial,
  country_name    character varying,
  capital_name    character varying,
  latitude        double precision,
  longitude       double precision,
  iso_code        character varying(2),
  CONSTRAINT pk_country PRIMARY KEY (id)
);
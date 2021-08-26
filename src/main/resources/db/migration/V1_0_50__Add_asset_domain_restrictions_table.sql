DROP TABLE IF EXISTS "provider".asset_domain_restriction;
DROP SEQUENCE IF EXISTS "provider".asset_domain_restriction_id_seq;

CREATE SEQUENCE "provider".asset_domain_restriction_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "provider".asset_domain_restriction
(
  "id"                              integer                 NOT NULL   DEFAULT nextval('provider.asset_domain_restriction_id_seq'::regclass),
  "name"                            character varying(60)   NOT NULL,
  "active"                          boolean                 NOT NULL   DEFAULT true,
  CONSTRAINT pk_asset_domain_restriction PRIMARY KEY (id)
);


insert into "provider".asset_domain_restriction (name) values
  ('Advertising & Marketing'),
  ('Navigation & Mobility'),
  ('Mobile applications'),
  ('Intranet applications'),
  ('Web applications')
  ;
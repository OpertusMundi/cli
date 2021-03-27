DROP TABLE IF EXISTS "web".customer_kyc_level_hist CASCADE;
DROP SEQUENCE IF EXISTS "web".customer_kyc_level_hist_id_seq CASCADE;

DROP TABLE IF EXISTS "web".customer_kyc_document_page CASCADE;
DROP SEQUENCE IF EXISTS "web".customer_kyc_document_page_id_seq CASCADE;

--
-- KYC Level History
--

CREATE SEQUENCE "web".customer_kyc_level_hist_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".customer_kyc_level_hist
(
  "id"                        integer                 NOT NULL   DEFAULT nextval('web.customer_kyc_level_hist_id_seq'::regclass),
  "customer"                  integer                 NOT NULL,
  "level"                     character varying(20)   NOT NULL,
  "updated_on"               timestamp               NOT NULL,
  CONSTRAINT pk_customer_kyc_level_hist PRIMARY KEY (id),
  CONSTRAINT fk_customer_kyc_level_hist_customer FOREIGN KEY ("customer")
      REFERENCES "web".customer (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

--
-- KYC Document Pages
--

CREATE SEQUENCE "web".customer_kyc_document_page_id_seq INCREMENT 1 MINVALUE 1 START 1 CACHE 1;

CREATE TABLE "web".customer_kyc_document_page
(
  "id"                        integer                 NOT NULL   DEFAULT nextval('web.customer_kyc_document_page_id_seq'::regclass),
  "customer"                  integer                 NOT NULL,
  "document"                  character varying(12)   NOT NULL,
  "uploaded_on"               timestamp               NOT NULL,
  "file_name"                 character varying       NOT NULL,
  "file_type"                 character varying(50)   NOT NULL,
  "file_size"                 bigint                  NOT NULL,
  "comment"                   character varying,
  "tag"                       character varying,
  CONSTRAINT pk_customer_kyc_document_page PRIMARY KEY (id),
  CONSTRAINT fk_customer_kyc_document_page_customer FOREIGN KEY ("customer")
      REFERENCES "web".customer (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);


ALTER TABLE "contract".master_contract         ADD IF NOT EXISTS "provider" integer NULL;
ALTER TABLE "contract".master_contract_draft   ADD IF NOT EXISTS "provider" integer NULL;
ALTER TABLE "contract".master_contract_history ADD IF NOT EXISTS "provider" integer NULL;

ALTER TABLE "contract".master_contract         DROP CONSTRAINT IF EXISTS fk_master_contract_provider;
ALTER TABLE "contract".master_contract_draft   DROP CONSTRAINT IF EXISTS fk_master_contract_draft_provider;
ALTER TABLE "contract".master_contract_history DROP CONSTRAINT IF EXISTS fk_master_contract_history_provider;

ALTER TABLE "contract".master_contract
  ADD CONSTRAINT fk_master_contract_provider FOREIGN KEY ("provider")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "contract".master_contract_draft
  ADD CONSTRAINT fk_master_contract_draft_provider FOREIGN KEY ("provider")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "contract".master_contract_history
  ADD CONSTRAINT fk_master_contract_history_provider FOREIGN KEY ("provider")
      REFERENCES web.account (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

CREATE OR REPLACE VIEW contract.v_master_contract AS
  SELECT  all_contracts.* FROM (
  SELECT  "id",
          "key",
          "contract_root",
          "contract_parent",
          "owner",
          "title",
          "subtitle",
          "version",
          "created_at",
          "modified_at",
          "status",
          "default_contract",
          "provider"
  FROM  contract.master_contract_history
  union
  SELECT  "id",
          "key", null as contract_root,
          "parent",
          "owner",
          "title",
          "subtitle",
          "version",
          "created_at",
          "modified_at",
          'DRAFT',
          "default_contract",
          "provider"
  FROM contract.master_contract_draft
) AS all_contracts;

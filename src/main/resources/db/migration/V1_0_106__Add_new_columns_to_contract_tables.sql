ALTER TABLE "contract".master_contract ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".master_contract_draft ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".master_contract_history ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;

ALTER TABLE "contract".provider_contract ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".provider_contract_draft ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".provider_contract_history ADD IF NOT EXISTS default_contract boolean DEFAULT(false) NOT NULL;

ALTER TABLE "contract".provider_contract ADD IF NOT EXISTS default_contract_accepted boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".provider_contract_draft ADD IF NOT EXISTS default_contract_accepted boolean DEFAULT(false) NOT NULL;
ALTER TABLE "contract".provider_contract_history ADD IF NOT EXISTS default_contract_accepted boolean DEFAULT(false) NOT NULL;

CREATE OR REPLACE VIEW contract.v_master_contract AS
  SELECT  all_contracts.* FROM (
  SELECT  "id", "key", contract_root, contract_parent, "owner", title, subtitle, "version", created_at, modified_at, status,
          default_contract
  FROM  contract.master_contract_history
  union
  SELECT  "id", "key", null as contract_root, parent, "owner", title, subtitle, "version", created_at, modified_at, 'DRAFT',
          default_contract
  FROM contract.master_contract_draft
) AS all_contracts;

CREATE OR REPLACE VIEW contract.v_provider_contract AS
  SELECT  all_contracts.* FROM (
  SELECT  "id", "key", "template", contract_root, contract_parent, "owner", title, subtitle, "version", created_at, modified_at, status,
          default_contract, default_contract_accepted
  FROM contract.provider_contract_history
  union
  SELECT  "id", "key", "template", null as contract_root, parent, "owner", title, subtitle, "version", created_at, modified_at, 'DRAFT',
          default_contract, default_contract_accepted
  FROM contract.provider_contract_draft
) AS all_contracts;

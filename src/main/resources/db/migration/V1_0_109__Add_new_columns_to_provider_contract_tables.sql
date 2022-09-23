ALTER TABLE "contract".provider_contract         ADD IF NOT EXISTS default_contract_accepted_at timestamp NULL;
ALTER TABLE "contract".provider_contract_history ADD IF NOT EXISTS default_contract_accepted_at timestamp NULL;

CREATE OR REPLACE VIEW contract.v_provider_contract AS
  SELECT  all_contracts.* FROM (
  SELECT  "id", "key", "template", contract_root, contract_parent, "owner", title, subtitle, "version", created_at, modified_at, status,
          default_contract, default_contract_accepted, default_contract_accepted_at
  FROM contract.provider_contract_history
  union
  SELECT  "id", "key", "template", null as contract_root, parent, "owner", title, subtitle, "version", created_at, modified_at, 'DRAFT',
          default_contract, false, null
  FROM contract.provider_contract_draft
) AS all_contracts;


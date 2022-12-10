ALTER TABLE "provider".asset_draft DROP CONSTRAINT IF EXISTS chk_asset_type_status_enum;

ALTER TABLE "provider".asset_draft ADD CONSTRAINT chk_asset_type_status_enum CHECK ("status" IN (
  'DRAFT',
  'SUBMITTED',
  'PENDING_HELPDESK_REVIEW',
  'HELPDESK_REJECTED',
  'PENDING_PROVIDER_REVIEW',
  'PROVIDER_REJECTED',
  'POST_PROCESSING',
  'PUBLISHING',
  'PUBLISHED',
  'CANCELLED'
));

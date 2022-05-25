ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "workflow_error_details"   character varying   NULL;
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "workflow_error_messages"  jsonb               NULL;
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "helpdesk_error_message"   character varying   NULL;
ALTER TABLE "provider".asset_draft ADD IF NOT EXISTS "computed_geometry"        boolean             NOT NULL  DEFAULT(false);

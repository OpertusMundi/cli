ALTER TABLE "web".customer_draft DROP IF EXISTS "error_details";

ALTER TABLE "web".customer_draft ADD IF NOT EXISTS "workflow_error_details"   character varying   NULL;
ALTER TABLE "web".customer_draft ADD IF NOT EXISTS "workflow_error_messages"  jsonb               NULL;
ALTER TABLE "web".customer_draft ADD IF NOT EXISTS "helpdesk_error_message"   character varying   NULL;

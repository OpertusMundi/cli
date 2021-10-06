delete from "messaging".mail_template;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ACCOUNT_ACTIVATION_TOKEN', 'Account activation', 'account-registration-activation-token', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ACCOUNT_ACTIVATION_SUCCESS', 'Account activation completed', 'account-registration-complete', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ORDER_CONFIRMATION', 'Order confirmation', 'asset-purchase-confirm', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_REGISTRATION_EVALUATION', 'Supplier registration evaluation', 'supplier-registration-evaluation', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('DELIVERY_REQUEST', 'Delivery request', 'supplier-deliver-asset-request', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('NEW_DATASET_PURCHASE', 'New dataset purchase', 'supplier-digital-delivery-by-platform', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('DATASET_PURCHASE_REQUEST', 'Dataset purchase request', 'supplier-purchase-reminder', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('DATASET_READY_FOR_DOWNLOAD_SUPPLIER', 'Dataset ready for download', 'consumer-digital-delivery-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ORDER_SHIPPED', 'Order shipped', 'consumer-physical-delivery-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('DATASET_READY_FOR_DOWNLOAD_PLATFORM', 'Dataset ready for download', 'consumer-digital-delivery-by-platform', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('RECEIPT_ISSUED', 'Receipt issued', 'consumer-receipt-issued', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('PURCHASE_REQUEST_AWAITING_CONFIRMATION', 'Purchase request awaiting confirmation', 'consumer-purchase-notification', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('PURCHASE_REJECTED', 'Purchase rejected', 'consumer-purchase-rejected-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('UPLOAD_COMPLETED', 'Upload completed', 'files-upload-complete', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('NEW_MASTER_CONTRACT_TEMPLATE_AVAILABLE', 'New master contract template available', 'master-template-contract-update', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('IMPORTING_FROM_EXTERNAL_CATALOGUE_COMPLETED', 'Importing from external catalogue completed', 'catalogue-external-harvesting', 'Topio', 'support@topio.market', now())
;

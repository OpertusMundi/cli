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
  ('SUPPLIER_EVALUATION', 'Supplier registration evaluation', 'supplier-registration-evaluation', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_DELIVERY_REQUEST', 'Delivery request', 'supplier-deliver-asset-request', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_DIGITAL_DELIVERY', 'New dataset purchase', 'supplier-digital-delivery-by-platform', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_PURCHASE_REMINDER', 'Dataset purchase request', 'supplier-purchase-reminder', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_PUBLISHING_ACCEPTED', 'Asset publishing accepted', 'supplier-publication-accepted', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_PUBLISHING_REJECTED', 'Asset publishing rejected', 'supplier-publication-rejected', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('SUPPLIER_ASSET_PUBLISHED', 'Asset publishing accepted', 'supplier-asset-published', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_DIGITAL_DELIVERY_BY_SUPPLIER', 'Dataset ready for download', 'consumer-digital-delivery-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_PHYSICAL_DELIVERY_BY_SUPPLIER', 'Order shipped', 'consumer-physical-delivery-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_DIGITAL_DELIVERY_BY_PLATFORM', 'Dataset ready for download', 'consumer-digital-delivery-by-platform', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_RECEIPT_ISSUED', 'Receipt issued', 'consumer-receipt-issued', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_INVOICE', 'Invoice', 'consumer-invoice', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_PURCHASE_NOTIFICATION', 'Purchase request awaiting confirmation', 'consumer-purchase-notification', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_PURCHASE_APPROVED', 'Purchase approved', 'consumer-purchase-approved-by-supplier', 'Topio', 'support@topio.market', now())
;
  
insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CONSUMER_PURCHASE_REJECTION', 'Purchase rejected', 'consumer-purchase-rejected-by-supplier', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('FILES_UPLOAD_COMPLETED', 'Upload completed', 'files-upload-complete', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('MASTER_TEMPLATE_CONTRACT_UPDATE', 'New master contract template available', 'master-template-contract-update', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('CATALOGUE_HARVEST_COMPLETED', 'Importing from external catalogue completed', 'catalogue-external-harvesting', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('VENDOR_ACCOUNT_INVITATION', 'Join your organization on Topio', 'vendor-account-registration-activation-token', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('VENDOR_ACCOUNT_ACTIVATION_SUCCESS', 'Organization account activation completed', 'vendor-account-registration-complete', 'Topio', 'support@topio.market', now())
;

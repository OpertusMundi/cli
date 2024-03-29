delete from "messaging".notification_template;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_HARVEST_COMPLETED', 'Harvest operation for catalogue <span class="notification__text--bold">{catalogueUrl}</span> has been completed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_ASSET_UNPUBLISHED', 'Asset <span class="notification__text--bold">{assetName}</span> <span class="notification__text--bold">{assetVersion}</span> has been removed from the catalogue', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ORDER_CONFIRMATION', 'Order <span class="notification__text--bold">{orderId}</span> is being processed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DELIVERY_REQUEST', 'New delivery request for asset <span class="notification__text--bold">{assetName}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY', 'New purchase for asset <span class="notification__text--bold">{assetName}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PURCHASE_REMINDER', 'New purchase request for asset <span class="notification__text--bold">{assetName}</span> awaiting either approval or rejection', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY_BY_SUPPLIER', 'Asset <span class="notification__text--bold">{assetName}</span> is ready for download', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PHYSICAL_DELIVERY_BY_SUPPLIER', 'Asset <span class="notification__text--bold">{assetName}</span> has been shipped', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY_BY_PLATFORM', 'Asset <span class="notification__text--bold">{assetName}</span> is ready for download', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PURCHASE_APPROVED', 'Purchase of asset <span class="notification__text--bold">{assetName}</span> has been approved by supplier <span class="notification__text--bold">{supplierName}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PURCHASE_REJECTED', 'Purchase of asset <span class="notification__text--bold">{assetName}</span> has been rejected by supplier <span class="notification__text--bold">{supplierName}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('FILES_UPLOAD_COMPLETED', 'Files upload has been completed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHING_ACCEPTED', 'Publishing of <span class="notification__text--bold">{assetName}</span> has been approved by the Helpdesk', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHING_REJECTED', 'Publishing of <span class="notification__text--bold">{assetName}</span> has been rejected by the Helpdesk', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHING_CANCELLED', 'Publishing of <span class="notification__text--bold">{assetName}</span> has failed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHED', 'Asset <span class="notification__text--bold">{assetName}</span> has been successfully published', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('COPY_FILE_TO_TOPIO_DRIVE_SUCCESS', 'Resource <span class="notification__text--bold">{resourceFileName}</span> from asset <span class="notification__text--bold">{assetName}</span> has been successfully copied to your drive', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('COPY_FILE_TO_TOPIO_DRIVE_ERROR', 'Copy operation of resource <span class="notification__text--bold">{resourceFileName}</span> from asset <span class="notification__text--bold">{assetName}</span> to your drive has failed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('USER_SERVICE_PUBLISH_SUCCESS', 'User service <span class="notification__text--bold">{serviceTitle}</span> is ready', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('USER_SERVICE_PUBLISH_FAILURE', 'Publishing of user service <span class="notification__text--bold">{serviceTitle}</span> has failed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('USER_SERVICE_REMOVE', 'User service <span class="notification__text--bold">{serviceTitle}</span> has been deleted', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CONSUMER_REGISTRATION_CANCELLED', 'Consumer registration has failed: <span class="notification__text--bold">{errorMessage}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PROVIDER_REGISTRATION_CANCELLED', 'Provider registration has failed: <span class="notification__text--bold">{errorMessage}</span>', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_AVAILABLE_TO_PURCHASE', 'Asset <span class="notification__text--bold">{assetName}</span> from your favorite list is now available to purchase! Come take a look!', now())
;

-- Subscription and private OGC service billing notifications

insert into "messaging".notification_template ("type", "text", "modified_on") values
('SUBSCRIPTION_BILLING_SINGLE_CHARGE',
 'Subscription <span class=""""notification__text--bold"""">{asset_title}</span> has been charged <span class=""""notification__text--bold"""">{amount}</span> for the interval <span class=""""notification__text--bold"""">{intervalFrom}</span> - <span class=""""notification__text--bold"""">{intervalTo}</span>.  Payment due date is <span class=""""notification__text--bold"""">{dueDate}</span>.', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('SUBSCRIPTION_BILLING_PAYOFF',
 'Subscription <span class=""""notification__text--bold"""">{asset_title}</span> for the interval <span class=""""notification__text--bold"""">{intervalFrom}</span> - <span class=""""notification__text--bold"""">{intervalTo}</span> has been paid off.', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('USER_SERVICE_BILLING_SINGLE_CHARGE',
 'User service <span class=""""notification__text--bold"""">{service_title}</span> has been charged <span class=""""notification__text--bold"""">{amount}</span> for the interval <span class=""""notification__text--bold"""">{intervalFrom}</span> - <span class=""""notification__text--bold"""">{intervalTo}</span>.  Payment due date is <span class=""""notification__text--bold"""">{dueDate}</span>.', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('USER_SERVICE_BILLING_PAYOFF',
 'User service <span class=""""notification__text--bold"""">{service_title}</span> for the interval <span class=""""notification__text--bold"""">{intervalFrom}</span> - <span class=""""notification__text--bold"""">{intervalTo}</span> has been paid off.', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('SERVICE_BILLING_TOTAL_CHARGE',
 'Your active subscriptions and private OGC services have been charged <span class=""""notification__text--bold"""">{amount}</span> for the interval <span class=""""notification__text--bold"""">{intervalFrom}</span> - <span class=""""notification__text--bold"""">{intervalTo}</span>.  Payment due date is <span class=""""notification__text--bold"""">{dueDate}</span>.".', now())
;

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
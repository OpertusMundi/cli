delete from "messaging".notification_template;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_HARVEST_COMPLETED', 'Harvest operation for catalogue {catalogueUrl} has been completed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_ASSET_UNPUBLISHED', 'Asset {assetName} {assetVersion} has been removed from the catalogue', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ORDER_CONFIRMATION', 'Order {orderID} is being processed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DELIVERY_REQUEST', 'New delivery request for asset {assetName}', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY', 'New purchase for asset {assetName}', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PURCHASE_REMINDER', 'New purchase request for asset {assetName}', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY_BY_SUPPLIER', 'Asset {assetName} is ready for download', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PHYSICAL_DELIVERY_BY_SUPPLIER', 'Asset {assetName} has been shipped', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('DIGITAL_DELIVERY_BY_PLATFORM', 'Asset {assetName} is ready for download', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('PURCHASE_REJECTED', 'Purchase of asset {assetName} has been rejected by supplier {supplierName}', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('FILES_UPLOAD_COMPLETED', 'Files upload has been completed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHING_ACCEPTED', 'Asset {assetName} has been successfully published', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('ASSET_PUBLISHING_REJECTED', 'Publishing of {assetName} has been rejected by the helpdesk', now())
;

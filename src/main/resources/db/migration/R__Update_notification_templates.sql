delete from "messaging".notification_template;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_HARVEST_COMPLETED', 'Harvest operation for catalogue {catalogueUrl} has been completed', now())
;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_ASSET_UNPUBLISHED', 'Asset {assetName} {assetVersion} has been removed from the catalogue', now())
;
delete from "messaging".notification_template;

insert into "messaging".notification_template ("type", "text", "modified_on") values
('CATALOGUE_HARVEST_COMPLETED', 'Harvest operation for catalogue {catalogueUrl} has been completed', now())
;
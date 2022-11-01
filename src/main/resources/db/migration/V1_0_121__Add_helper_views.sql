
CREATE VIEW "file"."asset_published_resource_view" AS 
    SELECT * FROM "file"."asset_resource" r WHERE r."pid" IS NOT null;

CREATE VIEW "web"."account_active_subscription_view" AS 
    SELECT * FROM "web"."account_subscription" s WHERE s."status" = 'ACTIVE';

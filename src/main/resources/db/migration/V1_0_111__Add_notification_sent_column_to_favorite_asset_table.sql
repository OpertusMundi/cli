ALTER TABLE "web".favorite_asset ADD IF NOT EXISTS "notification_sent" BOOLEAN DEFAULT(false) NOT NULL;

comment on column "web".favorite_asset.notification_sent is 'True if a notification was sent once the asset become available to purchase';
-- Billing address
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_first_name"            character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_last_name"             character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_line_1"        character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_line_2"        character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_city"          character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_region"        character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_postal_code"   character varying(50);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "billing_address_country"       character varying(2);

-- Shipping address
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_first_name"           character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_last_name"            character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_line_1"       character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_line_2"       character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_city"         character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_region"       character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_postal_code"  character varying(50);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "shipping_address_country"      character varying(2);

-- Browser information
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_accept_header"    character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_java_enabled"     boolean;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_language"         character varying(255);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_color_depth"      integer;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_screen_height"    integer;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_screen_width"     integer;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_time_zone_offset" integer;
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "browser_info_user_agent"       character varying(255);

-- IP address
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "ip_address"                    character varying(255);

-- 3DS version
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "requested_3ds_version"         character varying(10);
ALTER TABLE "billing".payin_card_direct ADD IF NOT EXISTS "applied_3ds_version"           character varying(10);

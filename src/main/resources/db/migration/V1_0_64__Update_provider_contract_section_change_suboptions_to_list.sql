-- Change field `suboptions` to list
ALTER TABLE "contract".provider_section 		ALTER COLUMN sub_option TYPE integer[] USING array[sub_option]::integer[];
ALTER TABLE "contract".provider_section_draft 	ALTER COLUMN sub_option TYPE integer[] USING array[sub_option]::integer[];
ALTER TABLE "contract".provider_section_history ALTER COLUMN sub_option TYPE integer[] USING array[sub_option]::integer[];
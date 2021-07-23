ALTER TABLE "contract".master_section ALTER COLUMN options TYPE JSONB USING TO_JSON(options)::JSONB;
ALTER TABLE "contract".master_section DROP COLUMN styled_options;
ALTER TABLE "contract".master_section DROP COLUMN sub_options;
ALTER TABLE "contract".master_section DROP COLUMN summary;
ALTER TABLE "contract".master_section DROP COLUMN icons;
ALTER TABLE "contract".master_section_draft ALTER COLUMN options TYPE JSONB USING TO_JSON(options)::JSONB;
ALTER TABLE "contract".master_section_draft DROP COLUMN styled_options;
ALTER TABLE "contract".master_section_draft DROP COLUMN sub_options;
ALTER TABLE "contract".master_section_draft DROP COLUMN summary;
ALTER TABLE "contract".master_section_draft DROP COLUMN icons;
ALTER TABLE "contract".master_section_history ALTER COLUMN options TYPE JSONB USING TO_JSON(options)::JSONB;
ALTER TABLE "contract".master_section_history DROP COLUMN styled_options;
ALTER TABLE "contract".master_section_history DROP COLUMN sub_options;
ALTER TABLE "contract".master_section_history DROP COLUMN summary;
ALTER TABLE "contract".master_section_history DROP COLUMN icons;

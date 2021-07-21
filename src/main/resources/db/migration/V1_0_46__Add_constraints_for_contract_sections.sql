ALTER TABLE "contract".provider_section_history DROP CONSTRAINT IF EXISTS fk_provider_section_history_master_section;
ALTER TABLE "contract".provider_section_draft DROP CONSTRAINT IF EXISTS fk_provider_section_draft_master_section;
ALTER TABLE "contract".provider_section DROP CONSTRAINT IF EXISTS fk_provider_section_master_section;

ALTER TABLE "contract".provider_section_history
  ADD CONSTRAINT fk_provider_section_history_master_section FOREIGN KEY ("master_section")
  REFERENCES "contract".master_section_history("id") MATCH SIMPLE;

ALTER TABLE "contract".provider_section_draft
  ADD CONSTRAINT fk_provider_section_draft_master_section FOREIGN KEY ("master_section")
  REFERENCES "contract".master_section_history("id") MATCH SIMPLE;

ALTER TABLE "contract".provider_section
  ADD CONSTRAINT fk_provider_section_master_section FOREIGN KEY ("master_section")
  REFERENCES "contract".master_section_history("id") MATCH SIMPLE;
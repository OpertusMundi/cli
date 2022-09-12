ALTER TABLE "file".asset_resource ADD IF NOT EXISTS "parent_id" character varying(60);

comment on column "file".asset_resource.parent_id is
  'The parent resource key';

ALTER TABLE "file".asset_resource ADD IF NOT EXISTS "path" character varying NULL;

comment on column "file".asset_resource.path is
  'The relative path of the resource file if source is FILE_SYSTEM';

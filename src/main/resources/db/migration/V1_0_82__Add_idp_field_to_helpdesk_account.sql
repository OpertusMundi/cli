ALTER TABLE "admin".account ADD IF NOT EXISTS "idp" boolean NOT NULL DEFAULT(false);

comment on column "admin".account.idp is
  'Indicates if the local account is registered with the IDP';
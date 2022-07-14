ALTER TABLE "web".account ADD IF NOT EXISTS "active_task" character varying(20) NOT NULL DEFAULT('NONE');

comment on column "web".account.active_task is
  'Indicates the current active task for this account';

ALTER TABLE "web".account DROP CONSTRAINT IF EXISTS chk_account_active_task_enum;

ALTER TABLE "web".account ADD CONSTRAINT chk_account_active_task_enum CHECK
  ("active_task" IN ('NONE', 'DELETE', 'DATA_RESET'));
ALTER TABLE web."record_lock" DROP CONSTRAINT IF EXISTS chk_favorite_type_enum;
ALTER TABLE web."record_lock" DROP CONSTRAINT IF EXISTS chk_record_lock_record_type_enum;

ALTER TABLE web."record_lock" ADD CONSTRAINT chk_record_lock_record_type_enum CHECK
  ("record_type" IN ('DRAFT', 'USER_SERVICE'));
ALTER TABLE "billing".payin_recurring_registration ALTER COLUMN "subscription" DROP NOT NULL;
ALTER TABLE "billing".payin_recurring_registration ALTER COLUMN "end_date" DROP NOT NULL;
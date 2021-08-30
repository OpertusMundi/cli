delete from "messaging".mail_template;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ACCOUNT_ACTIVATION_TOKEN', 'Account activation', 'account-registration-activation-token', 'Topio', 'support@topio.market', now())
;

insert into "messaging".mail_template (
  "type", "subject_template", "content_template", "sender_name", "sender_email", "modified_on"
) values
  ('ACCOUNT_ACTIVATION_SUCCESS', 'Account activation completed', 'account-registration-complete', 'Topio', 'support@topio.market', now())
;

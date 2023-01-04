INSERT into web.settings values ('API_GATEWAY',   'announcement.text',                'HTML',     '',      null,  now(), false)
  ON CONFLICT DO NOTHING;
INSERT into web.settings values ('API_GATEWAY',   'announcement.enabled',             'BOOLEAN',  'false', null,  now(), false)
  ON CONFLICT DO NOTHING;
INSERT into web.settings values ('ADMIN_GATEWAY', 'user-service.pricing-model.price', 'JSON',     '',      null,  now(), false)
  ON CONFLICT DO NOTHING;
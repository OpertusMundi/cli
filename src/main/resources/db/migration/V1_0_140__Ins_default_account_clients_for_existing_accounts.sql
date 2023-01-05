
WITH t1 AS (SELECT now() AS t)
INSERT INTO web."account_client"
  ("account", "client_id", "alias", "created_on")
SELECT
  a.id, a.key, 'DEFAULT', t1.t
FROM web.account a CROSS JOIN t1
WHERE a."activation_status" = 'COMPLETED' AND a.id < 1000000;

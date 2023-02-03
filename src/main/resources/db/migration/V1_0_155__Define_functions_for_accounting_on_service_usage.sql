CREATE VIEW web.account_subscription_with_asset_key_view AS
SELECT 
    s.*,
    f."key" as "asset_key"
FROM web.account_subscription s 
    INNER JOIN file.asset_resource f ON (f."pid" = s."asset");


CREATE TABLE web.service_usage_summary (
    "service_key" uuid NOT NULL,
    "start_date" date NOT NULL,
    "calls" bigint,
    "calls_normalized" numeric(15,1),
    "response_size_bytes" bigint,
    "response_time_seconds" numeric(15,3),
    PRIMARY KEY ("service_key", "start_date")
);

--
-- Define helper views for separating usage summaries for subscription/private services
--

CREATE VIEW web.subscription_service_usage_summary_view AS
SELECT 
    s."key" AS "subscription_key",
    s."provider",
    s."consumer",
    s."asset_key",
    a.*
FROM web.service_usage_summary a 
    INNER JOIN web.account_subscription_with_asset_key_view s ON (a."service_key" = s."key");

CREATE VIEW web.user_service_usage_summary_view AS
SELECT
    s."key" as "user_service_key",
    s."account",
    s."key" as "asset_key",
    a.*
FROM web.service_usage_summary a
    INNER JOIN web.account_user_service s ON (a."service_key" = s."key");

--
-- Define functions for accounting on service usage 
--

-- note: aggregation should run in REPEATABLE READ isolation level!

CREATE OR REPLACE FUNCTION web.aggregate_service_usage_for_subscriptions(
        IN from_time timestamp, 
        IN to_time timestamp)
    RETURNS SETOF web.service_usage_summary
    LANGUAGE sql 
AS $function$
WITH req1 AS ( 
    SELECT 
        r."request_id",
        r."asset_keys",
        r."response_size",
        r."took" AS "response_time",
        date_trunc('month', r."recorded")::date AS "start_date",
        (1.0 / cardinality(r."asset_keys")) AS "weight",
        s."key" AS "subscription_key", 
        s."asset_key"
    FROM web.account_client_request r
        INNER JOIN web.account_client c ON (c."client_id" = r."client_id") 
        INNER JOIN web.account_subscription_with_asset_key_view s ON (s."consumer" = c."account" 
            AND ARRAY[s."asset_key"::text] <@ r."asset_keys")
    WHERE r."accounted" is NULL AND r."asset_keys" is not NULL
        AND r."started" is not NULL
        AND r."recorded" >= $1 AND r."recorded" < $2
), req1_upd AS (
    UPDATE web.account_client_request r
    SET 
        "accounted" = statement_timestamp()
    FROM req1 
    WHERE req1."request_id" = r."request_id" AND r."accounted" is NULL
    RETURNING r."request_id"
)
SELECT 
    "subscription_key" AS "service_key",
    "start_date",
    count("request_id") AS "calls",
    sum("weight")::numeric(15, 1) AS "calls_normalized",
    sum("response_size") AS "response_size_bytes",
    (sum("response_time") / 1000.0)::numeric(15, 3) AS "response_time_seconds"
FROM req1
GROUP BY "service_key", "start_date"
$function$;

CREATE OR REPLACE FUNCTION web.aggregate_service_usage_for_user_services(
        IN from_time timestamp, 
        IN to_time timestamp)
    RETURNS SETOF web.service_usage_summary
    LANGUAGE sql 
AS $function$
WITH req1 AS ( 
    SELECT 
        r."request_id",
        r."asset_keys",
        r."response_size",
        r."took" AS "response_time",
        date_trunc('month', r."recorded")::date AS "start_date",
        (1.0 / cardinality(r."asset_keys")) AS "weight",
        s."key" AS "asset_key" 
    FROM web.account_client_request r
        INNER JOIN web.account_client c ON (c."client_id" = r."client_id") 
        INNER JOIN web.account_user_service s ON (s."account" = c."account" 
            AND ARRAY[s."key"::text] <@ r."asset_keys")
    WHERE r."accounted" is NULL AND r."asset_keys" is not NULL
        AND r."started" is not NULL
        AND r."recorded" >= $1 AND r."recorded" < $2
), req1_upd AS (
    UPDATE web.account_client_request r
    SET 
        "accounted" = statement_timestamp()
    FROM req1 
    WHERE req1."request_id" = r."request_id" AND r."accounted" is NULL
    RETURNING r."request_id"
)
SELECT 
    "asset_key" AS "service_key",
    "start_date",
    count("request_id") AS "calls",
    sum("weight")::numeric(15, 1) AS "calls_normalized",
    sum("response_size") AS "response_size_bytes",
    (sum("response_time") / 1000.0)::numeric(15, 3) AS "response_time_seconds"
FROM req1
GROUP BY "service_key", "start_date"
$function$;


CREATE OR REPLACE FUNCTION web.aggregate_service_usage(
        IN from_time timestamp, 
        IN to_time timestamp)
    RETURNS SETOF web.service_usage_summary
    LANGUAGE sql 
AS $function$
SELECT * FROM web.aggregate_service_usage_for_subscriptions($1, $2)
UNION
SELECT * FROM web.aggregate_service_usage_for_user_services($1, $2)
$function$;

CREATE OR REPLACE FUNCTION web.account_service_usage(
        IN from_time timestamp, 
        IN to_time timestamp)
    RETURNS SETOF web.service_usage_summary
    LANGUAGE sql
AS $function$
INSERT INTO web.service_usage_summary AS s
    SELECT * FROM web.aggregate_service_usage($1, $2)
ON CONFLICT ("service_key", "start_date") DO UPDATE
    SET
        "calls" = s."calls" + excluded."calls",
        "calls_normalized" = s."calls_normalized" + excluded."calls_normalized",
        "response_size_bytes" = s."response_size_bytes" + excluded."response_size_bytes",
        "response_time_seconds" = s."response_time_seconds" + excluded."response_time_seconds"
RETURNING *
$function$;


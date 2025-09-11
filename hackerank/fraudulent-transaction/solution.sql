-- MySQL
WITH fraudulent_transaction_1 AS (
  SELECT
    YEAR(`timestamp`)  AS year,
    MONTH(`timestamp`) AS month,
    DAY(`timestamp`)   AS day,
    HOUR(`timestamp`)  AS hour,
    user_id,
    JSON_ARRAYAGG(`timestamp`) AS ts,
    SUM(amount)   AS total_amount,
    COUNT(*)      AS transaction_count
  FROM `transaction`
  GROUP BY user_id,
           YEAR(`timestamp`), MONTH(`timestamp`), DAY(`timestamp`), HOUR(`timestamp`)
  HAVING transaction_count > 1
)
SELECT
  f.user_id,
  f.transaction_count,
  f.total_amount,
  (
    SELECT MIN(jt.value)
    FROM JSON_TABLE(f.ts, "$[*]"
         COLUMNS ( value DATETIME PATH "$" )
    ) AS jt
  ) AS start_time,
  (
    SELECT MAX(jt.value)
    FROM JSON_TABLE(f.ts, "$[*]"
         COLUMNS ( value DATETIME PATH "$" )
    ) AS jt
  ) AS end_time
FROM fraudulent_transaction_1 f;

-- Postgres
WITH fraudulent_transaction_1 AS (
    SELECT
        EXTRACT(YEAR FROM timestamp) AS year,
        EXTRACT(MONTH FROM timestamp) AS month,
        EXTRACT(DAY FROM timestamp) AS day,
        EXTRACT(HOUR FROM timestamp) AS hour,
        user_id,
        ARRAY_AGG(timestamp ORDER BY timestamp) AS ts,
        SUM(amount) AS total_amount,
        COUNT(*) AS transaction_count
    FROM transaction
    GROUP BY 
        user_id,
        EXTRACT(YEAR FROM timestamp), 
        EXTRACT(MONTH FROM timestamp), 
        EXTRACT(DAY FROM timestamp), 
        EXTRACT(HOUR FROM timestamp)
    HAVING COUNT(*) > 1
)
SELECT
    f.user_id,
    f.transaction_count,
    f.total_amount,
    f.ts[1] AS start_time,           
    f.ts[array_length(f.ts, 1)] AS end_time  -- Last element
FROM fraudulent_transaction_1 f;
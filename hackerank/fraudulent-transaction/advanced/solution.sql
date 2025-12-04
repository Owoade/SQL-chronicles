WITH base AS (
	SELECT 
		*,
		LAG(timestamp) OVER(PARTITION BY user_id ORDER BY timestamp) AS last_trx_occured_at
	FROM transaction
),
fraudulent_trx AS (
	SELECT
		*,
		EXTRACT(EPOCH FROM (timestamp - last_trx_occured_at)) / 3600 < 1 AS is_fraudulent
	FROM base
)
SELECT user_id, COUNT(*) FROM fraudulent_trx WHERE is_fraudulent GROUP BY user_id;
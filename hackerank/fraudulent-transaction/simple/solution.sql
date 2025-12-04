SELECT 
    user_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    MIN(timestamp) AS start_time,
    MAX(timestamp) AS end_time
FROM transaction 
GROUP BY user_id, DATE_TRUNC('hour', timestamp) 
HAVING COUNT(*) > 1;
WITH computed_data AS (
    SELECT 
        CAST(date as date) as date,
        COALESCE(dollars, 0) as dollars,
        LAG(dollars, 1) 
        OVER (
            PARTITION BY EXTRACT('isodow' from date) ORDER BY date
        ) as last_week_dollars
    FROM generate_series(
        '2025-10-17'::DATE - INTERVAL '1 week',
        ('2025-10-17'::DATE + INTERVAL '1 month')::DATE - INTERVAL '1 day',
        INTERVAL '1 day'
    )
    INNER JOIN factbook using(date)
)
SELECT 
    day,
    date,
    TO_CHAR(
        COALESCE(dollars, 0),
        'L99G999G999G999'
    ) as dollars,
    CASE WHEN dollars IS NOT NULL AND dollars <> 0
        THEN ROUND( 100 * (dollars-last_week_dollars)/dollars,2)
    END AS "Wow %"
FROM computed_data
WHERE date >= '2025-10-17'
ORDER BY date;
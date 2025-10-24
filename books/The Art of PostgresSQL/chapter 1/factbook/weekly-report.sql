WITH computed_data AS (
    SELECT 
        CAST(date AS date) AS date,
        TO_CHAR(date, 'Dy') AS day,
        COALESCE(dollars, 0) AS dollars,
        LAG(dollars, 1) OVER (
            PARTITION BY EXTRACT('isodow' FROM date) ORDER BY date
        ) AS last_week_dollars
    FROM generate_series(
        '2025-10-17'::DATE - INTERVAL '1 week',
        ('2025-10-17'::DATE + INTERVAL '1 month')::DATE - INTERVAL '1 day',
        INTERVAL '1 day'
    ) AS gs(date)
    INNER JOIN factbook USING(date)
)
SELECT 
    day,
    date,
    TO_CHAR(
        COALESCE(dollars, 0),
        'L99G999G999G999'
    ) AS dollars,
    CASE WHEN dollars IS NOT NULL AND dollars <> 0
        THEN ROUND(100 * (dollars - last_week_dollars) / dollars, 2)
    END AS "Wow %"
FROM computed_data
WHERE date >= '2025-10-17'
ORDER BY date;

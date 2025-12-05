WITH accidents AS (
	SELECT 
		EXTRACT(YEAR FROM date) AS season,
		COUNT(*) AS participants,
		COUNT(*) FILTER(WHERE status = 'Accident') AS accident
	FROM results
	JOIN status USING(statusid)
	JOIN races USING(raceid)
	GROUP BY season
)
SELECT 
	season,
	ROUND(100*accident/participants, 2) AS pct,
	REPEAT(
		TEXT '■',
		CEIL(100*accident/participants)::INT
	) AS bars
FROM accidents
WHERE season BETWEEN 1974 AND 1990
ORDER BY season;
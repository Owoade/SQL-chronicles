/*
    This query identifies the top 3 most successful Formula 1 drivers in each decade 
    of racing history, ranked by their total race wins during that period. It groups 
    all races by decade (1950s, 1960s, 1970s, etc.), counts the number of wins for 
    each driver within each decade, and returns the three drivers with the most wins 
    per decade along with their ranking (1st, 2nd, 3rd place).
*/
WITH decades AS (
	SELECT DISTINCT EXTRACT('year' FROM DATE_TRUNC('decade', date)) decade FROM races
)
SELECT *, RANK() OVER(PARTITION BY decade ORDER BY wins DESC) FROM decades d
LEFT JOIN LATERAL (
	SELECT COUNT(*) wins, dr.forename, dr.surname FROM results re
	JOIN drivers dr USING (driverid)
	JOIN races r USING (raceid)
	WHERE re.position = 1 AND d.decade = EXTRACT('year' FROM DATE_TRUNC('decade', date))
	GROUP BY dr.driverid, d.decade
	ORDER BY wins DESC
	LIMIT 3
) AS winners ON TRUE;
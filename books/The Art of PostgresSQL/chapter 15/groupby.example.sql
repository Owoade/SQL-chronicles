WITH count AS (
	SELECT 
		date_trunc('year', date) as year,
		count(*) filter(where position is null) as out,
		bool_and(position is null) as never_finished
	FROM drivers
	JOIN results using(driverid)
	JOIN races using(raceid)
	GROUP BY driverid, date_trunc('year', date)
)
SELECT 
	EXTRACT(year from "year") as season, 
	SUM(out) AS "#times driver didn't finish" 
FROM count WHERE never_finished 
GROUP BY season 
ORDER BY SUM(out) DESC
LIMIT 5;
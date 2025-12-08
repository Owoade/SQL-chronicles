-- This query return each season's driver and constructor's champion
WITH points AS (
	SELECT 
		year AS season, 
		SUM(points) AS points,
		driverid,
		constructorid
	FROM results 
	JOIN races USING(raceid)
	GROUP BY GROUPING SETS(
		(season, driverid),
		(season, constructorid)
	)
	HAVING SUM(points) > 0
	ORDER BY season, points DESC
),
tops AS (
	SELECT 
		season,
		MAX(points) FILTER(WHERE driverid IS NULL) AS ctops,
		MAX(points) FILTER(WHERE constructorid IS NULL) AS dtops 
	FROM points
	GROUP BY season
),
champs AS (
	SELECT 
		t.season,
		champ_driver.driverid,
		champ_constructor.constructorid,
		t.dtops,
		t.ctops
	FROM tops t
	JOIN points champ_driver ON 
		champ_driver.season = t.season AND
		champ_driver.constructorid IS NULL AND 
		champ_driver.points = t.dtops
	JOIN points champ_constructor ON
		champ_constructor.season = t.season AND
		champ_constructor.driverid IS NULL AND 
		champ_constructor.points = t.ctops
)
SELECT 
	season,
	FORMAT('%s %s', drivers.forename, drivers.surname) AS "Driver's Champion",
	constructors.name AS "Constructor's Name"
FROM champs 
JOIN drivers USING(driverid)
JOIN constructors USING(constructorid)
ORDER BY season DESC;

select 
	year as season,
	driverid,
	constructorid,
	sum(points) as points
from results 
join races using(raceid)
group by grouping sets(
	 (season, driverid),
	 (season, constructorid)
) order by season, points desc;
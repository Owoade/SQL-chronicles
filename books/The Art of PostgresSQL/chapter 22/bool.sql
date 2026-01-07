-- This query identifies drivers who achieved a perfect finishing record in a given year.
-- It returns drivers who won every single race they finished (excluding DNFs/retirements).
-- The results show the total races entered, races won, races finished, and total points earned.
-- Drivers are grouped by year and ordered by year ascending, then points descending within each year.
/* 
    Note: 🔴🔴 DNFs (position IS NULL) don't count against the driver - only completed races are evaluated.
    To find drivers who won ALL races they started (including treating DNFs as failures),
    use: HAVING BOOL_AND(position IS NOT DISTINCT FROM 1) IS TRUE
    This treats NULL positions as FALSE, requiring every single race entry to be a win. 
*/


SELECT year,
       FORMAT('%s %s', forename, surname) AS name,
       COUNT(*) AS ran,
       COUNT(*) FILTER(WHERE position = 1) AS won,
       COUNT(*) FILTER(WHERE position IS NOT NULL) AS finished,
       SUM(points) AS points
FROM races
JOIN results USING(raceid)
JOIN drivers USING(driverid)
GROUP BY year, drivers.driverid
HAVING BOOL_AND(position = 1) IS TRUE
ORDER BY year, points DESC;
(
    SELECT 
        r.driverid,
        FORMAT('%s %s', d.forename, d.surname) AS name
    FROM results r
    JOIN drivers d USING(driverid)
    WHERE r.raceid = 972 AND r.points = 0
)
EXCEPT 
(
  SELECT 
        r.driverid,
        FORMAT('%s %s', d.forename, d.surname) AS name
    FROM results r
    JOIN drivers d USING(driverid)
    WHERE r.raceid = 971 AND r.points = 0
);

-- INTERSECT FUNCTION ALSO EXISTS
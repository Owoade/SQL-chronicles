(
    SELECT 
        ds.raceid,
        'driver' AS type,
        FORMAT('%s %s', d.forename, d.surname) AS name,
        ds.points
    FROM driverstandings ds
    JOIN drivers d USING(driverid)
    WHERE ds.raceid = 972 AND ds.points > 0
)
UNION ALL
(
    SELECT 
        cs.raceid,
        'constructor' AS type,
        c.name AS name,
        cs.points
    FROM constructorstandings cs
    JOIN constructors c USING(constructorid)
    WHERE cs.raceid = 972 AND cs.points > 0
)
ORDER BY points desc;
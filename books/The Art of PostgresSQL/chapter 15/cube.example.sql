SELECT 
	drivers.surname,
	constructors.name,
	SUM(points)
FROM results
JOIN races USING(raceid)
JOIN drivers USING(driverid)
JOIN constructors USING(constructorid)
WHERE drivers.surname IN ('Prost', 'Senna')
GROUP BY CUBE(drivers.surname, constructors.name)
ORDER BY drivers.surname, constructors.name;

/*
"surname"	    "name"	    "sum"
"Prost"	    "Ferrari"	    107.00
"Prost"	    "McLaren"	    458.50
"Prost"	    "Renault"	    134.00
"Prost"	    "Williams"	    99.00
"Prost"		                798.50
"Senna"	    "HRT"	        0.00
"Senna"	    "McLaren"	    451.00
"Senna"	    "Renault"	    2.00
"Senna"	    "Team Lotus"	150.00
"Senna"	    "Toleman"	    13.00
"Senna"	    "Williams"	    31.00
"Senna"		                47.00
	        "Ferrari"	    107.00
	        "HRT"	        0.00
	        "McLaren"	    909.50
	        "Renault"	    136.00
	        "Team Lotus"	150.00
	        "Toleman"	    13.00
	        "Williams"	    130.00
		                    1445.50
*/
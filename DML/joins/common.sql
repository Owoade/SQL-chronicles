-- INNER JOIN
/*
INNER JOIN in SQL:
- The INNER keyword is optional. Writing just "JOIN" is the same as "INNER JOIN".

- Important:
  If you leave out the join predicate (the ON or USING clause):
    • In MySQL → it runs a Cartesian product (CROSS JOIN),
      combining every row from the first table with every row from the second.
    • In PostgreSQL → it throws an error, because ON or USING is required.
*/

SELECT * from table1 INNER JOIN table2 ON table1.col = table2.col; 

-- LEFT JOIN
SELECT * from table1 LEFT OUTER JOIN table2 ON table1.col = table2.col; 

-- RIGHT JOIN
SELECT * from table1 RIGHT OUTER JOIN table2 ON table1.col = table2.col; 

-- FULL OUTER JOIN(doesn't exist in MySql)
SELECT * from table1 FULL OUTER JOIN table2 ON table1.col = table2.col; 
/*
    NC Subqueries are independent of the outer query, can run as a stand alone query
*/

-- Selecting columns from inner query
SELECT 
    col1,
    (
        SELECT col2 FROM inner_table;
    ) 
FROM outer_table;

/* 
    Filter outer table using inner query
    NOTE: if any of the subqueries yield a NULL value the outer query will return no value
*/

SELECT * FROM outer_table 
WHERE outer_table.col IN (
    SELECT inner_col FROM inner_table;
)


SELECT * FROM outer_table 
WHERE outer_table.col NOT IN (
    SELECT inner_col FROM inner_col;
)

-- When using comparision operators as the one below your sub-query must return one row else you get an error (Postgres and MyQL confirmed)
SELECT * FROM outer_table
WHERE outer_table.col >= (
    SELECT inner_col FROM inner_col;
) 
-- ... other query patterns








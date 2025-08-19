/*
    These are queries that are dependent on the outer query
*/

-- Using them in SELECT
SELECT 
    *,
    (
        SELECT it.col FROM inner_table it WHERE it.col = ot.col
    )
FROM outer_table ot

-- Using them in WHERE
SELECT * FROM outer_table ot
WHERE ot.col = (
    SELECT it.col from inner_table it WHERE it.col2 = ot.col2
)

SELECT * FROM outer_table ot
WHERE EXISTS (
    SELECT * FROM inner_table it where it.col2 = ot.col1
);
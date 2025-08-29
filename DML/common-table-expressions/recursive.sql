-- Template
WITH query1 
AS (
    initial_query
    UNION ALL 
    recursive_query
)
SELECT * FROM query1;

-- Example 1
-- Termination clause must be added as seen in WHERE CLAUSE to prevent error in MySQL
WITH RECURSIVE query1 (x) AS (
    SELECT 1 
    UNION ALL 
    SELECT x + 1 FROM query1 WHERE x < 100
)
SELECT MAX(x) as max_x FROM query1;


-- Example 2
WITH RECURSIVE factorial(n, fact) AS (
    SELECT 1 as n, 1 as fact
    UNION ALL
    SELECT n + 1, fact * (n+1) from factorial
    WHERE n < 10
)
SELECT * FROM factorial;



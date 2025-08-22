-- Tempate
WITH query1 (col1, col2, col3)
AS (SELECT col1, col2, col3 FROM table1)
query2 (col1, col2, col3)
AS (SELECT col1, col2, col3 FROM table2)
SELECT * FROM query1 JOIN query2;

-- Example 1
WITH customer_most_recent_activity_log (customer_id, "type", created_at)
AS (SELECT customer_id, "type", created_at FROM activity_log where customer_id = 1 ORDER BY created_at DESC LIMIT 1)
SELECT * from customers c INNER JOIN customer_most_recent_activity_log ON customer_most_recent_activity_log.customer_id = c.id WHERE c.id = 1;

-- Example 2
WITH manager( id, "name" )
AS (SELECT id, "name" FROM employee WHERE manager_id IS NULL)
SELECT * FROM employee INNER JOIN manager ON employee.manager_id = manager.id WHERE employee.manager_id IS NOT NULL; 

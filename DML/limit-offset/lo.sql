/*
MySQL vs PostgreSQL: LIMIT and OFFSET differences

1. OFFSET usage:
   - MySQL: OFFSET cannot be used without LIMIT.
            Example: SELECT * FROM users OFFSET 5; -- ❌ Invalid
   - PostgreSQL: OFFSET can be used alone.
            Example: SELECT * FROM users OFFSET 5; -- ✅ Valid

2. Clause order:
   - MySQL: OFFSET must come after LIMIT.
            Example: SELECT * FROM users LIMIT 10 OFFSET 5; -- ✅ Valid
                     SELECT * FROM users OFFSET 5 LIMIT 10; -- ❌ Invalid
   - PostgreSQL: LIMIT and OFFSET order does not matter.
            Example: SELECT * FROM users LIMIT 10 OFFSET 5; -- ✅ Valid
                     SELECT * FROM users OFFSET 5 LIMIT 10; -- ✅ Valid
*/
SELECT cols FROM table_name LIMIT limit_value OFFSET offset_value
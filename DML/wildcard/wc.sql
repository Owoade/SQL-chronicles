/*
Wildcard operations in SQL (used with LIKE):
1. %  → matches zero or more characters
   Example: 'Jo%' matches 'Jo', 'John', 'Jones'

2. _  → matches exactly one character
   Example: 'J_n' matches 'Jan', 'Jen', but not 'John'
*/

-- Percent Operator

-- Returns names that begins with 'ade'
SELECT name FROM "Users" WHERE name LIKE 'ade%';

-- Returns names that ends with 'ade'
SELECT name FROM "Users" WHERE name LIKE '%ade';

-- Return names that have 'ade' anywhere in it
SELECT name FROM "Users" WHERE name LIKE '%ade%';


-- Underscore operator

-- 'OWOADE' and 'AYOADE' is a match 😎
SELECT name FROM "Users" WHERE name LIKE '___ADE';


-- Case Sensitivity

-- MySQL: Wildcard operators are case-insensitive, the query below will match both 'owoade' and 'OWOADE'
SELECT name FROM "Users" WHERE name LIKE '___ade';

-- Postgres
-- Case sensitive
SELECT name FROM "Users" WHERE name LIKE '___ade';
-- Case insensitive
SELECT name FROM "Users" WHERE name ILIKE '___ade';


/*
Escaping values in SQL:

Use "\" to escape special characters in patterns.
Example: WHERE name LIKE '100\%%' ESCAPE '\'
→ matches the literal string "100%"

You can also escape values like ', ", `, \ e.t.c
*/

-- This matches paragraphs that contains 100% in them
SELECT * as article from "Articles" WHERE  article.paragraph LIKE '%100\%%';





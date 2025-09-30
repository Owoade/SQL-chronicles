/*
    PROBLEM STATEMENT
    Generate a sales performance report that shows:
      - Each salesperson’s revenue for every month
      - Each salesperson’s total revenue across all months
      - The grand total revenue for the entire sales team
    The report should allow each salesperson to see both their
    monthly performance and their overall contribution.
*/

-- Mysql
SELECT employee, sum(revenue) from sales GROUP BY employee, month WITH ROLLUP;

-- Output
/*
 employee | month | total_revenue
----------+-------+---------------
 Ada      | Feb   | 2500
 Ada      | Jan   | 2000
 Ada      | Mar   | 3000
 Ada      |       | 7500
 Bola     | Feb   | 1800
 Bola     | Jan   | 1500
 Bola     | Mar   | 2200
 Bola     |       | 5500
 Femi     | Jan   | 2000
 Femi     |       | 2000
          |       | 15000
*/
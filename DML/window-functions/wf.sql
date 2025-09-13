SELECT 
    *,
    DENSE_RANK() OVER (PARTITION BY employee ORDER BY revenue DESC) employee_rank_for_each_month
FROM sales

/*
id   employee   month   revenue   employee_rank_for_each_month
--------------------------------------------------------------
2    Ada        Feb     2500      1
5    Bola       Feb     1800      2
7    Femi       Jan     2000      1
1    Ada        Jan     2000      1
4    Bola       Jan     1500      2
3    Ada        Mar     3000      1
6    Bola       Mar     2200      2
*/

/*
 * Other functions include:
 *
 * ROW_NUMBER()  → assigns a unique sequential integer to each row 
 *                 (1, 2, 3, … no matter if values are tied).
 *
 * RANK()        → assigns a rank to each row, but if there are ties,
 *                 the next rank value is skipped.
 *                 e.g., if two rows tie for rank 1, the next row will be rank 3.
 *                 (Unlike DENSE_RANK, which would assign the next row rank 2).
 */

SELECT 
    *,
    SUM(revenue) OVER (PARTITION BY month ORDER BY revenue ) running_total
FROM sales;

/*
----------------------------------------------------------
id   employee   month   revenue   running_total
----------------------------------------------------------
5    Bola       Feb     1800      1800
2    Ada        Feb     2500      4300
4    Bola       Jan     1500      1500
1    Ada        Jan     2000      5500 ❌ 
7    Femi       Jan     2000      5500 
6    Bola       Mar     2200      2200 
3    Ada        Mar     3000      5200

⚠️ Explanation of the RANGE problem:
By default, MySQL (and some other SQL engines postgres included) interpret 
`ORDER BY` inside a window function as `RANGE BETWEEN 
UNBOUNDED PRECEDING AND CURRENT ROW`.  

This means:
- All rows with the same ORDER BY value are treated as a group.  
- When revenue = 2000 (Ada + Femi in Jan), MySQL includes BOTH 
  rows in the calculation at once.  

So instead of adding 2000 once after 1500 (→ 3500), 
it jumps straight to including both 2000s, giving 1500 + 2000 + 2000 = 5500.  

✅ Fix: Use `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` 
to force true row-by-row accumulation (a real running total).
*/


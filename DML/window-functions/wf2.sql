/*
LAG(column, offset, default)
→ Looks backwards at a previous row’s value within the window.
   - column:   the column to fetch
   - offset:   how many rows back to look (default = 1)
   - default:  value to return if there is no such row

LEAD(column, offset, default)
→ Looks forward at the next row’s value within the window.
   - column:   the column to fetch
   - offset:   how many rows ahead to look (default = 1)
   - default:  value to return if there is no such row
*/

SELECT 
    *,
    LEAD(revenue) next_revenue,
    LAG(revenue)  prev_revenue
FROM sales;

/*
id   employee   month   revenue   prev_revenue   next_revenue
--------------------------------------------------------------
1    Ada        Jan     2000      NULL           2500
2    Ada        Feb     2500      2000           3000
3    Ada        Mar     3000      2500           NULL
4    Bola       Jan     1500      NULL           1800
5    Bola       Feb     1800      1500           2200
6    Bola       Mar     2200      1800           NULL
7    Femi       Jan     2000      NULL           NULL
*/
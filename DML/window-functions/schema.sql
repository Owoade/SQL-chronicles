-- Postgres
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,       -- unique identifier
    employee VARCHAR(50) NOT NULL, -- employee name
    month VARCHAR(10) NOT NULL,    -- month (could also use DATE or INT for order)
    revenue INT NOT NULL           -- revenue for that month
);
/*
Sample Data
id   employee   month   revenue
--------------------------------
1    Ada        Jan     2000
2    Ada        Feb     2500
3    Ada        Mar     3000
4    Bola       Jan     1500
5    Bola       Feb     1800
6    Bola       Mar     2200
7    Femi       Jan     2000
*/
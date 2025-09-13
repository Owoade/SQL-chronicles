-- Postgres
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,       -- unique identifier
    employee VARCHAR(50) NOT NULL, -- employee name
    month VARCHAR(10) NOT NULL,    -- month (could also use DATE or INT for order)
    revenue INT NOT NULL           -- revenue for that month
);
-- Performance Ranking Report: Displays each staff member's performance ranking 
-- both organization-wide and within their department, showing their relative 
-- position compared to total headcount (e.g., "5 / 44" means 5th best out of 44).
SELECT 
	*,
	FORMAT(
		'%s / %s',
		ROW_NUMBER() OVER(ORDER BY performance_rating DESC),
		COUNT(*) OVER ()
	) org_rank,
	FORMAT(
		'%s / %s',
		ROW_NUMBER() OVER(PARTITION BY department ORDER BY performance_rating DESC),
		COUNT(*) OVER (PARTITION BY department)
	) dept_rank
FROM staff
ORDER BY name;

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    performance_rating NUMERIC(3,1) CHECK (performance_rating BETWEEN 1.0 AND 5.0),
    salary NUMERIC(10,2)
);
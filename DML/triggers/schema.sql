-- MySQL
CREATE TABLE employee  (
	id int AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(10) not null,
	salary NUMERIC(10, 2) not null
);

CREATE TABLE employee_salary_log (
	id int AUTO_INCREMENT PRIMARY KEY,
	emp_id int not null,
	salary NUMERIC(10, 2) not null,
	created_at timestamp default now()
);
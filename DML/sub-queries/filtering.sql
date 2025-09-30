-- IN Operator
SELECT * FROM employee e WHERE e.id IN (
    SELECT employee_id from sales WHERE amount > 1000000
);

-- ANY Operator
SELECT * FROM junior_employees je WHERE je.performance > ANY (
    SELECT performance FROM senior_employees
);

-- ALL Operator
SELECT * FROM products p WHERE p.rating >= ALL (
    SELECT rating FROM regulators
);

-- EXISTS Operator
SELECT * FROM student as s  WHERE EXISTS (
    SELECT 1 FROM examination_malpratice_cases ms WHERE s.id IN ms.students_involved
);
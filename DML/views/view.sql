CREATE VIEW user_login_details AS SELECT email, password from users;
-- Using view
SELECT * FROM user_login_details where email = 'owoadeanu@yahoo.com' AND password = '🌚';

-- Using views to hide complexity behind complex joins
CREATE VIEW student_results AS 
SELECT 
s.name AS student_name,
d.dept_name AS department,
c.course_name,
c.score,
CASE 
    WHEN c.score >= 90 THEN 'A'
    WHEN c.score >= 75 THEN 'B'
    WHEN c.score >= 50 THEN 'C'
    ELSE 'F'
END AS grade
FROM students s
INNER JOIN departments d 
    ON s.department_id = d.id
LEFT JOIN courses c 
    ON s.id = c.student_id;
-- Using view
SELECT * FROM student_results;

/*
    Creatting view WITH CHECK OPTION
    The WITH CHECK OPTION ensures that any INSERT or UPDATE 
    made through this view must satisfy the condition (score > 50). 
    It prevents adding or modifying rows that wouldn’t appear in the view.
*/
CREATE VIEW qualified_aspirants AS SELECT * from aspirants WHERE score > 50 WITH CHECK OPTION;
-- ❌ Won't insert because the check constraint 
INSERT into qualified_aspirants (name, email, department, score) VALUES ('Owoade Anu', 'owoadeanu@yahoo.com', 'Physiology', 20) 
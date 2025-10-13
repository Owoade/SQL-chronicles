CREATE TRIGGER log_employee_salary_changes
AFTER UPDATE ON employee FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN 
        INSERT INTO employee_salary_log (emp_id, salary) VALUES (OLD.id, OLD.salary);
    END IF
END;
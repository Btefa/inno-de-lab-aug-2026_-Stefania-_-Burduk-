--part1
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    p_employee_id INT,
    p_salary DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    v_bonus DECIMAL(10, 2);
BEGIN
    v_bonus := p_salary * 0.10;
    RETURN v_bonus;
END;
$$ LANGUAGE plpgsql;

--part2
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CalculateAnnualBonus(EmployeeID) AS AnnualBonus
FROM Employees;

--part3
CREATE OR REPLACE VIEW IT_Department_View AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT';

--part4

SELECT * FROM IT_Department_View;

--part1
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR';

--test1
--SELECT FirstName, LastName, Department, Salary FROM Employees WHERE Department = 'HR';

--part2
UPDATE Employees
SET Department = 'SeniorIT'
WHERE Salary >= 70000.00;

--part3
DELETE FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeProjects ep
    WHERE ep.EmployeeID = e.EmployeeID
);
--test2
--SELECT * FROM Employees;

--part4
BEGIN;

WITH new_proj AS (
    INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate)
    VALUES ('Monthly Update', 70000.00, '2023-08-01', '2023-08-31')
    RETURNING ProjectID
)
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
SELECT e.EmployeeID, np.ProjectID, e.Hours
FROM (VALUES
    (1, 140),   -- Alice Smith
    (5, 180)    -- Eve Davis
) AS e(EmployeeID, Hours)
CROSS JOIN new_proj np;

COMMIT;

-- test3
SELECT p.ProjectName, e.FirstName, e.LastName, ep.HoursWorked
FROM Projects p
JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
JOIN Employees e ON ep.EmployeeID = e.EmployeeID
WHERE p.ProjectName = 'Monthly Update';


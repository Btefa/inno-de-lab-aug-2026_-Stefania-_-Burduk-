CREATE TABLE Employees (
EmployeeID SERIAL PRIMARY KEY,
-- SERIAL for auto-incrementing integer
IDs in PostgreSQL
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Department VARCHAR(50),
Salary DECIMAL(10, 2)
);
CREATE TABLE Projects (
ProjectID SERIAL PRIMARY KEY,
-- SERIAL for auto-incrementing integer
IDs
ProjectName VARCHAR(100) NOT NULL,
Budget DECIMAL(12, 2),
StartDate DATE,
EndDate DATE
);
CREATE TABLE EmployeeProjects (
EmployeeID INT,
ProjectID INT,
HoursWorked INT,
PRIMARY KEY (EmployeeID, ProjectID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
INSERT INTO Employees (FirstName, LastName, Department, Salary) VALUES
('Alice','Smith','HR', 60000.00),
('Bob','Johnson','IT', 75000.00),
('Charlie','Brown','Finance', 62000.00),
('Diana','Prince','IT', 80000.00),
('Eve','Davis','HR', 58000.00);
INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate) VALUES
('Website Redesign', 150000.00,'2023-01-15','2023-06-30'),
('Mobile App Development', 200000.00,'2023-03-01','2023-10-31'),
('Internal Tools Upgrade', 80000.00,'2023-05-10','2023-09-15');
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(2, 1, 160),
-- Bob Johnson (ID 2) on Website Redesign (ID 1)
(4, 1, 120),
-- Diana Prince (ID 4) on Website Redesign (ID 1)
(2, 2, 200),
-- Bob Johnson (ID 2) on Mobile App Development (ID 2)
(1, 3, 80),
-- Alice Smith (ID 1) on Internal Tools Upgrade (ID 3)
(3, 3, 100); -- Charlie Brown (ID 3) on Internal Tools Upgrade (ID 3)

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


CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    -- SERIAL for auto-incrementing integer IDs in PostgreSQL
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Projects (
    ProjectID SERIAL PRIMARY KEY,
    -- SERIAL for auto-incrementing integer IDs
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
('Alice', 'Smith', 'HR', 60000.00),
('Bob', 'Johnson', 'IT', 75000.00),
('Charlie', 'Brown', 'Finance', 62000.00),
('Diana', 'Prince', 'IT', 80000.00),
('Eve', 'Davis', 'HR', 58000.00);

INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate) VALUES
('Website Redesign', 150000.00, '2023-01-15', '2023-06-30'),
('Mobile App Development', 200000.00, '2023-03-01', '2023-10-31'),
('Internal Tools Upgrade', 80000.00, '2023-05-10', '2023-09-15');

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(2, 1, 160), -- Bob Johnson on Website Redesign
(4, 1, 120), -- Diana Prince on Website Redesign
(2, 2, 200), -- Bob Johnson on Mobile App Development
(1, 3, 80),  -- Alice Smith on Internal Tools Upgrade
(3, 3, 100); -- Charlie Brown on Internal Tools Upgrade

SELECT * FROM Employees;
SELECT * FROM EmployeeProjects;
SELECT * FROM Projects;

--part1
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    p_employee_id INTEGER
)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    v_salary DECIMAL(10, 2);
    v_bonus DECIMAL(10, 2);
BEGIN
    SELECT Salary INTO v_salary
    FROM Employees
    WHERE EmployeeID = p_employee_id;

    IF v_salary IS NULL THEN
        RETURN NULL;
    END IF;

    v_bonus := v_salary * 0.10;
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

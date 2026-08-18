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

-- USER admin PASSWORD admin123
--part1
CREATE USER hr_user WITH PASSWORD 'Innowise_299';

--part2
GRANT SELECT ON TABLE Employees TO hr_user;

--part4
GRANT INSERT, UPDATE ON TABLE Employees TO hr_user;

SELECT current_user;
SELECT current_database();

--part3, test1
SELECT * FROM Employees;

--test2
INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES ('Test', 'User', 'IT', 100000.00);

--part4
GRANT INSERT, UPDATE ON TABLE Employees TO hr_user;

--part5, test3
INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES ('Test', 'User', 'IT', 100000.00);

UPDATE Employees 
SET Salary = 60000.00 
WHERE FirstName = 'Test' AND LastName = 'User';
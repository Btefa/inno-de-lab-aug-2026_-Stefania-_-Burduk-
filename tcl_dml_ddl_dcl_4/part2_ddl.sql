--part1
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50)
);

SELECT * FROM Departments;

--part2
ALTER TABLE Employees 
ADD COLUMN Email VARCHAR(100);

--part3
UPDATE Employees SET Email = 'alice_smith1@company.com'       WHERE EmployeeID = 1;
UPDATE Employees SET Email = 'bob_johnson2@company.com'       WHERE EmployeeID = 2;
UPDATE Employees SET Email = 'charlie_brown3@company.com'     WHERE EmployeeID = 3;
UPDATE Employees SET Email = 'diana_prince4@company.com'      WHERE EmployeeID = 4;
UPDATE Employees SET Email = 'eve_davis5@company.com'         WHERE EmployeeID = 5;

--part4
ALTER TABLE Employees
ADD CONSTRAINT UQ_Email UNIQUE (Email);

SELECT * FROM Employees;

UPDATE Employees
SET EmployeeID = 5
WHERE FirstName = 'Eve' AND LastName = 'Davis';

INSERT INTO Employees (FirstName, LastName, Department, Salary) VALUES
('Eve', 'Davis', 'HR', 58000.00);

--part5
ALTER TABLE Departments
RENAME COLUMN Location TO OfficeLocation;
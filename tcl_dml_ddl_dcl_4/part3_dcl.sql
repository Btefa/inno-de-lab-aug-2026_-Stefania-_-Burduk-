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
GRANT USAGE, SELECT ON SEQUENCE Employees_EmployeeID_seq TO hr_user;

--part5, test3
INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES ('Test', 'User', 'IT', 100000.00);

UPDATE Employees 
SET Salary = 60000.00 
WHERE FirstName = 'Test' AND LastName = 'User';
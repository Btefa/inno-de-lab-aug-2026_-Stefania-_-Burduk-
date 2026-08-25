--part1
INSERT INTO Employees (FirstName, LastName, Department, Salary) VALUES
('Laura', 'Rossi', 'Marketing', 55000.00),
('John', 'Preston', 'Sales', 58000.00);

--part2
SELECT * FROM Employees;

--part3
SELECT FirstName, LastName
FROM Employees
WHERE Department = 'IT';

--part4
UPDATE Employees
SET Salary = 65000.00
WHERE FirstName = 'Alice' AND LastName = 'Smith';

--part5
DELETE FROM Employees
WHERE FirstName = 'Eve' AND LastName = 'Davis';

--part6
SELECT * FROM Employees;
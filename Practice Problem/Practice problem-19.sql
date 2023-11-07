/*
Write a SQL query for cumulative sum of salary of each employee from Jan to July. (Column name – Emp_id, Month, Salary)
*/

-- Create an EmployeeSalary table
CREATE TABLE EmployeeSalary (
    Emp_id INT,
    Month DATE,
    Salary DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO EmployeeSalary (Emp_id, Month, Salary)
VALUES
    (1, '2023-01-01', 5000.00),
    (1, '2023-02-01', 6000.00),
    (1, '2023-03-01', 5500.00),
    (1, '2023-04-01', 7000.00),
    (1, '2023-05-01', 7500.00),
    (1, '2023-06-01', 8000.00),
    (1, '2023-07-01', 8500.00),
    (2, '2023-01-01', 4500.00),
    (2, '2023-02-01', 5200.00),
    (2, '2023-03-01', 4800.00),
    (2, '2023-04-01', 6000.00),
    (2, '2023-05-01', 6500.00),
    (2, '2023-06-01', 7000.00),
    (2, '2023-07-01', 7500.00);


select * from EmployeeSalary

select *,
sum(Salary) over (partition by Emp_id order by Salary) 
from EmployeeSalary


/*
Write a SQL query for cumulative sum of salary of each employee from Jan to July. (Column name – Emp_id, Month, Salary).
*/

-- Create the table
CREATE TABLE SalaryData (
    Emp_id INT,
    Month VARCHAR(10),
    Salary DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO SalaryData (Emp_id, Month, Salary) VALUES
    (1, 'Jan', 5000.00),
    (1, 'Feb', 5500.00),
    (1, 'Mar', 6000.00),
    (1, 'Apr', 6200.00),
    (1, 'May', 6500.00),
    (1, 'Jun', 7000.00),
    (1, 'Jul', 7200.00),
    (2, 'Jan', 4500.00),
    (2, 'Feb', 4800.00),
    (2, 'Mar', 5000.00);


with Month_Number as
(
select *, 
case 
	when [Month] = 'Jan' then 1
	when [Month] = 'Feb' then 2
	when [Month] = 'Mar' then 3
	when [Month] = 'Apr' then 4
	when [Month] = 'May' then 5
	when [Month] = 'Jun' then 6
	when [Month] = 'Jul' then 7
else 0
end as Month_Number
from SalaryData
)
select *, 
sum(Salary) over(partition by Emp_id order by Month_Number) as Running_Total
from Month_Number
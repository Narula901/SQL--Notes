/*

Write a sql query to get emp id and department for each department who recently joined the organization and still in working

*/

select * from employee

-- Create the employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_join DATE,
    date_of_exit DATE,
    department VARCHAR(50)
);

-- Insert sample data
INSERT INTO employee (emp_id, first_name, last_name, date_of_join, date_of_exit, department)
VALUES
    (1, 'John', 'Doe', '2020-01-15', NULL, 'HR'),
    (2, 'Jane', 'Smith', '2019-05-20', '2022-07-30', 'Marketing'),
    (3, 'Mike', 'Johnson', '2021-03-10', NULL, 'Engineering'),
    (4, 'Emily', 'Brown', '2022-08-05', NULL, 'Sales'),
    (5, 'David', 'Lee', '2020-06-25', '2023-01-12', 'Finance'),
	(6, 'Karan', 'Narula','2022-01-10', NULL, 'HR'),
	(7, 'Nitin', 'Gulati', '2022-04-12', NULL, 'Engineering'),
	(8, 'Hitesh', 'Bhardwaj', '2023-08-05', NULL, 'Sales');


-----1st method 
select * , DENSE_RANK() over(partition by department order by date_of_join desc) rnk
from employee
where date_of_exit is null
order by department 

select * from employee


-- 2nd method
go
select emp_id, date_of_join, department
from employee
where date_of_exit is null
group by emp_id, date_of_join, department
order by department, date_of_join desc


select *
from employee

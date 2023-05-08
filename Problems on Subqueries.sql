/*Subqueries - A subquery is a query that is nested within another query.
Inner is Executed First and only once. After that outer query is executed from the result of Inner Query
In this way, Outer Query is Dependent on Inner Query*/

--For all the Problems discussed below, "employees" table is used  


--Question 1. Write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary?
SELECT first_name, last_name, employee_id, salary  
FROM employees  
WHERE manager_id = 
(SELECT employee_id  
FROM employees  
WHERE first_name = 'Payam' 
)


--Question 2. Write a SQL query to find those employees whose salary falls within the range of the smallest salary and 2500?
Select *
from employees 
where salary between (select MIN(salary) from employees) and 2500


--Question 3. Write a SQL query to find those employees who get second-highest salary?
SELECT *, MAX(salary) as Second_Highest_Salary
FROM employees  
where salary < (select MAX(salary) from employees)

--Question 4. Write a SQL query to find those employees who work in the same department as ‘Clara’. Exclude all those records where first name is ‘Clara’?
SELECT first_name, last_name, hire_date  
FROM employees  
WHERE department_id = (SELECT department_id  FROM employees  WHERE first_name = 'Clara')  


--Question 5. Write a SQL query to find those employees who work in a department where the employee’s first name contains the letter 'T'?
SELECT employee_id, first_name, last_name  
FROM employees  
WHERE department_id IN (SELECT department_id FROM employees WHERE first_name LIKE '%T%' )










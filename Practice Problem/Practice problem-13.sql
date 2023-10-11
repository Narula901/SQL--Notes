/*
The question: Write a query to obtain a list of departments with an average salary lower than the overall average salary of the company 
*/

with cte as 
(
select *, 
avg(salary) over(partition by department_id order by department_id) average_depatment,
avg(salary) over() Total_average
from worker
)
select department_id, average_depatment, Total_average from cte
where average_depatment <= Total_average
group by  department_id, average_depatment, Total_average





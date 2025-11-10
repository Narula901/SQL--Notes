
-- write a query to find the median salary of each company.


with CTE as 
(
select * ,
ROW_NUMBER() over (partition by company order by salary) rn,
count(1) over (partition by company order by company) cn
from employee_median
)
select company, 1.0*avg(salary) as median
from CTE
where rn >= (cn*1.0)/2
and rn <= (cn*1.0)/2 + 1
group by company
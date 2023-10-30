
/*
Problem Statement :-

Write a SQL query to find 3rd highest salary employee in each department, 
In case there are less than 3 emp in a dept then return emp 
with lowest salary in that Dept.

*/
select * from  Company

with CTE as
(
select *,
DENSE_RANK() over(partition by dep_id order by salary desc) as rn,
count(dep_id) over(partition by dep_id) as [count],
min(salary) over(partition by dep_id) as Minimum_Salary
from Company
)
select emp_id, emp_name 
from CTE
where ([count]>=3 and rn = 3) 
             or
([count]<3 and salary = Minimum_Salary)




Write a SQL query to find 3rd highest salary employee in each department, 
In case there are less than 3 emp in a dept then return emp 
with lowest salary in that Dept.
select * from  Company
go

with CTE as
(
select *, 
DENSE_RANK()over (partition by dep_id order by salary) as rn,
count(dep_id) over(partition by dep_id ) as cnt,
min(salary) over (partition by dep_id) as [min]
from Company
)
select *
from CTE
where  
(cnt>=3 and rn=3)
or (cnt<3 and [salary] = [min] )
group by emp_id
having 
(cnt>=3 and rn=3)
or (cnt<3 and [salary] = [min] )

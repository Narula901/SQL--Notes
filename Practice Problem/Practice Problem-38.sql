create table brands (
year int,
brand varchar(10),
amount int);

insert into brands values (
2018, 'Apple', 45000),
(2019, 'Apple', 35000),
(2020, 'Apple', 75000),
(2018, 'Samsung', 15000),
(2019, 'Samsung', 20000),
(2020, 'Samsung', 25000),
(2018, 'Nokia', 21000),
(2019, 'Nokia', 17000),
(2020, 'Nokia', 14000);

with CTE as 
(
select *,
case 
when (lead(amount,1,amount) over (partition by brand order by [year])-amount) >=0 then 1
else 0 
end as category
from brands
),
CTE_1 as
(
select *, count(brand) over (partition by brand order by brand) CNT,
sum(category) over (partition by brand order by brand) Plus
from CTE
)
select  * from CTE_1
where CNT = Plus




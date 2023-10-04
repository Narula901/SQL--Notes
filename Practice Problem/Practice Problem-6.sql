


group by CustomerID
where [Month] in (1,2,3,4,5,6)
order by CustomerID, [Month]

with CTE as
(
select *, month(OrderDate) as mo,  year(OrderDate) as y
from [Sales].[Order]
)
select CustomerID, mo , count(1) cnt, count(1) over(partition by CustomerID order by CustomerID) as cnt1
from CTE
where y = 2012
group by  CustomerID, mo

group by CustomerID
having cnt = 3
having  count(distinct(month(OrderDate))) = 3

select from [Sales].[Order]


select *, month(OrderDate) as mo,  year(OrderDate) as y
from [Sales].[Order]



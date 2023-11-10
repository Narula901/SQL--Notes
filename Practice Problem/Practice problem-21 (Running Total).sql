
---Running Total


select * from [Sales].[Order]

-----------Both Queries Give the same Output. However, it is not the right result that we are looking for-------------------------------
select *, sum(OrderTotal) over (order by OrderDate range between unbounded preceding and current row) as Cumulative_Total
from [Sales].[Order]

select *, sum(OrderTotal) over (order by OrderDate) as Cumulative_Total
from [Sales].[Order]
-----------------------------------------------------------------------------------------------------------------------------------------

select OrderDate, OrderTotal, sum(OrderTotal) over (order by OrderDate rows between unbounded preceding and current row) as Cumulative_Total
from [Sales].[Order]

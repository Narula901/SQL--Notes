

select * from [Sales].[Order]

with CTE as
(
select YEAR(OrderDate) as [Year], 
sum(OrderTotal) as Revenue
from [Sales].[Order]
group by  YEAR(OrderDate)
),
CTE_1 as
select [Year], format(Revenue,'C2') as Revenue, 
format(lag(Revenue,1,0) over(order by [Year]), 'C2') PreviousYearRevenue
from CTE

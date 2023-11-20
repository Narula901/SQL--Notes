

select * from [Sales].[Order]

---Analyze the Previous Year Sales
with CTE as
(
select YEAR(OrderDate) as [Year], 
sum(OrderTotal) as Revenue
from [Sales].[Order]
group by  YEAR(OrderDate)
)
select [Year], format(Revenue,'C2') as Revenue, 
format(lag(Revenue,1,0) over(order by [Year]), 'C2') PreviousYearRevenue
from CTE

/* 
Analyzing Year-over-Year Revenue Growth
*/
with CTE as
(
select YEAR(OrderDate) as [Year], 
sum(OrderTotal) as Revenue
from [Sales].[Order]
group by  YEAR(OrderDate)
),
CTE_1 as 
(
select [Year], Revenue, 
lag(Revenue,1) over(order by [Year]) PreviousYearRevenue
from CTE
)
select [Year], 
format(Revenue,'C2')Revenue,
format(lag(Revenue,1) over(order by [Year]), 'C2') PreviousYearRevenue,
format(((Revenue - PreviousYearRevenue)/(PreviousYearRevenue)), 'P2') as YOY_Growth
from
CTE_1

--- Another Method(Short-One)
with CTE as
(
select YEAR(OrderDate) as [Year], 
sum(OrderTotal) as Revenue
from [Sales].[Order]
group by  YEAR(OrderDate)
)
Select [Year], format(Revenue,'C2') as Revenue,
format(lag(Revenue,1,Revenue) over(order by [Year]),'C2') as PreviousYearRevenue,
format((Revenue - lag(Revenue,1,Revenue) over(order by [Year]))/(lag(Revenue,1, Revenue) over(order by [Year])), 'P2') as YOY_Growth
from CTE



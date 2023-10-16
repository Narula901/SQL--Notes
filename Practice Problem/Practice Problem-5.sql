/*
 write a SQL Query to shows the monthly order totals for each customer up to the 11th month of the year, sorted by CustomerID and OrderDate?"
*/

with CTE as
(
select CustomerID, OrderDate, sum(OrderTotal) as Amount, MONTH(OrderDate) as [Month] from [Sales].[Order]
group by  CustomerID, OrderDate
)

select  *
from CTE
where [Month] <=11
order by CustomerID, OrderDate


select * from  [Sales].[Order]
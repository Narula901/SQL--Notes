SELECT TOP 2 * FROM [Sales].[Customer]
select TOP 2 * from [Sales].[OrderItem]
select top 2 * from [Sales].[Order]

with CTE_1 as
(
select C.FirstName, C.LastName, format(sum(O.OrderTotal), 'C2') Sales
from [Sales].[Customer] C
inner join [Sales].[Order] O
on C.CustomerID = O.CustomerID
group by C.FirstName, C.LastName
)
select FirstName, LastName, Sales,
NTILE(100) over(order by Sales Desc)
from CTE_1

with CTE_1 as
(
select C.FirstName, C.LastName, format(sum(O.OrderTotal), 'C2') Sales
from [Sales].[Customer] C
inner join [Sales].[Order] O
on C.CustomerID = O.CustomerID
group by C.FirstName, C.LastName
)
select Top 10 FirstName, LastName, Sales
from CTE_1
order by  Sales Desc
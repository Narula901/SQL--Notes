
/*
LAG(expression [,offset[,default_value]]) OVER(ORDER BY columns)
LEAD(expression [,offset[,default_value]]) OVER(ORDER BY columns)
*/

select * from [Sales].[Order]

select OrderID, CustomerID ,
lag(OrderID) over (order by OrderID) as lag_1,
lag(OrderID) over (partition by CustomerID order by OrderID) as lag_2
from [Sales].[Order]
order by OrderID



select OrderID, CustomerID ,
lag(OrderID) over (partition by CustomerID order by OrderID) as lag_1,
lead(OrderID) over (partition by CustomerID order by OrderID asc) as lead_1
from [Sales].[Order]
order by CustomerID

SELECT OrderID, CustomerID,
       LEAD(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS lead_1
FROM [Sales].[Order]
ORDER BY OrderID;

SELECT OrderID, CustomerID,
       LEAD(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS lead_1
FROM [Sales].[Order]
ORDER BY CustomerID






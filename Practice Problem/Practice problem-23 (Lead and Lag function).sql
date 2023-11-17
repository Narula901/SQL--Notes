
/*
order by clause is important in over()
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
lag(OrderID) over (partition by CustomerID order by OrderID) as Previous_Order,
lead(OrderID) over (partition by CustomerID order by OrderID asc) as Next_Order
from [Sales].[Order]
order by CustomerID

----this wont give an accurate result, end of orderid gives aggregate value but it would have been a null value	
SELECT OrderID, CustomerID,
       LEAD(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS lead_1
FROM [Sales].[Order]
ORDER BY OrderID;

----Use Offset value
SELECT OrderID, CustomerID,
       LEAD(OrderID,2) OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS lead_1
FROM [Sales].[Order]
ORDER BY CustomerID

----Use offset with default value
SELECT OrderID, CustomerID,
       LEAD(OrderID,2,-1) OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS lead_1
FROM [Sales].[Order]
ORDER BY CustomerID






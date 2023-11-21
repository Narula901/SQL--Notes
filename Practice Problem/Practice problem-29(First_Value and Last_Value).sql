
--- First_Value and Last_Value function
select * from [Sales].[Order]
select * from [Sales].[Customer]

---agianst Customer Id, Order ID is arranged properly, as in this case, in ascending order
select C.FirstName, C.LastName, O.OrderID, C.CustomerID,
FIRST_VALUE(O.OrderID) over (partition by C.CustomerID order by O.OrderID range between unbounded Preceding and Unbounded following) First_Order,
Last_VALUE(O.OrderID) over (partition by C.CustomerID order by O.OrderID range between unbounded Preceding and Unbounded following) Last_Order
from [Sales].[Customer] C
inner Join [Sales].[Order] O
on C.CustomerID = O.CustomerID
where C.CustomerID in (1,2,3)
order by C.CustomerID

---agianst customer id orderId is randomly arranged as 1 customer Id is repeating multiple times
select C.FirstName, C.LastName, O.OrderID, C.CustomerID,
FIRST_VALUE(O.OrderID) over (partition by C.CustomerID order by C.CustomerID range between unbounded Preceding and Unbounded following) First_Order,
Last_VALUE(O.OrderID) over (partition by C.CustomerID order by C.CustomerID) Last_Order
from [Sales].[Customer] C
inner Join [Sales].[Order] O
on C.CustomerID = O.CustomerID
where C.CustomerID in (1,2,3)
order by C.CustomerID

---Create Partition on the basis of Customer ID and OrderID
select C.FirstName, C.LastName, O.OrderID, C.CustomerID,
FIRST_VALUE(O.OrderID) over (partition by C.CustomerID, O.OrderID order by O.OrderID range between unbounded Preceding and Unbounded following) First_Order,
Last_VALUE(O.OrderID) over (partition by C.CustomerID, O.OrderID order by O.OrderID range between unbounded Preceding and Unbounded following) Last_Order
from [Sales].[Customer] C
inner Join [Sales].[Order] O
on C.CustomerID = O.CustomerID
where C.CustomerID in (1,2,3)
order by C.CustomerID
---As we have seen due to above Partition it gives the different Order ID for each row




	
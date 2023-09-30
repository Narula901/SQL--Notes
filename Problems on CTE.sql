/*
The Northwind database represents a fictional wholesale trading company that sells various products to customers.

Here's an overview of the tables included in the Northwind data set:

"Customers": Contains information about the company's customers, including their names, addresses, contact details, and other relevant information.

"Employees": Stores data about the employees working for the company, such as their names, titles, birth dates, hire dates, and other related details.

"Orders": Contains information about the orders placed by customers, including order IDs, order dates, customer IDs, employee IDs, and other relevant details.

"OrderDetails": Stores details about individual items within each order, such as product IDs, quantities, unit prices, discounts, and other related information.

"Products": Contains information about the products available for sale, including product names, suppliers, categories, unit prices, and other relevant details.

"Suppliers": Stores data about the suppliers who provide the products to the company, including supplier names, addresses, contact details, and other related information.

"Categories": Contains details about the categories to which the products belong, such as category names and descriptions.

"Shippers": Stores information about the shipping companies used by the company, including shipper names, phone numbers, and other related details.

"EmployeesTerritories": Represents the relationship between employees and territories, linking each employee to the territories they are responsible for.

"Region": Contains information about different regions, such as region names.

"Territories": Stores details about the territories covered by the company, including territory names and region IDs.
*/

-- Ques-1 : 
/*
We want to send all of our high-value customers a special VIP gift.
We're defining high-value customers as those who've made at least 1
order with a total value (not including the discount) equal to $10,000 or
more. We only want to consider orders made in the year 2016.
*/

--Sol : -- Here Three Tables are used: Customers, Orders, OrderDetails

Select C.CustomerID,C.CompanyName,O.OrderID,
SUM(OD.Quantity * OD.UnitPrice) as TotalOrderAmount
From [dbo].[Customers] C
Join [dbo].[Orders] O
on O.CustomerID = C.CustomerID
Join [dbo].[Order Details] OD
on O.OrderID = OD.OrderID
Where
OrderDate >= '1997-01-01'
and OrderDate < '1998-01-01'
Group by
C.CustomerID,
C.CompanyName,
O.Orderid
Having Sum(Quantity * UnitPrice) > 10000
Order by TotalOrderAmount DESC

--Ques-2 : 
/*
Change the above query to use the discount when calculating high-value
customers. Order by the total amount which includes the discount.
*/

--Sol : Here Three Tables are used: Customers, Orders, OrderDetails

Select C.CustomerID,C.CompanyName,O.OrderID,
SUM(OD.Quantity * OD.UnitPrice*(1- OD.Discount)) as TotalOrderAmount
From [dbo].[Customers] C
Join [dbo].[Orders] O
on O.CustomerID = C.CustomerID
Join [dbo].[Order Details] OD
on O.OrderID = OD.OrderID
Where
OrderDate >= '1997-01-01'
and OrderDate < '1998-01-01'
Group by
C.CustomerID,
C.CompanyName,
O.Orderid
Having SUM(OD.Quantity * OD.UnitPrice*(1- OD.Discount)) > 10000
Order by TotalOrderAmount DESC

-- Ques-3 :
/*
At the end of the month, salespeople are likely to try much harder to get
orders, to meet their month-end quotas. Show all orders made on the last
day of the month. Order by EmployeeID and OrderID
*/

-- Sol : only Orders Table is Used

	with Last_Day_Of_Month as
	(
	 Select EmployeeID, OrderID, OrderDate, MONTH(OrderDate) OrderMonth, YEAR(OrderDate) OrderYear,
	 LAST_VALUE(OrderDate) 
	 over(partition by  MONTH(OrderDate), YEAR(OrderDate) 
	 order by OrderDate range between unbounded preceding and unbounded following) as LDOM
	 from [dbo].[Orders]
	)
	select EmployeeID, OrderID, OrderDate 
	from Last_Day_Of_Month 
	where OrderDate = LDOM
	order by EmployeeID, OrderID


-- Ques-4 :
/*
The Northwind mobile app developers are testing an app that customers
will use to show orders. In order to make sure that even the largest
orders will show up correctly on the app, they'd like some samples of
orders that have lots of individual line items. Show the 10 orders with
the most line items, in order of total line items.
*/

-- Sol : Orders and OrderDetails Table are Used

	select top 10 OD.OrderID, count(OD.OrderID) as Total_Order_Details
	from [dbo].[Order Details] OD
	inner join Orders O
	on OD.OrderID = O.OrderID
	group by OD.OrderID
	order by count(OD.OrderID) desc


-- Ques-5 :
/*
There might be the chance that ties in the number of order details for the top 10 orders,
If yes, which orders are tied and how many order details do they have
*/

-- Sol : Orders and OrderDetails Table are Used

	select top 10 with ties OD.OrderID , count(OD.OrderID) as Total_Order_Details
	from [dbo].[Order Details] OD
	inner join Orders O
	on OD.OrderID = O.OrderID
	group by OD.OrderID
	order by count(OD.OrderID) desc

-- Ques-6 :
/*
The Northwind mobile app developers would now like to just get a
random assortment of orders for beta testing on their app. Show a
random set of 2% of all orders.
*/

-- Sol : Orders Table are Used
select top 2 percent OrderID
from Orders
order by NEWID()

-- Ques-7 :
/*
Janet Leverling, one of the salespeople, has come to you with a request.
She thinks that she accidentally double-entered a line item on an order,
with a different ProductID, but the same quantity. She remembers that
the quantity was 60 or more. Show all the OrderIDs with line items that
match this, in order of OrderID
*/

-- Sol : Order Details Table are Used

		select OrderID, Quantity
		from [Order Details]
		where Quantity >= 60
		group by OrderID, Quantity
		having count(OrderID) >1

-- Ques-8 :
/*
Based on the previous question, we now want to show details of the
order, for orders that match the above criteria
*/

-- Sol : Order Details Table are Used

		with UniqueOrderDetails
		as
		(
			select OrderID, Quantity
			from [Order Details]
			where Quantity >= 60
			group by OrderID, Quantity
			having count(OrderID) >1
		)
		select *
		from [Order Details] OD
		inner join UniqueOrderDetails UOD
		on OD.OrderID = UOD.OrderID

-- Ques-9 :
/*
Some customers are complaining about their orders arriving late. Which
orders are late
*/

-- Sol : Orders Table are Used

		select OrderID, convert(Date,OrderDate) as OrderDate, 
		convert(Date,RequiredDate) as RequiredDate, 
		convert(Date,ShippedDate) as ShippedDate
		from Orders
		where ShippedDate >= RequiredDate

-- Ques-10 :
/*
Some salespeople have more orders arriving late than others. Maybe
they're not following up on the order process, and need more training.
Which salespeople have the most orders arriving late?
*/

-- Sol : Orders and Employees Table are Used
with LateOrders as
(
	select EmployeeID, OrderID, convert(Date,OrderDate) as OrderDate, convert(Date,RequiredDate) as RequiredDate, convert(Date,ShippedDate) as ShippedDate
	from Orders
	where ShippedDate >= RequiredDate
)
select E.EmployeeID, E.LastName, count(LO.OrderID) as TotalLateOrders
from Employees E
inner join LateOrders LO
on E.EmployeeID = LO.EmployeeID
group by E.EmployeeID, E.LastName
order by TotalLateOrders desc



















	





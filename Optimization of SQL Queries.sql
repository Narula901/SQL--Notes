

create table #Sales2012
(
SalesOrderID int,
OrderDate date
)

Insert into #Sales2012
(
SalesOrderID,
OrderDate
)

select OrderId, OrderDate     
from [Sales].[Order]
where year(OrderDate) = 2011

/*
select OrderId, OrderDate 
from [Sales].[Order]
where OrderDate >'2010-12-31' 
and OrderDate < '2012-01-01'
group by OrderId, OrderDate 
having count(*)=1
*/

select * from #Sales2012

select count(*) from #Sales2012

select  count(*) from [Sales].[Order]


create table #ProductsSold2011
(
SalesOrderID int,
OrderDate Date,
LineTotal Money,
ProductID int,
ProductName varchar(64),
ProductSubcategoryID int,
ProductSubcategory varchar(64),
ProductCategoryID int,
ProductCategory varchar(64)
)

insert into #ProductsSold2011
(
 SalesOrderID,
 Orderdate,
 LineTotal,
 ProductID
)

select 
A.SalesOrderID,
A.OrderDate,
B.LineTotal,
B.ProductID

from #Sales2012 A
join [Sales].[OrderItem] B
on A.SalesOrderID = B.OrderID


select * from #ProductsSold2011
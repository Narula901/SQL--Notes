-----Optimizing with update part 1 and 2

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
ProductCategoryID int,
ProductCategory varchar(64)
)

DROP TABLE #ProductsSold2011

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

update #ProductsSold2011
set ProductName = B.Name,
ProductcategoryID = B.CategoryID
from #ProductsSold2011 A
join [Production].[Product] B
on A.ProductID = B.ProductID


update #ProductsSold2011
set ProductCategory = B.Name
from #ProductsSold2011 A
join [Production].[Category] B
on A.ProductCategoryID = B.CategoryID


----An Improved EXISTS With UPDATE
create table #Sales
(
OrderID int,
OrderDate date,
LineTotal Money
)

insert into #Sales 
(
OrderID,
OrderDate
)

select 
OrderID,
OrderDate
from [Sales].[Order]

select * from #Sales

update #Sales
set LineTotal = B.LineTotal 
from #Sales A
   join [Sales].[OrderItem] B
   on A.OrderID = B.OrderID
where B.LineTotal>10000

select * from #Sales
where LineTotal is null

select * from #Sales
where LineTotal is not null
order by OrderID

-----Indexes 
--clustered and Non-clustered Indexes
--#Sales2012
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

--Firstly create SalesorderID to Clustered index,
--as it is used while appply the join with #Producttable
Create clustered index Sales2012 on #Sales2012(SalesOrderID)


--#ProductSold2011
create table #ProductsSold2011
(
SalesOrderID int,
itemID int,
OrderDate Date,
LineTotal Money,
ProductID int,
ProductName varchar(64),
ProductCategoryID int,
ProductCategory varchar(64)
)


insert into #ProductsSold2011
(
 SalesOrderID,
 ItemID,
 Orderdate,
 LineTotal,
 ProductID
)

select 
A.SalesOrderID,
B.ItemID,
A.OrderDate,
B.LineTotal,
B.ProductID

from #Sales2012 A
join [Sales].[OrderItem] B
on A.SalesOrderID = B.OrderID

select * from #ProductsSold2011
--check for candidate key (SalesOrderID, itemID)
select SalesOrderID, itemID
from #ProductsSold2011
group by SalesOrderID, itemID
having count(*)>1

--apply indexes on #ProductsSold2011
Create clustered index Product2011 on #ProductsSold2011(SalesOrderID,itemID)

Create nonclustered index ProductID on #ProductsSold2011(ProductID)

Create nonclustered index ProductCategoryID on #ProductsSold2011(ProductCategoryID)







use AdventureWorksDW2019
go

if OBJECT_ID('demoCustomer') is not null begin
	drop Table demoCustomer
end

create table demoCustomer(
CustomerKey int primary key,
FirstName nvarchar(50) not null,
MiddleName nvarchar(50) null,
LastName nvarchar(50) not null
)
select * from demoCustomer 

insert into demoCustomer (CustomerKey, FirstName, MiddleName, LastName) values (1,'Orlando','N.', 'Gee')
insert into demoCustomer (CustomerKey, FirstName, MiddleName, LastName) values (2,'Karan','F.','Narula')
insert into demoCustomer (CustomerKey, FirstName, MiddleName, LastName) values (3,'Hitesh',Null, 'Bhardwaj')
insert into demoCustomer (CustomerKey, FirstName, MiddleName, LastName) values (4,'Harmeet', Null, 'Singh')

------Inserting Multiple Rows with One Statement

------INSERT INTO dbo.demoCustomer (CustomerID, FirstName, MiddleName, LastName) 
------VALUES (12,'Johnny','A.','Capino'),(16,'Christopher','R.','Beck'), (18,'David','J.','Liu'); 


select * from DimCustomer

-------Inserting Rows from Another Table

insert into demoCustomer(CustomerKey, FirstName, MiddleName, LastName)
select CustomerKey, FirstName, MiddleName, LastName
from DimCustomer
where CustomerKey between 11000 and 11005

----- put the data into democustomer with the help of Joining two tables SalesLT.SalesOrderHeader and SalesLT.Customer

/* INSERT INTO dbo.demoCustomer (CustomerID, FirstName, MiddleName, LastName) 
SELECT s.CustomerID, c.FirstName, c.MiddleName, c.LastName 
FROM SalesLT.Customer AS c 
INNER JOIN SalesLT.SalesOrderHeader AS s ON c.CustomerID = s.CustomerID;*/

select * from demoCustomer


-----Creating and Populating a Table in One Statement

 SELECT CustomerKey, FirstName, MiddleName, LastName, 
 FirstName + ISNULL(' ' + MiddleName,'') + ' ' + LastName AS FullName 
INTO demoCustomer2 
FROM DimCustomer

select * from demoCustomer2

select * from demoCustomer

/* USE AdventureWorksLT2008; 
GO 
IF EXISTS (SELECT * FROM sys.objects 
 WHERE object_id = OBJECT_ID(N'[dbo].[demoCustomer]') 
 AND type in (N'U')) 
DROP TABLE dbo.demoCustomer; 
GO 

SELECT CustomerID, FirstName, MiddleName, LastName, 
 FirstName + ISNULL(' ' + MiddleName,'') + ' ' + LastName AS FullName 
INTO dbo.demoCustomer 
FROM SalesLT.Customer; */


------------Delete Queries

----Delete from Single Table 
/*DELETE dbo.demoProduct 
WHERE ProductID > 900; */


-------------Deleting from a Table Using a Join or a Subquery 
/*DELETE d 
FROM dbo.demoSalesOrderDetail AS d 
INNER JOIN dbo.demoSalesOrderHeader AS h ON d.SalesOrderID = h.SalesOrderID 
WHERE h.SalesOrderNumber = 'SO71797' */

/*DELETE FROM dbo.demoSalesOrderDetail 
WHERE ProductID NOT IN 
 (SELECT ProductID FROM dbo.demoProduct WHERE ProductID IS NOT NULL);*/

----------Truncate Query
-----TRUNCATE TABLE dbo.demoSalesOrderHeader




--------------Update Queries

/* 
SELECT CustomerID, NameStyle, Title 
FROM dbo.demoCustomer 
ORDER BY CustomerID; 

UPDATE dbo.demoCustomer 
SET NameStyle = 1; */

/* SELECT CustomerID, NameStyle, Title 
FROM dbo.demoCustomer 
ORDER BY CustomerID; 

UPDATE dbo.demoCustomer 
SET NameStyle = 0 
WHERE Title = 'Ms.'; */



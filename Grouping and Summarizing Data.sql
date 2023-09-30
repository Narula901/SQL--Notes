
------------- Grouping and Summarizing Data

---Aggregate Functions
---Aggregate functions will not operate on Text, NText and Image Columns

use AdventureWorksDW2019
go 
select * from DimCustomer

select count(1) from DimCustomer    --- both are giving the same result
select count(*) from DimCustomer

select * from FactInternetSales

select count(*) as Total_Rows , max(SalesAmount) as Maximum_Sales, min(SalesAmount) as Minimum_Sales, AVG(SalesAmount) as Average_Sales
from FactInternetSales

-----Group By Clause

select * from FactInternetSalesReason

select * from FactFinance
select count(distinct(DepartmentGroupKey)) from FactFinance


----- Grouping on Expresssion
select DepartmentGroupKey, YEAR(Date)as yearly, max(Amount) as Maximum_Amount from FactFinance 
group by DepartmentGroupKey, Date
order by DepartmentGroupKey

select * from FactInternetSales

select count(OrderDateKey) as No_of_order, year(OrderDate) as Year  from FactInternetSales
group by OrderDate

select OrderDateKey, count(OrderDateKey) from FactInternetSales
group by OrderDateKey

select count(*) as Count_of_Order, year(OrderDate) as Year  from FactInternetSales
group by Year(OrderDate)

select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
group by ProductKey
order by Sum(SalesAmount)

----Here instead of writing down the Aggregate function, we can use Name of the Aggregate function while creating that one.
select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
group by ProductKey
order by Total_Sales ---------


select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
group by ProductKey
order by ProductKey


----Where and Having Clause

----Use Having Clause after Group by Clause 
select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
group by ProductKey
having sum(SalesAmount) > 20000

select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
group by ProductKey
having  Sum(SalesAmount) > 20000

-------We cannot use aggregate function with Where Clause
select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
where Sum(SalesAmount) > 20000
group by ProductKey
----- Above Expression gives an Error

----Use Where Clause before Group By 
select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
where ProductKey > 350
group by ProductKey
order by ProductKey

---- Use where and Having Clause together
select ProductKey, Sum(SalesAmount) as Total_Sales from FactInternetSales
where ProductKey > 350
group by ProductKey
having Sum(SalesAmount)>30000
order by ProductKey

/*SELECT CustomerID,SUM(TotalDue) AS TotalPerCustomer 
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID 
HAVING COUNT(*) = 10 AND SUM(TotalDue) > 5000 */ -------- Multiple Conditions with having clause
--------------------------------------------------------------------------------------------------------------------------------------
----Distinct with Aggregate Functions

/* SELECT COUNT(*) AS CountOfRows, 
 COUNT(SalesPersonID) AS CountOfSalesPeople, 
 COUNT(DISTINCT SalesPersonID) AS CountOfUniqueSalesPeople 
FROM Sales.SalesOrderHeader; */

/* SELECT SUM(TotalDue) AS TotalOfAllOrders, 
 SUM(Distinct TotalDue) AS TotalOfDistinctTotalDue 
FROM Sales.SalesOrderHeader; */
-------------------------------------------------------------------------------------------------------------------------------------------
-------Aggregate Queries with More Than One Table

/* 
select c.customerid, c.AccountNumber, Count(*) as count_of_orders,
sum(Totaldue) as Sum_of_Total_Due
from sales.customer as c
inner join sales.salesorderheader as s          --------- we can use left outer join, right outer join, full outer join
on c.customerid = s.customerid
group by c.customerid, c.Accountnumber
order by c.customerID  */

/* SELECT c.CustomerID, c.AccountNumber,COUNT(s.SalesOrderID) AS CountOfOrders, 
 SUM(COALESCE(TotalDue,0)) AS SumOfTotalDue 
FROM Sales.Customer AS c 
LEFT OUTER JOIN Sales.SalesOrderHeader AS s ON c.CustomerID = s.CustomerID 
GROUP BY c.CustomerID, c.AccountNumber 
ORDER BY c.CustomerID; */

--------------------------------------------------------------------------------------------------------------------------------------------

------------- Correlated Queries 

/*
SELECT CustomerID 
FROM Sales.Customer AS c 
WHERE CustomerID > ( 
 SELECT SUM(TotalDue) 
 FROM Sales.SalesOrderHeader 
 WHERE CustomerID = c.CustomerID); */


select CustomerKey from DimCustomer as c
where 11009 <
	(select Sum(SalesAmount)as Sales from FactInternetSales
	 where CustomerKey = c.CustomerKey)

-------------------------------------------------------------------------------------------
----Need To solve more problems on SubQueries and Derived Tables

------A CTE also allows you to isolate the aggregate query from the rest of the statement


with s as 
	(select ProductKey, count(*) as CountOfSales,
	 sum(OrderQuantity) as TotalQuantity,
	 avg(UnitPrice) as AvgOfTotalUP
	 from FactInternetSales
	 group by ProductKey)
select p.ProductKey, CountOfSales, TotalQuantity, AvgOfTotalUP
from DimProduct as p Inner Join s
on p.ProductKey = s.ProductKey

---------With the help of Join
select p.ProductKey, sum(f.UnitPrice) as Total_UP, sum(f.OrderQuantity)
from DimProduct as p
inner join FactInternetSales as f
on p.ProductKey = f.ProductKey
group by
p.ProductKey

select * from FactInternetSales
select * from DimProduct




































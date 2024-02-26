

select C.CategoryName, count(P.ProductID) as [Total Products]
from [dbo].[Categories] C
inner join [dbo].[Products] P
on P.CategoryID = C.CategoryID
group by C.CategoryName
	

select ProductID, ProductName,UnitsInStock, ReorderLevel
from [dbo].[Products]
where UnitsInStock < ReorderLevel

select ProductID, ProductName,UnitsInStock, 
UnitsOnOrder, ReorderLevel, Discontinued
from [dbo].[Products]
where (UnitsInStock + UnitsOnOrder)  <= ReorderLevel
and 
Discontinued = 0


select CustomerID,  CompanyName, Region
from [dbo].[Customers]
group by CustomerID,  CompanyName, Region
order by Region desc

select Top 3 ShipCountry, AVG(Freight) [Average Freight]
from [dbo].[Orders]
group by ShipCountry
order by AVG(Freight) desc


select Top 3 ShipCountry, AVG(Freight) [Average Freight]
from [dbo].[Orders]
where OrderDate > '1996-01-01'
and OrderDate <= '1997-01-01'
group by ShipCountry
order by AVG(Freight) desc

-------------------problem 28
with CTE_1 as
(
select ShipCountry, Freight, OrderDate,
dateadd(year, -1, max(OrderDate) over ()) LastYearDate
from [dbo].[Orders]
)
select top 3 ShipCountry, AVG(Freight)
from CTE_1
where OrderDate >= LastYearDate
group by ShipCountry
order by AVG(Freight) desc


-- we can do with the help of subquery

select top 3 ShipCountry, avg(Freight)
from [dbo].[Orders]
where OrderDate >= dateadd(year, -1, (select max(OrderDate) from [dbo].[Orders]))
group by ShipCountry
order by avg(Freight) desc

--------------------------------------------------------------------------------------------------------

--Problem-30 

select C.CustomerID, O.CustomerID
from [dbo].[Customers] C
left outer join [dbo].[Orders] O
on C.CustomerID = O.CustomerID
where O.CustomerID is null



--Problem-31

---CTE Method
with CTE as 
(
select CustomerID from  [dbo].[Orders]
where EmployeeID = 4
)
select C.CustomerID, CT.CustomerID
from [dbo].[Customers] C
left outer join CTE CT
on C.CustomerID = CT.CustomerID
where  CT.CustomerID is null

----Normal Method
select C.CustomerID, O.CustomerID
from [dbo].[Customers] C
left outer join [dbo].[Orders] O
on C.CustomerID = O.CustomerID
and O.EmployeeID = 4
where O.CustomerID is null
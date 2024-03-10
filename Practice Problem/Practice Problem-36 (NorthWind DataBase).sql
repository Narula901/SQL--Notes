

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


----Problem - 32
select C.CustomerID, C.CompanyName,
OD.OrderID,sum(OD.UnitPrice*OD.Quantity) as Total_Order_Amount  
from [dbo].[Customers] C
inner join [dbo].[Orders] O
on C.CustomerID = O.CustomerID
inner join [dbo].[Order Details] OD
on O.OrderID = OD.OrderID
where o.OrderDate >'1996-12-31'
and o.OrderDate <= '1997-12-31'
group by  C.CustomerID, C.CompanyName,OD.OrderID
having sum(OD.UnitPrice*OD.Quantity)>10000
order by Total_Order_Amount desc

---Problem 34
select C.CustomerID, C.CompanyName,
OD.OrderID,round(sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)),2) as Totals_With_Discount,
sum(OD.UnitPrice*OD.Quantity) Totals_Without_Discount
from [dbo].[Customers] C
inner join [dbo].[Orders] O
on C.CustomerID = O.CustomerID
inner join [dbo].[Order Details] OD
on O.OrderID = OD.OrderID
where o.OrderDate >'1996-12-31'
and o.OrderDate <= '1997-12-31'
group by  C.CustomerID, C.CompanyName,OD.OrderID
having sum(OD.UnitPrice*OD.Quantity)>10000
order by Totals_Without_Discount desc


---Problem 35
select OrderID,EmployeeID, 
EOMONTH(OrderDate) as EndMonthDate
from [dbo].[Orders] 
group by OrderID,EmployeeID, EOMONTH(OrderDate)
order by EmployeeID, OrderID


---Problem 36
select Top 10 OrderID, Count(*) as Total_Orders_Details
from [dbo].[Order Details]
group by OrderID
order by Total_Orders_Details desc




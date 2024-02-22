

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
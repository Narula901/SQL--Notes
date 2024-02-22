

select C.CategoryName, count(P.ProductID) as [Total Products]
from [dbo].[Categories] C
inner join [dbo].[Products] P
on P.CategoryID = C.CategoryID
group by C.CategoryName


select ProductID, ProductName,UnitsInStock, ReorderLevel
from [dbo].[Products]
where UnitsInStock < ReorderLevel

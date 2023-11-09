select distinct P.ProductID, P.[Name], P.BrandID, P.CategoryID, P.ModelYear, P.ListPrice, 
		sum(S.LineTotal) over(partition by P.ProductID) as Product_Revenue
		from [Production].[Product] P
		inner join [Sales].[OrderItem] S
		on P.ProductID = S.ProductID

select * from [Sales].[OrderItem] 

select * from [Production].[Product]
with CTE_1 as
(
select P.ProductID, P.CategoryID, P.BrandID, p.ModelYear, sum(S.LineTotal) as Revenue
from [Production].[Product] P
inner join [Sales].[OrderItem] S
on P.ProductID = S.ProductID
group by P.ProductID, P.CategoryID, P.BrandID, p.ModelYear
)
select  ProductID, CategoryID,
format((sum(Revenue) over (partition by CategoryID)/ sum(Revenue) over()), 'P') as categorywise,
format((Revenue/sum(Revenue) over (partition by CategoryID)), 'P') as Productwise
from CTE_1
order by CategoryID

with CTE_1 as
(
select P.ProductID, P.CategoryID, P.BrandID, p.ModelYear, sum(S.LineTotal) as Revenue
from [Production].[Product] P
inner join [Sales].[OrderItem] S
on P.ProductID = S.ProductID
group by P.ProductID, P.CategoryID, P.BrandID, p.ModelYear
)
select  ProductID, CategoryID,Revenue,
format(sum(Revenue) over (partition by CategoryID),'C2') as Revenue_1,
format(sum(Revenue) over (partition by CategoryID order by ProductID),'C2') as Revenue_2
from CTE_1
order by CategoryID



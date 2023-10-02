--------------------------------------------Joins--------------------------------------- 


select top 2 * from DimCustomer
select top 2 * from DimGeography

select top 2 * from DimProduct
select top 2 * from DimProductCategory
select top 2 * from DimProductSubcategory

select  * from DimProduct
select  * from DimProductCategory
select  * from DimProductSubcategory

---Inner Join

---Joining Two Tables

Select * from FactInternetSales
Select * from DimProduct
SELECT 
    p.EnglishProductName, p.ProductAlternateKey,
	sum(f.SalesAmount) as total_Sales,
	sum(f.UnitPrice) as Total_UP
 -- SUM(p.purchase_amount) AS total_purchase_amount
FROM 
    DimProduct as p
    JOIN FactInternetSales as f on 
	p.ProductKey = f.ProductKey
GROUP BY 
     p.EnglishProductName, p.ProductAlternateKey
ORDER BY 
    total_Sales DESC

 

SELECT c.FirstName, c.LastName, c.Gender, g.City
FROM DimCustomer AS c
INNER JOIN DimGeography AS g ON c.GeographyKey = g.GeographyKey 

---Joining on a different Column Name
select p.EnglishProductName, p.ProductKey, pc.ProductCategoryKey, pc.EnglishProductCategoryName
from DimProduct as p
inner join DimProductCategory as pc 
on p.ProductKey = pc.ProductCategoryKey

---Joining Threee Tables
select p.EnglishProductName, p.ProductKey, pc.ProductCategoryKey, pc.EnglishProductCategoryName, psc.ProductCategoryKey, psc.EnglishProductSubcategoryName
from DimProduct as p
inner join DimProductCategory as pc 
on p.ProductKey = pc.ProductCategoryKey
inner join DimProductSubcategory as psc
on pc.ProductCategoryKey = psc.ProductCategoryKey

-----Joining Three Tables with where Clause
select p.EnglishProductName, p.ProductKey, pc.ProductCategoryKey, pc.EnglishProductCategoryName, psc.ProductCategoryKey, psc.EnglishProductSubcategoryName
from DimProduct as p
inner join DimProductCategory as pc 
on p.ProductKey = pc.ProductCategoryKey
inner join DimProductSubcategory as psc
on pc.ProductCategoryKey = psc.ProductCategoryKey
where p.ProductKey = 4

---Joining on more than one Column
select pc.ProductCategoryKey, pc.ProductCategoryAlternateKey, pc.EnglishProductCategoryName, psc.ProductSubcategoryKey, psc.ProductSubcategoryAlternateKey, psc.EnglishProductSubcategoryName
from DimProductCategory as pc
inner join DimProductSubcategory as psc
on pc.ProductCategoryKey = psc.ProductSubcategoryKey
and pc.ProductCategoryAlternateKey = psc.ProductSubcategoryAlternateKey ----------- Concept of Candidate key



------Outer Join
----Left Join, replace inner join with left outer join
----Right Join, replace inner join with right outer join

----Using OUTER JOIN to Find Rows with No Match 
SELECT c.FirstName,c.GeographyKey, c.LastName, c.Gender, g.City, g.GeographyKey
FROM DimCustomer AS c
right outer JOIN DimGeography AS g ON c.GeographyKey = g.GeographyKey 
where c.GeographyKey is null

---- Cross Join 
select p.EnglishProductName, pc.EnglishProductCategoryName
from DimProduct as p
cross join DimProductCategory as pc


------------------------------------------------SubQueries----------------------------------

select Max(SalesAmount) from FactInternetSales
where SalesAmount < (select max(SalesAmount) from FactInternetSales)

Select * from DimCustomer
select * from DimGeography

select FirstName, Gender 
from DimCustomer
where GeographyKey 
in 
(select GeographyKey from DimGeography)

select FirstName, LastName, Gender
from DimCustomer
where GeographyKey = (select GeographyKey from DimGeography where City = 'Malabar')

--------------SubQueries Practice Question----------

--------SELECT name FROM departments WHERE id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(*) > 10);

select CustomerKey from DimCustomer where CustomerKey in ( select CustomerKey from FactInternetSales group by CustomerKey having count(*)>10)

-----SELECT AVG(salary) FROM employees WHERE hire_date < DATEADD(year, -5, GETDATE());

SELECT count(Firstname) FROM DimCustomer WHERE BirthDate < DATEADD(year, -2, GETDATE()); ----- Does not Understand

-----SELECT name FROM employees WHERE salary > (SELECT salary FROM employees WHERE id = manager_id);

select FirstName, Lastname, YearlyIncome from DimCustomer where YearlyIncome in (Select YearlyIncome from DimCustomer where YearlyIncome > 100000)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from DimCustomer
select * from DimGeography
--------Union-------
select GeographyKey from DimCustomer
union  -----------------instead of this, we use intersect, Except and Union all
select GeographyKey from DimGeography
order by GeographyKey


--------CTE-----------

select * from FactInternetSales

WITH orders as (
	select ProductKey,OrderDate,SalesAmount,OrderQuantity
	from FactInternetSales
	where OrderDate > '2010-12-29' and OrderDate < '2011-01-03'
    )
Select p.ProductKey,p.EnglishProductName, orders.ProductKey, orders.OrderDate, orders.SalesAmount
from DimProduct as p
left outer join orders on 
p.ProductKey = orders.ProductKey
where orders.ProductKey is not null


---- Same Problem with Join

Select p.ProductKey,EnglishProductName, f.ProductKey, f.OrderDate, f.SalesAmount
from DimProduct as p
left outer join FactInternetSales as f on 
p.ProductKey = f.ProductKey
where f.OrderDate > '2010-12-29' and f.OrderDate < '2011-01-03'


----------------------------------------------------------------------------------------------------------------------

-----Advance Practice Problems in Subqueries
----Find the top 5 products with the highest unit price in the "FactInternetSales" table

SELECT ProductKey, UnitPrice
FROM FactInternetSales
WHERE UnitPrice IN (
  SELECT TOP 5 UnitPrice 
  FROM FactInternetSales 
  GROUP BY UnitPrice 
  ORDER BY UnitPrice DESC
);












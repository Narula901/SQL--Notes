
-----------------------------------------------------Table Valued Function------------------------------------------------

select * from [Production].[Product]
select * from [Production].[Category]
--------------------------------------------------------------

create or alter function ProductCategory(@Category nvarchar(30))

Returns Table

as 

return
 (
     select P.ProductID, 
	 P.[Name] as Movie_Name,
	 C.[Name], C.CategoryID
	 from [Production].[Product] P
	 inner join [Production].[Category] C
	 on P.CategoryID = C.CategoryID
	 where lower(C.[Name]) = lower(@Category)
)

select * from ProductCategory('Comfort Bicycles')


------------------------------------------------------------------
/*
Create a table-valued function called ufn_ProductsByPriceRange, assigned to the Production schema. Your solution should meet the following requirements:



The function should return a result set consisting of all products from the Production.
Product table with a “ListPrice” between a user-specified minimum and a user-specified maximum.

(This of course means your function will need to take two parameters; one for the minimum list price, and one for the maximum list price.)

The result set returned by the function should include the “ProductID”, “Name”, and “ListPrice” columns.
*/

select * from [Production].[Product]

create or alter function ProductByRange(@min money, @max money)

returns table

as

return 
(
		select ProductID, [Name], ListPrice 
		from [Production].[Product]
		where ListPrice between @min and @max
)

select * from ProductByRange(500, 600)
order  by ListPrice desc






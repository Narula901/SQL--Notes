select * from [Production].[Product]

--- Group by Collapse the Rows
select count(ProductID), CategoryID
from [Production].[Product]
group by CategoryID
order by count(ProductID) desc

--- Now i want to group with all the records
select ProductID, [Name], BrandID, CategoryID, ModelYear, ListPrice , count(ProductID)
from [Production].[Product]
group by ProductID, [Name], BrandID, CategoryID, ModelYear, ListPrice

--- I want that for Each CategoryID what are the total number of Count for Product ID while preserving the other columns as well
--- Approach CTE (1st Method)
with Product_Count as
(
	select CategoryID, count(ProductID) as No_of_Products
	from [Production].[Product]
	group by CategoryID
)
select P.ProductID, P.[Name], P.BrandID, P.CategoryID, P.ModelYear, P.ListPrice, PC.No_of_Products
from [Production].[Product] P
inner join Product_Count PC 
on P.CategoryID = PC.CategoryID

--- conclusion - Here we can see that it gives the Total No. of product on each Category while preserving all the columns
--- This can achieve with the help of Window function.
---- 2nd Method 
select *, 
count(ProductID) over (partition by CategoryID order by CategoryID) as No_of_Product_in_each_category
from [Production].[Product]

select *, 
count(ProductID) over (partition by CategoryID order by ProductID) as No_of_Product_in_each_category
from [Production].[Product]


select *, 
count(ProductID) over (partition by CategoryID order by ModelYear) as No_of_Product_in_each_category
from [Production].[Product]

--- if we take only Order by Clause it gives different results, it will take the all the rows above and down for current row context at each category ID.
select *, 
count(ProductID) over (order by CategoryID) as No_of_Product_in_each_category
from [Production].[Product]

--- Practice Purpose 
select *, 
count(ProductID) over (order by CategoryID) as No_of_Product_in_each_category,
format(sum(ListPrice) over(), 'C2') as Total_Price,
format(avg(ListPrice) over(), 'C2') as Average_Price
from [Production].[Product]

--- 
select * from Sales.Customer
select * from [Sales].[Order]

---- Calculate the no of order purchased by customer followed by Revenue Per Customer and Customer Revenue Ratio
select C.CustomerID, O.OrderID, O.OrderDate, O.StoreID,
count(O.OrderID) over (Partition by C.CustomerID ) as TotalOrderByCustomer,
format(sum(O.OrderTotal) over(Partition by C.CustomerID), 'C2')as RevenuePerCustomer,
format(sum(O.OrderTotal) over (), 'C2') as TotalRevenue,
format(sum(O.OrderTotal) over(Partition by C.CustomerID) / sum(O.OrderTotal) over (), 'P') as CustomerRevenueRatio
from Sales.Customer C
inner join [Sales].[Order] O
on C.CustomerID = O.CustomerID
order by CustomerRevenueRatio desc

---Want Sales of Year and Month-Wise, also calculcate % of Annual Sales, and gives Ranking according highest to lowest monthly sales in each year

With Year_Month_Data as
(
	select distinct year(OrderDate) as [Year], month(OrderDate) as [Month], 
	sum(OrderTotal) over(partition by year(OrderDate), month(OrderDate)) as MonthlySales,
	sum(OrderTotal) over(partition by year(OrderDate)) as AnnualSales
	from [Sales].[Order]
)
select [Year], [Month],
format(MonthlySales,'C2') as MonthlySales, 
format(AnnualSales,'C2') as AnnualSales,
format(MonthlySales/AnnualSales, 'P') as [%ofAnnualSales],
DENSE_RANK() over (partition by [Year] order by MonthlySales desc) as Ranking ----imp
from Year_Month_Data 
order by [Year], [Month]

--- Now I want Month Where there is Maximum Monthly Sales in Each Year

With Base as
(
	select distinct year(OrderDate) as [Year], month(OrderDate) as [Month], 
	sum(OrderTotal) over(partition by year(OrderDate), month(OrderDate)) as MonthlySales,
	sum(OrderTotal) over(partition by year(OrderDate)) as AnnualSales
	from [Sales].[Order]
),
YearlySales as
(
		select [Year], [Month],
		format(MonthlySales,'C2') as MonthlySales, 
		format(AnnualSales,'C2') as AnnualSales,
		format(MonthlySales/AnnualSales, 'P') as [%ofAnnualSales],
		DENSE_RANK() over (partition by [Year] order by MonthlySales desc) as Ranking
		from Base 
)
select [Year], [Month], MonthlySales, AnnualSales, [%ofAnnualSales], Ranking
from YearlySales
where Ranking = 1
order by [Year], [Month]

--- Write a SQL Query to calculate running total of revenue for each year?
with Sales as
(
	select distinct YEAR(OrderDate) as [Year], sum(OrderTotal) as Revenue
	from [Sales].[Order]
	group by YEAR(OrderDate)
)
select [Year], 
format(Revenue, 'C2') as Revenue, 
format(sum(Revenue) over(order by [Year] rows between unbounded Preceding and current row), 'C2') as Running_Total
from Sales
order by [Year]

-- Difference between Rows and Range Window Framing 
select * from [Sales].[Order]
select *, sum(OrderTotal) over (order by OrderDate range between unbounded preceding and current row) as Running_Total
from [Sales].[Order]  ----- Erroneous result
-----------------------------

----- This will give the accurate result
select *, sum(OrderTotal) over (order by OrderID range between unbounded preceding and current row) as Running_Total
from [Sales].[Order]

select *, sum(OrderTotal) over (order by OrderDate rows between unbounded preceding and current row) as Running_Total
from [Sales].[Order]
-------------------------------------------

--- Ques-
With yearly_Revenue as
(
	select year(OrderDate) as [Year],sum(OrderTotal) as Annual_Revenue
	from [Sales].[Order]
	group by year(OrderDate)
),
Expected_Sales as
(
select [Year], Annual_Revenue, 
avg(Annual_Revenue) over(order by [Year] rows between 3 preceding and 1 preceding) as Expected_Revenue
from yearly_Revenue
)
select [Year], 
format(Annual_Revenue, 'C2') as AnnualRevenue,
format(Expected_Revenue, 'C2') as ExpectedRevenue,
format ((Annual_Revenue - Expected_Revenue)/Expected_Revenue, 'P') as [% of variance]
from Expected_Sales
-------

--Ques - 

with ProductSale as
(
		select distinct P.ProductID, P.[Name], P.BrandID, P.CategoryID, P.ModelYear, P.ListPrice, 
		sum(S.LineTotal) over(partition by P.ProductID) as Product_Revenue
		from [Production].[Product] P
		inner join [Sales].[OrderItem] S
		on P.ProductID = S.ProductID
)
select  ProductID, [Name], BrandID, CategoryID, ModelYear, ListPrice,
format(Product_Revenue, 'C2') as Revenue,
format(sum(Product_Revenue) over(partition by CategoryID), 'C') as Category_value,
format(Product_Revenue/sum(Product_Revenue) over(partition by CategoryID), 'P') Compared_to_Category,
format(sum(Product_Revenue) over(partition by BrandID), 'C') as Brand_Value,
format(Product_Revenue/sum(Product_Revenue) over(partition by BrandID), 'p') Compared_to_Brand,
format(Product_Revenue/sum(Product_Revenue)over(), 'P') as Compared_to_TotalRevenue 
from ProductSale
order by CategoryID desc


























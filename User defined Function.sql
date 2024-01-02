--- Scaler user defined function 
--- Database - BikeStores 
create function ufnCurrentDate()

returns Date 

as 

begin
return cast(getdate() as date)
end

----Ques
select OrderID, CustomerID, OrderDate, ShippedDate,
[dbo].[ufnCurrentDate]() Today_Date
from 
[Sales].[Order]

---- Scenerio
Create function ufnElapsedBusinessDays(@StartDate Date, @EndDate Date)

returns int 

as

begin
return
(
select count(*) 
from [dbo].[Calender]
where DateValue between @StartDate and @EndDate
and WeekendFlag = 0
and HolidayFlag = 0
)
end

select  *
from [Sales].[Order]


select OrderID, CustomerID, OrderDate, ShippedDate,
ElapsedBusinessDays = [dbo].[ufnElapsedBusinessDays](OrderDate,ShippedDate)
from [Sales].[Order] S
where Year(S.OrderDate) = 2011


/*
Indexing: Ensure that your [dbo].[Calendar] table is properly indexed, 
especially on the DateValue, WeekendFlag, and HolidayFlag columns.
Proper indexing can significantly improve the performance of queries involving large datasets.

Table Statistics: Keep statistics up to date for the [dbo].[Calendar] table. 
Outdated statistics may lead the SQL Server query optimizer to choose suboptimal execution plans.

Query Optimization: Depending on the size of your data, the query might be scanning the entire [dbo].[Calendar] table.
If possible, try to optimize the query or break it down into smaller, more manageable steps.

Function Performance: Scalar functions, like the one you've created, can sometimes be performance bottlenecks, 
especially when used in large result sets. Consider alternative approaches or optimizations to the function.

Data Distribution: If the date range in your [dbo].[Calendar] table is large, 
it might result in a high number of rows to scan. You may want to check if the date range can be narrowed down or 
if there are any date range filtering conditions that can be applied.

Execution Plan: Examine the execution plan for your query to identify any performance bottlenecks. 
Use tools like SQL Server Management Studio to view the execution plan and analyze where most of the time is being spent.
*/






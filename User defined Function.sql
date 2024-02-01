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
Problem - Create a user-defined function that returns the percent that one number is of another.

For example, if the first argument is 8 and the second argument is 10, the function should return the string "80.00%".

The function should solve the "integer division" problem by allowing you to divide an integer by another integer, and yet get an accurate decimal result.
*/

create function dbo.RatioInterger(@Numerator int, @Denominator int)
returns varchar(8)
as
begin

declare @Decimal Float = (@Numerator * 1.0)/@Denominator
return format(@Decimal, 'P')

end

select dbo.RatioInteger(3,5)
-----------------------------------------------------
create function dbo.Ratio(@Num int, @Deno int)
returns varchar(8)
as 
begin
	declare @Decimal float = 0;
	declare @result varchar(8);

	if @Deno = 0
	begin
		set @result = 'N/A'
	end 
	else
	begin 
	     set @Decimal =  (@Num * 1.0)/@Deno
		 set @result = format(@Decimal, 'P')
	end

	return @result
end

select dbo.Ratio(3,0)


---DROP FUNCTION dbo.ConvertToDateOnly;

--------------------------------------------------------------
create function dbo.ConvertToDateOnly(@Date Date)
returns date
as 
begin
		return cast(@Date as date)
end
cast(CreatedDate as date)

/*
Problem - Store the maximum amount of vacation time for any individual employee in a variable.

Then create a query that displays all rows and the following columns from the AdventureWorks2019.HumanResources.Employee table:

BusinessEntityID

JobTitle

VacationHours

Then add a derived field called "PercentOfMaxVacation", 
which returns the percent an individual employees' vacation hours are of the maximum vacation hours for any employee.
*/

Use AdventureWorksDW2019;

declare @MaxVactionHours int = (select max(VacationHours) from [dbo].[DimEmployee])

select EmployeeKey,VacationHours,
PercentOfMaxVacation = dbo.Ratio(VacationHours, @MaxVactionHours)
from  [dbo].[DimEmployee]

-----------------------
use [Jackson Dataset]
go

create or alter function dbo.ConvertToDateOnly(@Date Date)
returns date
as 
begin
		return cast(@Date as date)
end

go
select *, GRNDateOnly = dbo.ConvertToDateOnly(GRNRegisteredDate) 
from [dbo].[GRN Report]

select * from [dbo].[GRN Report]

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






select CustomerKey, (FirstName + ' ' + LastName) as Full_Name
from DimCustomer

Select * from DimCustomer

---------- Concatenation
select CustomerKey, (FirstName + ' ' + MiddleName  + ' ' + LastName) as Full_Name   
from DimCustomer


select CustomerKey, (FirstName  + isnull(' ' + MiddleName, '')  + ' ' + LastName) as Full_Name
from DimCustomer

Select CustomerKey, (FirstName + COALESCE(' ' + MiddleName, '') + ' ' + LastName) as Full_Name
from DimCustomer

----Cast Function
select CustomerKey, cast(CustomerKey as nvarchar(10)) + ' ' +isnull('' + Middlename, '') + ' ' + LastName as Cus_Name
from DimCustomer

select CustomerKey, CustomerKey + 200 as "Adds 200", cast(CustomerKey as nvarchar) +'1' as "Append 1"
from DimCustomer


select * from [dbo].[DimProduct]
[dbo].[DimProductCategory]

select EnglishProductName,ReorderPoint, ReorderPoint*10 as Total_Point 
from [dbo].[DimProduct] 

select Distinct(CustomerKey), UnitPrice*OrderQuantity as Total_Cost
from [dbo].[FactInternetSales]

Select * from FactInternetSales

select 10/4 as Division   ------ Gives Divisior
select 10%7as Modulus ----------- gives remainder



select * from DimCustomer

-----Left and Right Function
select LastName, left(LastName,3)as Last_Word, FirstName, right(FirstName,2)as First_word, CustomerKey
from DimCustomer
where CustomerKey in (11000, 11002,11020)

---- Len function
select FirstName, len(FirstName)
from DimCustomer

select max(len(FirstName)) as Maximum_Letter
from DimCustomer

select  distinct(FirstName), len(FirstName)
from DimCustomer

----Charindex
---- CHARINDEX(substring, string, start)
-----start = Optional. The position where the search will start (if you do not want to start at the beginning of string). The first position in string is 1

select distinct(EnglishEducation), CHARINDEX('e',EnglishEducation)
from DimCustomer

select FirstName, charindex('o',FirstName,3)
from DimCustomer 


-----Substring
-----SUBSTRING(string, start, length)
/*string ---	Required. The string to extract from
start---	Required. The start position. The first position in string is 1
length	--- Required. The number of characters to extract. Must be a positive number*/

select LastName, FirstName, SUBSTRING(LastName,1,3)
from DimCustomer

---Upper and Lower
select LastName, FirstName, UPPER(LastName)as Upper_Limit, LOWER(FirstName) as  Lower_Limit
from DimCustomer

----Replace
select LastName, Replace(LastName, 'A','z') as "Replace A"
from DimCustomer

---Nesting Function
select * from DimCustomer 
select EmailAddress, substring(EmailAddress, charindex('@',EmailAddress) + 1,50)
from DimCustomer

select EmailAddress, LEFT(EmailAddress, charindex('@',EmailAddress)-3)
from DimCustomer


select EmailAddress, substring(EmailAddress, 10,5)
from DimCustomer


-------Date Functions

---DateAdd
----DATEADD(interval, number, date)
select * from [dbo].[FactInternetSales]

select ProductKey, OrderDate, DATEADD(year,1,OrderDate) as OneMoreYear,
dateadd(month,1,OrderDate) as OneMoreMonth,
Dateadd(day,-1,OrderDate) as OneLessDay
from [dbo].[FactInternetSales]
where ProductKey between 310 and 320

----DateDiff
select OrderDate, ShipDate, 
DATEDIFF(year, OrderDate, ShipDate) as YearDiff,
Datediff(month,OrderDate,ShipDate) as MonthDiff,
DateDiff(day,OrderDate,Shipdate) as DayDiff
from [dbo].[FactInternetSales]

----DatePart And DateName
Select OrderDate, DATEPART(year, OrderDate) as OrderYear,
DATENAME(month, OrderDate) as OrderMonth
from FactInternetSales

-----Day, Month and Year
select orderDate,
year(OrderDate) as OrderYear,
MONTH(OrderDate) as OrderMonth
from FactInternetSales

----Convert In the Context of Date
select  orderdate, CONVERT(varchar,OrderDate,1) as "1",
convert(varchar,orderdate,101) as "101"
from FactInternetSales

----Round Function
select TotalProductCost, ROUND(TotalProductCost,1,1) as Rounded_Value
from FactInternetSales

----Rand 
select rand() as Random_Var

----Rand with Seed Number
select rand(2) as Random_Var

-----Absoulte, Power, Square,  and SQRT Function
select abs(-2)

select power(10,3) as "Power Example"

select SQUARE(10) as "Square"
select SQRT(40) as "SQRT"

select * from DimCustomer
where Title is null

-----Case
select Title,
	Case Title
	when 'Mr.' Then 'Male'
	when 'Ms.' Then 'Female'
	when 'Mrs' Then 'Female'
	else 'Unknown' end as Gender
from DimCustomer
where CustomerKey in (11377,11913,11000)

SELECT Title, 
 CASE WHEN Title IN ('Ms.','Mrs.','Miss') THEN 'Female' 
 WHEN Title = 'Mr.' THEN 'Male' 
 ELSE 'Unknown' END AS Gender 
FROM DimCustomer
where CustomerKey in (11377,11913,11000)


SELECT  SalesAmount, TotalProductCost,
 CASE WHEN SalesAmount > TotalProductCost THEN SalesAmount 
 ELSE TotalProductCost END AS 'More Hours' 
FROM FactInternetSales

select SalesAmount from FactInternetSales


---Coalesce
SELECT GeographyKey,City, PostalCode, 
 COALESCE(City, PostalCode,'No color or size') AS "City Name"
FROM DimGeography 

------ Admin Function
SELECT DB_NAME() AS "Database Name", 
 HOST_NAME() AS "Host Name", 
 CURRENT_USER AS "Current User", 
 USER_NAME() AS "User Name", 
 APP_NAME() AS "App Name"



----Excercise 3.6, question 1
select CustomerKey,
	case when CustomerKey%2 = 0 then 'Even'
	else 'Odd' end as Test
from DimCustomer

----Question 2
SELECT GeographyKey,City, PostalCode, 
 COALESCE(City, PostalCode,'No color or size') AS "City Name"
FROM DimGeography 















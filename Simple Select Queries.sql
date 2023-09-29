
---- Practice Questions
use AdventureWorksDW2019
go
select * from [dbo].[DimCustomer]

--Showing an Error
----select EnglishEducation as Education, EnglishOccupation as Occupation, sum(YearlyIncome) as Total_Income
---from [dbo].[DimCustomer]

---select EnglishEducation, sum(YearlyIncome) as Total_Income
--from [dbo].[DimCustomer]

---where with Categorical Data
select EnglishEducation as Education, EnglishOccupation as Occupation 
from [dbo].[DimCustomer]
where Gender = 'M'

---- Where with Date Parameter
select EnglishEducation as Education, EnglishOccupation as Occupation 
from [dbo].[DimCustomer]
where DateFirstPurchase = '2011-01-07'


select EnglishEducation as Education, EnglishOccupation as Occupation 
from [dbo].[DimCustomer]
where DateFirstPurchase <>'2011-01-07'


select EnglishEducation as Education, EnglishOccupation as Occupation 
from [dbo].[DimCustomer]
where YearlyIncome < =11000

select FirstName, LastName, DateFirstPurchase 
from [dbo].[DimCustomer]
where DateFirstPurchase between '2011-01-01' and '2011-01-30'
order by DateFirstPurchase 

select FirstName, LastName, CustomerKey
from [dbo].[DimCustomer]
where CustomerKey between 11000 and 11005

select EnglishEducation, CustomerKey
from  [dbo].[DimCustomer]
where EnglishEducation between 'a' and 'P'

select Distinct FirstName 
from DimCustomer
where FirstName like '%la'

select  FirstName, LastName
from DimCustomer
where (FirstName = 'Luke' and not(LastName = 'Lal' or LastName = 'Allen'))

select FirstName, LastName
from DimCustomer
where FirstName = 'Luke' and (LastName in ('Lal', 'Allen'))

select Title from DimCustomer
where Title is null

select Title from DimCustomer
where Title is not null

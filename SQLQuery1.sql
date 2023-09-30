WITH EmployeeCTE  as 
  (
    SELECT *, ROW_NUMBER() OVER (
            PARTITION BY EnglishEducation
              ORDER BY 
            EnglishEducation
        ) as row_num
     FROM 
        [dbo].[Practice]
)
DELETE FROM EmployeeCTE
WHERE row_num > 1;

select * from [dbo].[Practice]

drop table [dbo].[Practice]

select EnglishEducation, EnglishOccupation, MaritalStatus,YearlyIncome 
into Practice
from DimCustomer

select * from [dbo].[Practice]

drop table [dbo].[Practice]

select EnglishEducation, max(YearlyIncome) as Maximum_Salary , min(YearlyIncome) as Minimum_Salary
from [dbo].[Practice]
group by EnglishEducation


select EnglishEducation, count(EnglishEducation) as Count_of_Customer
from [dbo].[Practice]
group by EnglishEd
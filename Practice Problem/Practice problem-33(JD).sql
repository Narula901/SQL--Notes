

Go
create or alter view Final_Inventory as 
with CTE as 
(
select I.LocationCode, I.ItemNo, I.ItemCategoryCode, I.Inventory, I.CreatedDate, I.LotNo, G.GRNRegisteredDate, G.ItemNo as GRNItemNo
from [dbo].[Inventory Item-wise] I
left outer join [dbo].[GRN Report] G
on I.ItemNo = G.ItemNo
and I.LotNo = G.LotNo
),
CTE_1 as
(
select *,
ROW_NUMBER() over (partition by ItemNo, LotNo order by ItemNo, LotNo) as row_no,
COALESCE(DATEDIFF(day,GRNRegisteredDate, CreatedDate),400) as Aging_Process,
case 
when DATEDIFF(day,GRNRegisteredDate, CreatedDate)<=60 then '0-60 days'
when DATEDIFF(day,GRNRegisteredDate, CreatedDate)>60 and DATEDIFF(day,GRNRegisteredDate, CreatedDate)<=180 then '60-180 days'
when DATEDIFF(day,GRNRegisteredDate, CreatedDate)>180 then '180-365days'
else 'More than 365'
end as Category
from CTE
)
select * from CTE_1
where row_no = 1

Go
select * from Final_Inventory

Go
create or alter view aggregate_Inventory as
select CreatedDate,
sum(Inventory) as [Total_Inventory]
from [dbo].[All Inventory Data]
group by CreatedDate

Go
select * from aggregate_Inventory


ALTER TABLE [dbo].[Master Location]
ADD Valid_Name NVARCHAR(MAX)

select * from [dbo].[Master Location] 
UPDATE [dbo].[Master Location]
SET Valid_Name = 
    CASE 
        WHEN Client= 'JAKSON_KAROLI' THEN 'Karoli'
        WHEN Client = 'JAKSON-MANDOLI' THEN 'Mandoli'
        WHEN Client = 'MONOBLOCK- MANDOLI' THEN 'MonoBlock'
        ELSE 'DefaultValue' -- You can set a default value for other cases
    END;


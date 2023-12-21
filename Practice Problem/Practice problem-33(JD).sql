
----Final Inventory
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





---- Master Location
Go
ALTER TABLE [dbo].[Master Location]
ADD Valid_Name NVARCHAR(MAX)

UPDATE [dbo].[Master Location]
SET Valid_Name = 
    CASE 
        WHEN Client= 'JAKSON_KAROLI' THEN 'Karoli'
        WHEN Client = 'JAKSON-MANDOLI' THEN 'Mandoli'
        WHEN Client = 'MONOBLOCK- MANDOLI' THEN 'MonoBlock'
        ELSE 'DefaultValue' -- You can set a default value for other cases
    END;


go
SELECT Category
INTO Category_Sorting
FROM Final_Inventory
group by Category
----drop table Category_Sorting

select * from Category_Sorting

---- Category Sorting 
go 
ALTER TABLE [dbo].[Category_Sorting]
ADD Sorting_Order INT;
UPDATE [dbo].[Category_Sorting]
SET Sorting_Order = 
    CASE 
        WHEN Category= '0-60 days' THEN 1
        WHEN Category = '60-180 days' THEN 2
        WHEN Category = '180-365days' THEN 3
        ELSE 4 -- You can set a default value for other cases
    END;

---- All Inventory Data
go
select * from [dbo].[All Inventroy Data]


ALTER TABLE [dbo].[All Inventroy Data]
ADD Created_Date_Copy  date

UPDATE [dbo].[All Inventroy Data]
SET  Created_Date_Copy = cast(CreatedDate as date)


---- Master Bin
Go
select * from [dbo].[Master Bin]


ALTER TABLE [dbo].[Master Bin]
ADD Location_Code NVARCHAR(MAX)

UPDATE [dbo].[Master Location]
SET Location_Code = 
    CASE 
        WHEN [Source.Name] = 'Bins(Karoli).xls' THEN 'JAKSON_KAROLI'
        WHEN [Source.Name] = 'Bins(Mandoli).xls' THEN 'JAKSON-MANDOLI'
        WHEN [Source.Name] = 'Bins(Mono-Block).xls' THEN 'MONOBLOCK- MANDOLI'
        ELSE 'DefaultValue' -- You can set a default value for other cases
    END;

----Inward Throughput
go
select * from [dbo].[Inward Throughput]


ALTER TABLE [dbo].[Inward Throughput]
ADD GRN_Registered_Date_Copy  date

UPDATE [dbo].[Inward Throughput]
SET  GRN_Registered_Date_Copy = cast(GRNRegisteredDate as date)


----Outward Throughput 
go
select * from [dbo].[Outward Throughput]


ALTER TABLE [dbo].[Outward Throughput]
ADD Ship_Date_Copy  date

UPDATE [dbo].[Outward Throughput]
SET  Ship_Date_Copy = cast([SHIP DATE] as date)

----

-----


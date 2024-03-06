
select * from [dbo].[Inventory Item-wise]

select * from [dbo].[All Inventroy Data]

----Final Inventory
Go
create or alter view Final_Inventory as 
with CTE as 
(
select I.LocationCode, I.ItemNo, I.ItemCategoryCode, I.Inventory, I.CreatedDate, I.LotNo, G.GRNRegisteredDate, G.ItemNo as GRNItemNo, 
cast(G.GRNRegisteredDate as date) GRN_Copy_Date
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
order by Aging_Process asc




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




----Inward Throughput
go
select max(GRNRegisteredDate), min(GRNRegisteredDate) from [dbo].[Inward Throughput]


ALTER TABLE [dbo].[Inward Throughput]
ADD GRN_Registered_Date_Copy  date

UPDATE [dbo].[Inward Throughput]
SET  GRN_Registered_Date_Copy = cast(GRNRegisteredDate as date)


----Outward Throughput 
go
select max([SHIP DATE]),
min([SHIP DATE]) 
from [dbo].[Outward Throughput]


ALTER TABLE [dbo].[Outward Throughput]
ADD Ship_Date_Copy  date

UPDATE [dbo].[Outward Throughput]
SET  Ship_Date_Copy = cast([SHIP DATE] as date)



----StartEnd Invetory item wise data
select * from [dbo].[StartEND Inventory Item-Wise]

ALTER TABLE [dbo].[StartEND Inventory Item-Wise]
ADD Created_Date_Copy  date

UPDATE [dbo].[StartEND Inventory Item-Wise]
SET  Created_Date_Copy = cast(CreatedDate as date)

select * from [dbo].[StartEND Inventory Item-Wise]


----Sales Report

ALTER TABLE [dbo].[Sales Report]
ADD Ship_Date_Copy  date

UPDATE [dbo].[Sales Report]
SET  Ship_Date_Copy = cast([SHIP DATE] as date)

select max([SHIP DATE]) from [dbo].[Sales Report]


---GRN Report 
ALTER TABLE [dbo].[GRN Report]
ADD GRN_Date_Copy  date

UPDATE [dbo].[GRN Report]
SET  GRN_Date_Copy = cast(GRNRegisteredDate as date)

--- Master Bin 
ALTER TABLE [dbo].[Master Bin]
ADD Candidate_Key NVARCHAR(MAX)

UPDATE [dbo].[Master Bin]
SET Candidate_Key = [BIN CODE] + '-' + [Warehouse Name]
   from [dbo].[Master Bin]


------Binwise
ALTER TABLE [dbo].[Binwise]
ADD Candidate_Key NVARCHAR(MAX)

UPDATE [dbo].[Binwise]
SET Candidate_Key = BinCode + '-' + LocationCode
   from [dbo].[Binwise]

----Inventory bin-wise 
ALTER TABLE [dbo].[Invnentory Bin Wise]
ADD Candidate_Key NVARCHAR(MAX)

UPDATE [dbo].[Invnentory Bin Wise]
SET Candidate_Key = BinCode + '-' + LocationCode
   from [dbo].[Invnentory Bin Wise]


---Create Sales_GRN_Date_Duration

create view Sales_GRN_Date_Duration as
with CTE as
(
select I.No,G.ItemNo, G.GrnNumber,G.GRNRegisteredDate,G.LotNo, S.[SHIP DATE], S.SKU, S.LotNo as SalesLotNo
from [dbo].[Master Item] I
inner join [dbo].[GRN Report] G
on I.No = G.ItemNo
inner join [dbo].[Sales Report] S
on G.ItemNo = S.SKU
and G.LotNo = S.LotNo
---order by LotNO
)
select ItemNo, LotNo, GRNRegisteredDate,[SHIP DATE], SKU, SalesLotNo,
DATEDIFF(day,GRNRegisteredDate,[SHIP DATE]) as days
from CTE


-----create FSN_Category
Create or alter view FSN_Category as 

with FSN as
(
select SKU, sum(Quantity) Total_QTY,  COUNT(distinct(OrderDate)) OrderdateCount
from [dbo].[Sales Report]
group by SKU
),
CTE as
(
select *, ((0.3*Total_QTY) + (0.7*OrderdateCount)) as Weight_order
from FSN
)
select *,
case 
	when Weight_order >=23.2 then 'Fast-Moving'
	when Weight_order > 2 and Weight_order <23.2 then 'Slow-Moving'
	else 'Non-Moving'
	end as Category
from 
CTE


-------


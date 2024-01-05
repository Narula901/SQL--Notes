select * from [dbo].[K1 & K3]

select * from [dbo].[K1 & K3 (All Data)]

select max([DO Execution Date]), min([DO Execution Date])from [dbo].[K1 & K3 (All Data)]


select * from [dbo].[K2 Inward & Outward]

select max([Pstng Date]), min([Pstng Date]) from [dbo].[K2 Inward & Outward]

select * from [dbo].[Item Master]
------------[K1 & K3 (All Data)] and Item Master
create or alter View OutwardThroughputK1K3 as
with outwardthroughput as
(
select * 
from [dbo].[K1 & K3 (All Data)] K
left outer join [dbo].[Item Master] IM
on K.[Brand Code] = IM.Item
),
CTE as
(
select *, ([DO Qty(Total CFC)])/([CFC/Pallet]) Pallet
from outwardthroughput
),
CTE_1 as 
(
select *,CAST(Pallet AS INT) AS FP, 
(Pallet - CAST(Pallet AS INT)) CP, 
(CAST(Pallet AS INT)*[CFC/Pallet]) FP_Box,
((Pallet - CAST(Pallet AS INT))*[CFC/Pallet]) CP_Box,
cast([Do Execution Date] as date) Do_Execution_Date_Copy
from CTE
)
select *
from CTE_1
select * from OutwardThroughputK1K3

------[K2 Inward & Outward] and Item Master
create or alter View OutwardThroughputK2 as
with outwardthroughput as
(
select * 
from [dbo].[K2 Inward & Outward] K
left outer join [dbo].[Item Master] IM
on K.Material = IM.Item
),
CTE as
(
select *, CFC/([CFC/Pallet]) Pallet
from outwardthroughput
),
CTE_1 as 
(
select *,CAST(Pallet AS INT) AS FP, 
(Pallet - CAST(Pallet AS INT)) CP, 
(CAST(Pallet AS INT)*[CFC/Pallet]) FP_Box,
((Pallet - CAST(Pallet AS INT))*[CFC/Pallet]) CP_Box,
CEILING(Pallet) as Rounded_Pallet,
cast([Pstng Date] as Date) as Posting_Date_Copy
from CTE
)
select *
from CTE_1

select * from OutwardThroughputK2


--------[K1 & K3 (All Data)] 

ALTER TABLE [dbo].[K1 & K3 (All Data)]
ADD Created_Date_Copy  date

UPDATE [dbo].[K1 & K3 (All Data)]
SET  Created_Date_Copy = cast([DO Execution Date] as date)

ALTER TABLE [dbo].[K1 & K3 (All Data)]
ADD [Status] NVARCHAR(MAX)

UPDATE [dbo].[K1 & K3 (All Data)]
SET [Status] = 'K1 & K3'

UPDATE [dbo].[K2 Inward & Outward]
SET [Status] = 
    CASE 
        WHEN [Status]= 'K-2 Outward' THEN 'K-2 Outward'
        WHEN [Status] = 'K2 Outward' THEN 'K-2 Outward'
        WHEN [Status] = 'K2 Inward' THEN 'K-2 Inward'
		WHEN [Status] = 'K-2 Inward' THEN 'K-2 Inward'
        
    END;
---------------------------------------

-----------------[dbo].[K2 Inward & Outward]

ALTER TABLE [dbo].[K2 Inward & Outward]
ADD Created_Date_Copy  date

UPDATE [dbo].[K2 Inward & Outward]
SET  Created_Date_Copy = cast([Pstng Date]  as date)

-----------------------------------------------------------------

---------View -- Truck_Placed_Vendor
create or alter View Truck_Placed_Vendor as
select [Vendor Name],[Status],Created_Date_Copy, [Lorry Number] as Truck_Distinct_Count, [DO Qty(Total CFC)] as QTY, [        Truck type] as Truck_Type
from [dbo].[K1 & K3 (All Data)]
union 
select [TPT Name] as [Vendor Name], [Status],Created_Date_Copy ,[Truck No] as Truck_Distinct_Count, CFC as QTY, [Truck Type] as Truck_Type
from [dbo].[K2 Inward & Outward]

select * from [dbo].[K1 & K3 (All Data)]

select * from [dbo].[K2 Inward & Outward]


---------------------------------------------------------------------


-----Create Status table, consist of distinct values
create Table [Status]
(
Zone varchar(12)
)

Insert into [Status]
(
Zone 
)
select distinct [Status] from Truck_Placed_Vendor
------------------------------------------------------------------

-----------------
with CTE as 
(
select *, 
DATEDIFF(DAY,[WSP Return Recd Date], [Mail intimation sent to branch Date & So Creation]) as[So Creation in Days],
DATEDIFF(DAY, [Mail intimation sent to branch Date & So Creation],[PGR Done by WSP date]) as [DO Execution in Days]
from [Sales Data]
)
select *,
with CTE as 
(
select *, 
DATEDIFF(DAY,[WSP Return Recd Date], [Mail intimation sent to branch Date & So Creation]) as[So Creation in Days],
DATEDIFF(DAY, [Mail intimation sent to branch Date & So Creation],[PGR Done by WSP date]) as [DO Execution in Days]
from [Sales Data]
)
select *,
case 
	when [So Creation in Days] <=1 then '0-1 days'
	when [So Creation in Days] =2 then '2 days'
	when [So Creation in Days] =3 then '3 days'
	else 'More than 3 days'
end as [Category(SO CID)]
from CTE

end as [Category(SO CID)]
from CTE


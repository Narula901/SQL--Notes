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

-----------------Sales Report 
create or alter view Sale_Data as
with CTE as 
(
select [WSP Return Recd Date], [Mail intimation sent to branch Date & So Creation], 
[SO Number], [DO Number], 
[PGR Done by WSP date], [Shipmnet No.], 
[Party],[SKU Code], [Reason as mentioned by the Customer] as Reason,
[Book Qty], [Book CFC], 
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
end as [Category(SO CID)],
case 
	when [DO Execution in Days] <=1 then '0-1 days'
	when[DO Execution in Days]=2 then '2 days'
	when [DO Execution in Days] =3 then '3 days'
	else 'More than 3 days'
end as [Category(Do EID)],
cast([WSP Return Recd Date] as Date) [WSP_Return_Date_Copy]
from CTE

select * from Sale_Data

select * from [dbo].[Sales Data]
-------------------------------------------------------------------------------------

-------- Match_Box
create or alter view Match_Box as

with CTE as 
(
select cast([Shipment Creation Date]as Date) as [Shipment Creation Date] , [Shipment No], 
sum([DO Qty(Total CFC)]) as [Do QTY], sum([Pallet]) as [Pallet]
from [dbo].[OutwardThroughputK1K3]
where[Division] = 'MT'
group by [Shipment Creation Date], [Shipment No]
),
CTE_1 as
(
select *, CEILING([Pallet]) as [No. of Trips]
from CTE
)
select *, ([No. of Trips]*0.18) as Manhour
from CTE_1

----------------------------------------------

---------Detention_Gate_in_to_GR_Performance 

create or alter view Detention_GR_Data as

with CTE as
(
select * 
from [dbo].[yrv126dumpju-sep]
where [Reporting Date] is not null
),
CTE_1 as
(
select *, ([Agreed TIT] - [Actual TIT]) TIT_Difference, CONVERT(Time, [Reporting Time]) as [Updated Reporting Time]
from CTE
),
CTE_2 as
(
select *, 
case 
	when TIT_Difference < 0 then 0
	else TIT_Difference	
	end Variance,
case
	when [Actual Unloading Dat] is null then [ GR Date]
	else [Actual Unloading Dat]
	end [New Unloading Date],
case
	when [Updated Reporting Time] > '14:00:00' then dateadd(day, 1, [Reporting Date])
	else [Reporting Date]
	end [New Reporting Date]
from CTE_1
),
CTE_3 as
(
select *, FORMAT([New Reporting Date], 'dddd') AS [Week Name]
from CTE_2
),
CTE_4 as
(
select *,
case
	when [Week Name] = 'Sunday' then dateadd(day, 1, [New Reporting Date]) 
	else [New Reporting Date] 
	end [Final Reporting Date],
dateadd(day, [Variance],[New Reporting Date]) as [Last Reporting Date]
from CTE_3
),
CTE_5 as
(
select *,
case
when
	DATEDIFF(day,[New Unloading Date], [Last Reporting Date])<0 then 0
	else DATEDIFF(day,[New Unloading Date], [Last Reporting Date])
	end [Detention Days],
case
when
	DATEDIFF(day, [ GR Date], [Last Reporting Date])<0 then 0
	else DATEDIFF(day, [ GR Date], [Last Reporting Date])
	end  [GR days]
from CTE_4
),
CTE_6 as
(
select *,  
case 
	when [Detention Days] = 0 then 'Same Day'
	when [Detention Days] = 1 then 'Next Day'
	else 'Delayed'
	end [DD Performace],
case 
	when [GR days] = 0 then 'Same Day'
	when [GR days] =1 then 'Next Day'
	else 'Delayed'
	end [GR Performace]
from CTE_5
)
select * from CTE_6

-----------------------------------

-------Detention_K2_In_Out
create or alter view Detention_K2_In_Out as
select [Shipment no], [Truck No], 
sum(CFC) as CFC, sum([    Quantity]) as Quantity 
from [dbo].[K2 Inward & Outward]
group by [Shipment no], [Truck No]

select * from Detention_K2_In_Out

---------------------------------------------------------------------------------------------------------------

---------On_Time_Execution


create or alter view On_Time_Execution as
with CTE_1 as
(
select [Shipment No], [Ship-To-Party Name], 
CONVERT(Time,[Do execution Time]) as [Do execution Time],
[DO Execution Date], [Shipment Creation Date], CAST([Shipment Creation Date] as date) as Shipment_Creation_Date_Copy,
[DO Qty(Total CFC)], [Vendor Name]
from [dbo].[K1 & K3 (All Data)]
),
CTE_2 as 
(
select *,
case 
	when [DO Execution Date] = [Shipment Creation Date] then [DO Execution Date]
	when [Do execution Time] <= '06:00:00' or [Do execution Time] is null then DATEADD(day,-1,[DO Execution Date])
	when [Do execution Time] > '06:00:00' and [Do execution Time] <= '11:00:00' then [DO Execution Date]
	else DATEADD(day,1,[DO Execution Date])
	end [New DO Execution Date]
from CTE_1
),
CTE_3 as 
(
select *, DATEDIFF(DAY, [Shipment Creation Date],[New DO Execution Date]) as Days
from CTE_2
)
select * ,
case 
	when Days <=0 then 'D-1'
	when Days =1 then 'D'
	else 'D+1'
	end Category
from CTE_3






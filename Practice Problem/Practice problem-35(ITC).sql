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


-----
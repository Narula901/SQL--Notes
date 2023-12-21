

-- Add the new column to the table
ALTER TABLE [dbo].[K1 & K3 (Excel)]
ADD CFC_Pallet INT

ALTER TABLE [dbo].[K1 & K3 (Excel)]
ADD Pallet float;



-- 1 .Update the values in the new column based on the join
UPDATE [dbo].[K1 & K3 (Excel)] 
SET CFC_Pallet = I.[CFC/Pallet]
FROM [dbo].[K1 & K3 (Excel)] K
LEFT OUTER JOIN [dbo].[Item Master] I ON K.[Brand Code] = I.Item;

--2 Pallet
update [dbo].[K1 & K3 (Excel)] 
set Pallet = [Do Qty(Total CFC)] / CFC_Pallet
from [dbo].[K1 & K3 (Excel)] 


select * from [dbo].[K1 & K3 (Excel)]

---further calculation with Common table expression
with CTE as
(
select *, CAST(Pallet AS INT) as FP
from [dbo].[K1 & K3 (Excel)]
)
select month([Shipment Creation Date])as [Month], sum(FP) as Full_Pallet
from CTE
group by month([Shipment Creation Date])
order by month([Shipment Creation Date])


--- for view we can do this way
select K.*, I.[CFC/Pallet] as [CFC/Pallet]
from [dbo].[K1 & K3 (Excel)] K
left outer join [dbo].[Item Master] I
on K.[Brand Code] = I.Item

select * from [dbo].[Item Master]



-----
-----


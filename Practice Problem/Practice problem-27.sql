/*
Write a SQL query to find the second highest Unit Price from the table Order Detail
(Column name – Order_Id, Unit Price)
*/
-- SubQuery method
select max(UnitPrice) 
from [dbo].[Order Details]
where UnitPrice < (select max(UnitPrice) 
                   from [dbo].[Order Details])




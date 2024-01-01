--- Scaler user defined function 
--- Database - BikeStores 
create function ufnCurrentDate()

returns Date 

as 

begin
return cast(getdate() as date)
end

----Ques
select OrderID, CustomerID, OrderDate, ShippedDate,
[dbo].[ufnCurrentDate]() Today_Date
from 
[Sales].[Order]

---- Scenerio
select  OrderID, CustomerID, OrderDate, ShippedDate 





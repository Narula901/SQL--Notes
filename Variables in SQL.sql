--- BikeStore dataset
---ques-1
declare @myvar int = 11
select @myvar



---ques-2
declare @minprice money
set @minprice = 20000
select *
from [Sales].[OrderItem]
where LineTotal > @minprice

---ques-3
declare @AvgPrice Money

select @AvgPrice = (select avg(ListPrice) from [Production].[Product])

select ProductID,[Name],
AvgListPrice = @AvgPrice,
AvgListPriceDiff = ListPrice - @AvgPrice

from [Production].[Product]

where ListPrice>@AvgPrice

order by ListPrice asc

---ques-4
declare @Today date
set @Today = cast(GetDate() as Date)

declare @bom date
set @bom = DATEFROMPARTS(year(@Today), month(@Today),1)

declare @PreBom date
set @PreBom = dateadd(month,-1,@bom)

declare @Preyear date
set @Preyear = dateadd(day,-1,@bom)

select * 
from [dbo].[calender]
where DateValue between  @PreBom and @Preyear 


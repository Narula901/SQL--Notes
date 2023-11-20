select * from [Sales].[Order]

---Example

select YEAR(OrderDate) as [Year],month(OrderDate) as[Month],(month(OrderDate)/4)+1 as [Quarter],----(Wrong Result as Compared to Datepart for finding Quarter)
datepart(Quarter, OrderDate) as [Quarter_Month]
from [Sales].[Order]

---Analyzing Year as well as Quarter Revenue Growth

with Year_Quarter as 
(
		select YEAR(OrderDate) as [Year],
		datepart(Quarter, OrderDate) as [Quarter_Month], 
		sum(OrderTotal) as Revenue
		from [Sales].[Order]
		group by YEAR(OrderDate), datepart(Quarter, OrderDate)
)
select [Year],[Quarter_Month], format(Revenue,'C2') as Revenue,
format(lag(Revenue,4,0) over(order by [Year],[Quarter_Month]),'C2') Prev_Quar_Revenue,
case 
  when lag(Revenue,4,0) over(order by [Year],[Quarter_Month]) != 0 
  then format(((Revenue - lag(Revenue,4,0) over(order by [Year],[Quarter_Month])))/lag(Revenue,4,0) over(order by [Year],[Quarter_Month]),'P2')
else format(0,'P2')
end as Quar_on_Quar_Growth_Rate
from Year_Quarter


---Another way for more readability

with Year_Quarter as 
(
		select YEAR(OrderDate) as [Year],
		datepart(Quarter, OrderDate) as [Quarter_Month], 
		sum(OrderTotal) as Revenue
		from [Sales].[Order]
		group by YEAR(OrderDate), datepart(Quarter, OrderDate)
),
Prev_Quar_rev as 
(
select *, 
lag(Revenue,4,0) over(order by [Year], [Quarter_Month]) as Pre_Quar_rev
from Year_Quarter
)
select [Year],[Quarter_Month], format(Revenue,'C2') as Revenue, format(Pre_Quar_rev,'C2') as Pre_Quar_rev,
case 
	when Pre_Quar_rev!=0 
	then format((Revenue-Pre_Quar_rev)/(Pre_Quar_rev), 'P2')
    else format(0,'P2') 
	end as Quar_on_Quar_Growth_Rate
from Prev_Quar_rev





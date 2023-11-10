
---- Moving Averages

---- Take 3 preceeding rows without including the current row
With yearly_Revenue as
(
	select year(OrderDate) as [Year],sum(OrderTotal) as Annual_Revenue
	from [Sales].[Order]
	group by year(OrderDate)
)
select [Year], Annual_Revenue, 
avg(Annual_Revenue) over(order by [Year] rows between 3 preceding and 1 preceding) as Expected_Revenue
from yearly_Revenue

---------- Take 3 preceeding rows and also include the current row (Total 4 rows)
With yearly_Revenue as
(
	select year(OrderDate) as [Year],sum(OrderTotal) as Annual_Revenue
	from [Sales].[Order]
	group by year(OrderDate)
)
select [Year], Annual_Revenue, 
avg(Annual_Revenue) over(order by [Year] rows between 3 preceding and current row) as Expected_Revenue
from yearly_Revenue


----- Takes all the values before current rows
With yearly_Revenue as
(
	select year(OrderDate) as [Year],sum(OrderTotal) as Annual_Revenue
	from [Sales].[Order]
	group by year(OrderDate)
)
select [Year], Annual_Revenue, 
avg(Annual_Revenue) over(order by [Year] rows between unbounded preceding and current row) as Expected_Revenue
from yearly_Revenue
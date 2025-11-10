use [Practice Problems]

select * from [dbo].[sales_tbl]

create table sales_rec_cte(
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales_rec_cte values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);



option (maxrecursion);

go
select * from sales_rec_cte;

go
with CTE as
(
select min(period_start) [date], max(period_end) max_date
from sales_rec_cte
union all 
select dateadd(day, 1,[date]) as [date], max_date 
from CTE
where [date] < max_date
)
select product_id, year([date]) as report_date, sum(average_daily_sales) total_amount from CTE C
inner join sales_rec_cte on [date] between period_start and period_end
group by product_id, year([date])
order by product_id, year([date]) 
option (maxrecursion 1000);



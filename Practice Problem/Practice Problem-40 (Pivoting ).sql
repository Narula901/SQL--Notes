select * from Sales_tbl


SELECT sales_date
,sum(CASE
WHEN fruits = 'apples' THEN sold_num ELSE 0 END) AS apples
,sum(CASE
WHEN fruits = 'oranges' THEN sold_num ELSE 0 END) AS oranges
FROM sales_tbl
GROUP BY sales_date

select sales_date, 
sum(
case 
when fruits = 'apples' then sold_num else 0 end 
) as Apple 
from sales_tbl
group by sales_date

select sales_date, 
sum(case 
when fruits = 'apples' then sold_num else 0 end) as Apple ,
sum(case
when fruits = 'oranges' then sold_num else 0 end)  as Orange
from sales_tbl
group by sales_date


select * from Sales_tbl
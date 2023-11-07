CREATE TABLE Sales_tbl(
sales_date DATE,
fruits VARCHAR(25),
sold_num INTEGER
);

INSERT INTO Sales_tbl(sales_date, fruits, sold_num) VALUES
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

---- One way
with CTE as
(
select *, sold_num - Lead(sold_num, 1) over(partition by sales_date order by sales_date desc) as [Difference]
from Sales_tbl
)
select sales_date, [Difference] from CTE 
where [Difference] is not null


--- Pivoting the data

select * from sales_tbl

SELECT sales_date
,sum(CASE
WHEN fruits = 'apples' THEN sold_num ELSE 0 END) AS apples
,sum(CASE
WHEN fruits = 'oranges' THEN sold_num ELSE 0 END) AS oranges
FROM sales_tbl
GROUP BY sales_date


WITH cte AS (
SELECT sales_date
,sum(CASE
WHEN fruits = 'apples' THEN sold_num ELSE 0 END) AS apples
,sum(CASE
WHEN fruits = 'oranges' THEN sold_num ELSE 0 END) AS oranges
FROM sales_tbl
GROUP BY sales_date)
SELECT sales_date, apples - oranges AS diff
FROM cte;


select * from sales_tbl

--- Third Way
select sales_date, sum(sold_num) as apples
from sales_tbl
where fruits = 'apples'
group by sales_date

WITH cte1 AS (
SELECT sales_date, SUM(sold_num) AS total_apple
FROM sales_tbl
WHERE fruits = 'apples'
GROUP BY sales_date)
, cte2 AS (
SELECT sales_date, SUM(sold_num) AS total_oranges
FROM sales_tbl
WHERE fruits = 'oranges'
GROUP BY sales_date)
SELECT cte1.sales_date, total_apple - total_oranges AS diff
FROM cte1
INNER JOIN cte2
ON cte1.sales_date = cte2.sales_date;


select * from sales_tbl

SELECT sales_date
,sum(CASE
WHEN fruits = 'apples' THEN sold_num ELSE 0 END) AS apples
,sum(CASE
WHEN fruits = 'oranges' THEN sold_num ELSE 0 END) AS oranges
FROM sales_tbl
GROUP BY sales_date

select sales_date,
sum(case when fruits = 'apples' then sold_num 
else 0 end)
as apples,
sum(case when fruits = 'oranges' then sold_num 
else 0 end)
as Oranges
from sales_tbl
group by sales_date
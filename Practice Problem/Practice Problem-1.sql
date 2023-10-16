/*
Ques-2 Table: `Transaction`
Columns: `trans id`, `trans date`, `trans amount`
📜 Task: Fetch the `id` and `date` for every month which has the highest transaction amount. *(Note: Multiple transactions can occur on a single day by one trans id.)

*/


CREATE TABLE [Transaction] 
(
  trans_id INT PRIMARY KEY,
  trans_date DATE,
  trans_amount DECIMAL(10, 2)
);

INSERT INTO [Transaction] (trans_id, trans_date, trans_amount)
VALUES
  (101, '2023-01-05', 500.00),
  (102, '2023-01-10', 650.00),
  (201, '2023-02-12', 800.00),
  (202, '2023-02-20', 720.00),
  (301, '2023-03-18', 950.00),
  (302, '2023-03-22', 880.00),
  (401, '2023-04-24', 1200.00),
  (402, '2023-04-30', 1100.00),
  (501, '2023-05-15', 700.00),
  (502, '2023-05-18', 750.00),
  (601, '2023-06-03', 600.00),
  (701, '2023-07-29', 1400.00),
  (702, '2023-07-31', 1350.00),
  (801, '2023-08-14', 900.00),
  (802, '2023-08-18', 920.00),
  (901, '2023-09-22', 1100.00),
  (902, '2023-09-25', 1050.00),
  (1001, '2023-10-11', 800.00),
  (1002, '2023-10-15', 850.00);

 select *
  from [Transaction] 

  ;with CTE as 
  (
  select *,  month(trans_date) as [Month], max(trans_amount) over (partition by  month(trans_date) order by month(trans_date)) as maximum_amount
  from [Transaction] 
  )
  select * 
  from CTE
  where trans_amount = maximum_amount

  go
 WITH MonthlyMax AS (
  SELECT
    YEAR(trans_date) AS trans_year,
    MONTH(trans_date) AS trans_month,
    MAX(trans_amount) AS max_amount
  FROM
    [Transaction]
  GROUP BY
    YEAR(trans_date),
    MONTH(trans_date)
)

SELECT
  t.trans_id AS id,
  t.trans_date AS date
FROM
  [Transaction] t
JOIN
  MonthlyMax mm
ON
  YEAR(t.trans_date) = mm.trans_year
  AND MONTH(t.trans_date) = mm.trans_month
  AND t.trans_amount = mm.max_amount;

	
go
SELECT t1.trans_id AS id, t1.trans_date AS date
FROM [Transaction] t1
JOIN (
  SELECT
    YEAR(trans_date) AS trans_year,
    MONTH(trans_date) AS trans_month,
    MAX(trans_amount) AS max_amount
  FROM [Transaction]
  GROUP BY YEAR(trans_date), MONTH(trans_date)
) t2 ON YEAR(t1.trans_date) = t2.trans_year
     AND MONTH(t1.trans_date) = t2.trans_month
     AND t1.trans_amount = t2.max_amount;

 



 ;with CTE as 
  (
  select *,  month(trans_date) as [Month], max(trans_amount) over (partition by  month(trans_date) order by month(trans_date)) as maximum_amount
  from [Transaction] 
  )
  select trans_id, trans_date 
  from CTE
  where trans_amount = maximum_amount


-----------------------------------------------------------------------------------------------------------------------------------------------


SELECT trans_id, trans_date
FROM [Transaction]
WHERE (trans_date, trans_amount) IN (
  SELECT trans_date, MAX(trans_amount)
  FROM [Transaction]
  GROUP BY DATE_FORMAT(trans_date, '%Y-%m')
);


select * from [Transaction]
go

with CTE as 
(
select trans_date , month(trans_date) mon, trans_amount
from [Transaction]
),
CTE_1 as
(
select mon,max(trans_amount) as maxi
from CTE
group by mon
)
select C.trans_date, C.mon, C.trans_amount
from CTE C
inner join CTE_1 P
on C.mon = P.mon
where C.trans_amount = P.maxi

select *,
max(trans_amount) over (partition by month(trans_date) order by month(trans_date)) as maxi
from [Transaction]





CREATE TABLE apple_transactions (
 transaction_id INT,
 customer_id INT,
 product_name VARCHAR(255),
 transaction_timestamp DATETIME
);

INSERT INTO apple_transactions (transaction_id, customer_id, product_name, transaction_timestamp)
VALUES (1, 101, 'iPhone', '2022-08-08 12:00:00'),
    (2, 101, 'AirPods', '2022-08-08 12:00:00'),
    (3, 201, 'iPhone', '2022-08-11 00:00:00'),
    (4, 201, 'AirPods', '2022-08-12 00:00:00'),
    (5, 301, 'iPhone', '2022-09-05 00:00:00'),
    (6, 301, 'iPad', '2022-09-06 00:00:00'),
    (7, 301, 'AirPods', '2022-09-07 00:00:00');

with CTE as 
(
select *,
count(customer_id) over (partition by customer_id order by customer_id) cnt, 
case
when
DATEDIFF(day,lag(transaction_timestamp) over (partition by customer_id order by customer_id), transaction_timestamp) is null then 1
when
DATEDIFF(day,lag(transaction_timestamp) over (partition by customer_id order by customer_id), transaction_timestamp)= 0 then 1
else DATEDIFF(day,lag(transaction_timestamp) over (partition by customer_id order by customer_id), transaction_timestamp)
end as cnt_day
from apple_transactions
where product_name != 'iPad'
),
CTE_1 as
(
select customer_id
from CTE
group by customer_id
having count(*) = sum(cnt_day)
)
select
CEILING(((1.0 * count(customer_id))/(select count(distinct customer_id) from apple_transactions )* 100)) as followup_Percentage
from CTE_1


select * from apple_transactions




CREATE TABLE orders (
    OrderID INT,
    OrderDate DATE,
    CustomerID INT
);

INSERT INTO orders (OrderID, OrderDate, CustomerID)
VALUES
    (1, '2023-06-20', 1),
    (2, '2023-06-21', 2),
    (3, '2023-06-22', 3),
    (4, '2023-06-21', 1),
    (5, '2023-06-23', 3),
    (6, '2023-06-22', 1),
    (7, '2023-06-26', 4),
    (8, '2023-06-27', 4),
    (9, '2023-06-29', 4),
    (10, '2023-06-29', 5),
    (11, '2023-06-30', 5);

select * from orders

/*
Write a SQL query to find the customers who have placed orders on consecutive days.
*/
with CTE as
(
select *,
lead(OrderDate) over (partition by CustomerID order by CustomerID) as next_value,
case
when
Abs(datediff(day,OrderDate,lead(OrderDate) over (partition by CustomerID order by CustomerID))) is null then 1 
else 
Abs(datediff(day,OrderDate,lead(OrderDate) over (partition by CustomerID order by CustomerID)))
end [Difference]
from orders 
)
select CustomerID, sum([Difference]), count(*)
from CTE
group by CustomerID
having count(*) = sum([Difference])
and count(*) >1
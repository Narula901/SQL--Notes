CREATE TABLE amazon_transactions (
    id INT PRIMARY KEY,
    user_id INT,
    item VARCHAR(255),
    created_at DATETIME,
    revenue INT
);

-- Inserting sample data with different created dates
INSERT INTO amazon_transactions (id, user_id, item, created_at, revenue)
VALUES
    (1, 101, 'Laptop', '2023-10-01 08:30:00', 1000),
    (2, 102, 'Headphones', '2023-10-02 12:45:00', 50),
    (3, 103, 'Book', '2023-10-03 15:20:00', 20),
    (4, 104, 'Smartphone', '2023-10-04 18:10:00', 800),
    (5, 105, 'Coffee Maker', '2023-10-05 10:30:00', 75),
    (6, 101, 'Monitor', '2023-10-06 14:15:00', 300),
    (7, 102, 'Keyboard', '2023-10-07 16:40:00', 60),
    (8, 103, 'Desk Chair', '2023-10-08 19:05:00', 150),
    (9, 104, 'Tablet', '2023-10-09 21:25:00', 400),
    (10, 105, 'Toaster', '2023-10-10 09:50:00', 30),
    (11, 101, 'Mouse', '2023-10-11 11:15:00', 20),
    (12, 102, 'TV', '2023-10-12 13:30:00', 700),
    (13, 103, 'Blender', '2023-10-13 17:55:00', 40),
    (14, 104, 'Fitness Tracker', '2023-10-14 20:40:00', 80),
    (15, 105, 'Vacuum Cleaner', '2023-10-15 22:10:00', 120);

-- Add more rows with different created dates as need
---drop table amazon_transactions 



select * from amazon_transactions

select *, lag(created_at,1,created_at) over(partition by [user_id] order by created_at) as previous_date
from amazon_transactions


select *, lag(created_at,1,created_at) over(partition by [user_id] order by [user_id]) as previous_date
from amazon_transactions

/*
Write a query that'll identify returning active users.
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
Output a list of user_ids of these returning active users
*/

With CTE as
(
select *, datediff(day, lag(created_at,1,created_at) over(partition by [user_id] order by created_at),created_at) as diff
from amazon_transactions
)
select [user_id]
from CTE
where diff = 5
group by [user_id]


select *, lag(created_at,1,created_at) over(partition by [user_id] order by [user_id]) as previous_date
from amazon_transactions


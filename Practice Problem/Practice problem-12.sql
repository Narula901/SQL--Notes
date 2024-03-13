select * from [dbo].[iphone_tbl]

---1st Method
with CTE as
(
select [user_id] 
from [dbo].[iphone_tbl]
group by [user_id]
having count([user_id] )=1
),
CTE_1 as
(
select [user_id] 
from [dbo].[iphone_tbl]
where model = 'iphone 15'
)

select C.[user_id]  
from CTE C
inner join CTE_1 C1
on C.[user_id] = C1.[user_id]

--- 2nd Method
SELECT user_id
FROM iphone_tbl
GROUP BY user_id
HAVING COUNT(1) = 1
AND
user_id IN (SELECT user_id
FROM iphone_tbl
WHERE model = 'IPhone 15');

--- 3rd Method
SELECT user_id, sum(CASE WHEN model = 'IPhone 15' THEN 1 ELSE 0 END), count(1)
FROM iphone_tbl
GROUP BY user_id
HAVING COUNT(1) = SUM(CASE WHEN model = 'IPhone 15' THEN 1 ELSE 0 END );





----
select * from [dbo].[iphone_tbl]
with CTE as
(
select [user_id] from [dbo].[iphone_tbl]
where model = 'iphone 15'
group by [user_id] 
)
CTE_1 as
(
select [user_id] from [dbo].[iphone_tbl]
where model = 
group by [user_id] 
)


select [user_id]
from [dbo].[iphone_tbl]
group by  [user_id]
having count(*)= sum(case when model = 'iphone 15' then 1 else 0 end)

select * from [dbo].[iphone_tbl]

---Solve it Using Subquery
select * from [dbo].[iphone_tbl]
where model = 'iphone 15'
and [user_id] in (select [user_id] from [dbo].[iphone_tbl] group by [user_id] having count(*) = 1)


----Solve it with Join
with CTE as 
(
select [user_id]
from [dbo].[iphone_tbl]
group by [user_id]
having count(*) = 1
)
select P.[user_id], P.model
from [dbo].[iphone_tbl] P
inner join CTE C 
on P.[user_id] = C.[user_id]
where P.model = 'iphone 15'


 
CREATE TABLE iphone_tbl (
user_id INTEGER,
model VARCHAR(10) );

INSERT INTO iphone_tbl VALUES (
1, 'iphone 11'),
(1, 'iphone 12'),
(2, 'iphone 15'),
(3, 'iphone 12'),
(3, 'iphone 15'),
(4, 'iphone 14'),
(4, 'iphone 15'),
(5, 'iphone 13');



select * from iphone_tbl
/*
Problem Statement 1st -: Write a query to find the user who has bought iphone 15 and never bought any Iphone ?
*/
with CTE as
(
select *, count(1) over (partition by [user_id] order by [user_id]) as cnt
from iphone_tbl
)
select [user_id] 
from CTE
where cnt =1


;with CTE as 
(
select [user_id],count(1) as cnt
from iphone_tbl
group by [user_id]
having count(1) = 1
),
CTE_1 as
(
select * from iphone_tbl
where model = 'iphone 15'
)
select C.[user_id]
from CTE C 
inner join CTE_1 C1
on C.user_id = C1.user_id

select *, count(1) over (partition by [user_id] order by [user_id]) as cnt
from iphone_tbl

having count(1) = 1

and model = 'iphone 15'

select

drop table iphone_tbl

select [user_id], model, count(*) as cnt
from iphone_tbl
group by [user_id], model

with CTE as
(
select [user_id]
from iphone_tbl
group by [user_id]
having count(1) = 1
)
select C.[user_id] 
from CTE C
inner join iphone_tbl I
on C.[user_id] = I.[user_id]
where I.model = 'iphone 15' 

select * from iphone_tbl

select [user_id]
from iphone_tbl
group by [user_id]
having count(1) = sum(case when model = 'iphone 15' then 1 else 0 end)
case when model = 'iphone 15' then 1 else 0 end




with CTE_1
as
(
select user_id 
from iphone_tbl
group by user_id

)

select * from iphone_tbl

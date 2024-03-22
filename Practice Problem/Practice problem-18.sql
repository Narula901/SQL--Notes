create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries
values
('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR')
;

select * from entries

go
with CTE as
(
select name, count(address) as total_visit
from entries
group by name
),
CTE_1 as
(
select name,floor, count(floor) as most_visited
from entries
group by name, floor
),
CTE_2 as
(
select name, floor
from CTE_1
where most_visited >1
), 
CTE_3 as
(
select name, resources
from entries
group by name, resources
),
CTE_4 as
(
select name, STRING_AGG(resources, ',') resources_used
from CTE_3
group by name
)
select C.name, C.total_visit,C2.floor, C4.resources_used
from CTE C
inner join CTE_2 C2
on C.name = C2.name
inner join CTE_4 C4
on C2.name = C4.name



select 
name,
count(address) over (partition by name),
count(floor) over (partition by name, floor)
from entries

select name, resources from entries
group by name, resources
group by name,floor

select



-----Other_Method

with CTE as
(
select *,
count(floor) over (partition by [name], [floor] order by [name], [floor]) cnt,
count([name]) over (partition by [name] order by [name]) cnt_name
from entries
), 
CTE_1 as
(
select [name], resources
from entries
group by [name], resources
),
CTE_2 as
(
select [name], STRING_AGG(resources, ',') resources_used
from CTE_1
group by [name]
)
select C.[floor], C.[name], C.cnt_name, C2.resources_used
from CTE C
inner join CTE_2 C2
on C.[name] = C2.[name]
where C.cnt = (select max(cnt) from CTE)
group by C.[floor], C.[name], C.cnt_name, C2.resources_used
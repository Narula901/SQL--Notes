create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

with CTE as (
select *,
ROW_NUMBER() over (partition by city order by [name]) rn
from players_location
)
select 
max(case 
	when city = 'Bangalore' then [name] end )as Banglore, 
max(case 
	when city = 'Delhi' then [name] end )as Delhi,
max(case 
	when city = 'Mumbai' then [name] end )as Mumbai
from CTE
group by  rn


select * from players_location
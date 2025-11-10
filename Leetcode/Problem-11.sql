select * from Trips
select * from Users_trip

select [users_id] from Users_trip
where banned = 'Yes'

with CTE as (
select * from Trips
where client_id not in (select [users_id] from Users_trip where banned = 'Yes')
and driver_id not in (select [users_id] from Users_trip where banned = 'Yes')
),
CTE_1 as
(
select request_at,count(*) cancelled_tips from CTE
where status = 'cancelled_by_client'
or status = 'cancelled_by_driver'
group by request_at
),
CTE_2 as
(
select request_at,count(*) Total_trip  from CTE
group by request_at
), 
CTE_3 as
(
select CTE_2.request_at, isnull(CTE_1.cancelled_tips,0)cancelled_tips,CTE_2.Total_trip
from CTE_1 Right join CTE_2 
on CTE_1.request_at = CTE_2.request_at
)
select *, round(((1.0*cancelled_tips)/Total_trip) * 100, 2) as cancelled_percent
from CTE_3



 
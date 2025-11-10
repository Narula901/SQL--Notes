with CTE as
(
select *,  cast(Datecalled as date) as [date]
from phonelog
), 
CTE_1 as
(
select *, 
ROW_NUMBER() over(partition by [date] order by Datecalled) as lower_value, 
ROW_NUMBER() over(partition by [date] order by Datecalled) as upper_value
from CTE 
),
CTE_2 as
(
select [date], max(upper_value) maxi_value from CTE_1
group by [date]
)
select  C1.Callerid, C1.Recipientid, C1.[date]
from CTE_1 C1
inner join CTE_2 C2
on C1.[date] = C2.[date]
where C1.lower_value = 1
or C1.upper_value = C2.maxi_value
group by C1.Callerid, C1.Recipientid, C1.[date]
having count(*) > 1




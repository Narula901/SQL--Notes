create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

--Question - Get the second most recent activity
with CTE as
(
select *,
ROW_NUMBER() over (partition by username order by startDate) rn, 
count(username) over (partition by username order by username) cn
from UserActivity
)
select username, activity, startDate, endDate from CTE
where (cn > 1 and rn = 2)
or (cn = 1 and rn = 1)


select * from UserActivity

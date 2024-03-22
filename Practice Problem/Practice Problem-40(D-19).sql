

CREATE TABLE Events_table (
  business_id INT,
  event_type VARCHAR(10),
  occurences INT
);

INSERT INTO Events_table VALUES (
'1', 'reviews', 7),
('3', 'reviews', 3),
('1', 'ads', 11),
('2', 'ads', 7),
('3', 'ads', 6),
('1', 'page views', 3),
('2', 'page views', 12),
('4', 'reviews', 6);

/*

the avergae activity of a particular event_Type is the average occurences across all
companies that have this event .
note : An active business is a business that has more than one event _type such that  their 
occurences is strictly greater than the average activity for that event.

*/


select * from Events_table

with CTE_2 as
(
select event_type, round(AVG(1.0*occurences),2) [avg]
from Events_table
group by event_type
)
select E.business_id
from Events_table E
inner join CTE_2 C
on E.event_type = C.event_type
where E.occurences > C.[avg]
group by E.business_id
having count(*) >1



----Solve with the help of Window Function

with CTE as
(
select *,
AVG(occurences) over (partition by event_type)  average
from Events_table
order by  business_id         
)
select business_id
from CTE
where occurences > average
group by business_id
having count(*) >1





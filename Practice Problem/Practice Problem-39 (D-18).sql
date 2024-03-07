
---Day-18

create table quiet_student
(
student_id int,
student_name varchar(30)
);

create table Exam
(
exam_id int,
student_id int,
score int
);

INSERT INTO quiet_student VALUES (
'1', 'Daniel'),
('2', 'Jade'),
('3', 'Stella'),
('4', 'Jonathan'),
('5', 'Will');

INSERT INTO Exam VALUES (
'10', '1', '70'),
('10', '2', '80'),
('10', '3', '90'),
('20', '1', '80'),
('30', '1', '70'),
('30', '3', '80'),
('30', '4', '90'),
('40', '1', '60'),
('40', '2', '70'),
('40', '4', '80');


select * from quiet_student

select * from Exam

select S.student_id, S.student_name, count(*), max(E.score), min(E.score)
from quiet_student S
inner join Exam E
on S.student_id = E.student_id
where E.score > (select min(E.score) from Exam E)
and E.score < (select max(E.score) from Exam E)
group by S.student_id, S.student_name
having count(S.student_id)>=1

with CTE as
(
select S.student_id, S.student_name,E.exam_id,E.score,
max(E.score) over ()  Maximum, 
min(E.score) over() Minimum
from quiet_student S
inner join Exam E
on S.student_id = E.student_id
)
select student_id, student_name
from CTE
group by student_id, student_name
having min(score) != min(Minimum)
and max(score) != max(Maximum)
and count(exam_id) >=1




with cte as
(
	select exam_id,
	max(score) as max_score,
	min(score) as min_score
	from exam
	group by exam_id
)
select 
s.student_id, s.student_name
from quiet_student s
join exam e on s.student_id = e.student_id
join cte c on c.exam_id = e.exam_id
group by s.student_id, s.student_name
having count(e.exam_id)>=1
and min(e.score)!=min(c.min_score) and 
max(e.score)!=max(c.max_score)





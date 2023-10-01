CREATE TABLE students_attend (
Student_id INTEGER,
  Class_date DATE,
  Is_present INTEGER);
   
INSERT INTO students_attend VALUES (
1,'2023-03-01',1),
  (1,'2023-03-02',0),
  (1,'2023-03-03',0),
  (1,'2023-03-04',0),
  (1,'2023-03-05',1),
  (2,'2023-03-01',1),
  (2,'2023-03-02',0),
  (2,'2023-03-03',0),
  (2,'2023-03-04',1),
  (3,'2023-03-03',1),
  (3,'2023-03-04',1),
  (3,'2023-03-05',1),
  (3,'2023-03-06',1),
  (3,'2023-03-07',0);


select * from students_attend

		WITH cte AS (
		SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY class_date)
		- ROW_NUMBER() OVER(PARTITION BY student_id, Is_present ORDER BY class_date) AS x
		FROM students_attend)
		SELECT student_id, MIN(class_date) AS min_date, MAX(class_date) AS max_date, Is_present, count(1)
		FROM cte
		GROUP BY student_id, Is_present
		HAVING COUNT(1) >=3;

		SELECT *, ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY class_date),ROW_NUMBER() OVER(PARTITION BY student_id, Is_present ORDER BY class_date),
		ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY class_date)
		- ROW_NUMBER() OVER(PARTITION BY student_id, Is_present ORDER BY class_date) AS x
		FROM students_attend


		With CTE_2 as
		(
		select *,
		COALESCE(datediff(day,lag(class_date, 1) over(partition by Student_id, Is_present order by Class_date), Class_date), 1) as diff
		from students_attend
		),
		CTE_3 as
		(
		select *, 
		sum(diff) over(partition by Student_id, Is_present order by Student_id, Is_present ) as cnt
		from CTE_2
		where diff = 1
		), 
		CTE_4 as
		(
		select *, min(Class_date) over(partition by Student_id, Is_present order by Student_id, Is_present ) as min_date,
		max(Class_date) over(partition by Student_id, Is_present order by Student_id, Is_present ) as max_date
		from CTE_3
		where cnt >=3
		)
		Select Student_id, Is_present, min_date, max_date 
		from CTE_4
		group by  Student_id, Is_present, min_date, max_date 



WITH cte AS (
SELECT *,
DATE_SUB(class_date, INTERVAL COUNT(1) OVER(PARTITION BY student_id, Is_present ORDER BY class_date) DAY) AS diff
FROM students_attend
ORDER BY student_id, class_date )
SELECT student_id, MIN(class_date), MAX(class_date), Is_present
FROM cte
GROUP BY student_id, Is_present
HAVING COUNT(diff) >=3;

		WITH cte AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY student_id, Is_present ORDER BY class_date) AS rn
  FROM students_attend
)
SELECT s.student_id, MIN(s.class_date) AS start_date, MAX(s.class_date) AS end_date, s.Is_present
FROM (
  SELECT *,
         DATEADD(DAY, 1 - rn, class_date) AS group_date
  FROM cte
) AS s
GROUP BY s.student_id, s.Is_present, s.group_date
HAVING COUNT(s.group_date) >= 3;



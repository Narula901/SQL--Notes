
/*
Table: `emp`
Columns: `Emp_id`, `Emp_name`, `dob`
📜 Task: Considering a company policy where employees aged 60 or more should retire, retrieve the list of employees who will be retiring in 2024.
*/

CREATE TABLE emp (
  Emp_id INT PRIMARY KEY,
  Emp_name VARCHAR(255),
  dob DATE
);

INSERT INTO emp (Emp_id, Emp_name, dob)
VALUES
  (101, 'John Smith', '1960-03-15'),
  (102, 'Jane Doe', '1975-08-22'),
  (103, 'Michael Lee', '1955-12-10'),
  (104, 'Sarah Brown', '1962-05-28'),
  (105, 'David Clark', '1959-09-05'),
  (106, 'Emily White', '1970-02-17'),
  (107, 'Robert Kim', '1963-07-12'),
  (108, 'Lisa Davis', '1957-04-30'),
  (109, 'James Wilson', '1972-11-07'),
  (110, 'Linda Johnson', '1961-01-25');


 select *, year(dob) from emp
 where year(dob) + 60 <=2024
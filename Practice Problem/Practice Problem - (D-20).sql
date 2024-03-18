
CREATE TABLE insurance (
  PID INT,
  TIV_2015 NUMERIC(15 , 2 ),
  TIV_2016 NUMERIC(15 , 2 ),
  LAT NUMERIC(5 , 2 ),
  LON NUMERIC(5 , 2 )
);
INSERT INTO insurance VALUES(
1, 10, 5, 10, 10),
(2, 20, 20, 20, 20),
(3, 10, 30, 20, 20),
(4, 10, 40, 40, 40);




select * from insurance

with CTE_1 as
(
select LAT, LON
from insurance
group by LAT, LON
having count(*)=1
)
select cast(sum(I.TIV_2016) as int) as TIV_2016 
from insurance I
inner join CTE_1 C
on I.LAT = C.LAT and I.LON = C.LON
group by TIV_2015
having count(*)>1 
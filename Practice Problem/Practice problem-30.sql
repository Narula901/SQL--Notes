-- Create the table
CREATE TABLE TemperatureData (
    Days DATE,
    Temp FLOAT
);

-- Insert sample data
INSERT INTO TemperatureData (Days, Temp) VALUES
    ('2023-01-01', 25.0),
    ('2023-01-02', 26.5),
    ('2023-01-03', 24.8),
    ('2023-01-04', 28.2),
    ('2023-01-05', 28.2),
    ('2023-01-06', 26.8),
    ('2023-01-07', 28.5);

/*
Write a SQL query to find the days when temperature was higher than its previous dates. (Column name – Days, Temp)
*/

with Previous_day as
(
select *,
lag(Temp,1,0) over(order by Days) as Previous_Day_Temp
from TemperatureData
)
select [Days]
from Previous_day
where Temp = Previous_Day_Temp





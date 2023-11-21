/*
Write a SQL query to find the numbers which consecutively occurs 3 times. 
(Column name – id, UnitPrice)
*/
with CTE as
(
select UnitPrice,
lag(UnitPrice,1,0) over(order by UnitPrice) as Previous_value ,
lead(UnitPrice,1) over(order by UnitPrice) as Next_value
from  [dbo].[Order Details]
)
select UnitPrice, Previous_value,Next_value, count(*) as CNT
from CTE
where UnitPrice = Previous_value and UnitPrice=Next_value
group by UnitPrice, Previous_value,Next_value

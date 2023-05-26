/*
Common Table Expression (CTE) : CTE is a Temporary Result set that can be referenced within 
the Select, Insert, Update, and Delete Statement that immediately follows the CTE
It means Main Query always references the CTE.
*/

/*Question 1. Andrew Fuller, the VP of sales at Northwind, would like to do a sales campaign for existing customers. He'd like to categorize customers into
groups, based on how much they ordered in 2016. Then, depending on which group the customer is in, he will target the customer with different sales materials.
The customer grouping categories are 0 to 1,000, 1,000 to 5,000, 5,000 to 10,000, and over 10,000. We don’t want to show customers who don’t have any orders in 2016.
Order the results by CustomerID.
*/
--Solution 1. 

with Order2016 as (
select 
C.CustomerID,
C.CompanyName,
Sum(OD.Qty*OD.Price) as TotalOrderAmount
from Customers as C
join Orders as O
on O.CustomerID = C.CustomerID
join OrderDetails as OD 
on O.OrderID = OD.OrderID
where
OrderDate > '2016-01-01' 
and OrderDate< '2017-01-01'
group by
C.CustomerID,
C.CompanyName
)
Select CustomerID,
CompanyName,
TotalOrderAmount,
case
		when TotalOrderAmount>=0 and TotalOrderAmount<1000 then 'Low'
		when TotalOrderAmount>=1000 and TotalOrderAmount<5000 then 'Medium'
		when TotalOrderAmount>=5000 and TotalOrderAmount<10000 then 'High'
		when TotalOrderAmount>=10000 then 'Very High'
end CustomerGroup
from Order2016
order by CustomerID


/*Question 2. Based on the above query, show all the defined CustomerGroups, and
the percentage in each. Sort by the total in each group, in descending order*/
--Solution 2. 
with Order2016 as (
select 
C.CustomerID,
C.CompanyName,
Sum(OD.Qty*OD.Price) as TotalOrderAmount
from Customers as C
join Orders as O
on O.CustomerID = C.CustomerID
join OrderDetails as OD 
on O.OrderID = OD.OrderID
where
OrderDate > '2016-01-01'
and OrderDate< '2017-01-01'
group by
C.CustomerID,
C.CompanyName
)
CustomerGrouping as (
select 
	CustomerID,
	CompanyName,
	TotalOrderAmount,
	case
		when TotalOrderAmount>=0 and TotalOrderAmount<1000 then 'Low'
		when TotalOrderAmount>=1000 and TotalOrderAmount<5000 then 'Medium'
		when TotalOrderAmount>=5000 and TotalOrderAmount<10000 then 'High'
		when TotalOrderAmount>=10000 then 'Very High'
end CustomerGroup
from Orders2016
)
Select CustomerGroup,
	   Count(*) as TotalInGroup
	   Count(*)*1.0/(select Count(*) from CustomerGrouping
from CustomerGrouping
group by CustomerGroup
order by TotalInGroup desc
	





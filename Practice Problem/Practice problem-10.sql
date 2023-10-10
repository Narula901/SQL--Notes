
/*
Problem - Write a query to find for each date the number of different products sold and their names
*/
    

select * from Products

select sell_date, 
count(*) as NumOfUniqueProducts,
 STRING_AGG(product, ', ') AS PurchasedProducts 
from Products
group by sell_date
order by sell_date


select * from users

select * from items

select * from orders

 /*
 Write an SQL Query to find for each seller, whether the brand  of the second item (by date)
 they sold is their favourite brand. if seller is sold less than two items, 
 report the answer for the seller as no  o/p 
 seller id 2nd item fav brand  
 1 yes/no 
 2 yes/no 
 */

 with CTE as (
 select *,
 ROW_NUMBER() over (Partition by seller_id order by order_date) rn 
 from orders 
 ),
 CTE_1 as
 (
 select C.*,U.user_id, I.item_brand, U.favorite_brand from users U
 left join CTE C
 on  U.user_id = C.seller_id and C.rn = 2    ----Filter before Joining 
 left join items I
 on C.item_id = I.item_id
 )
 select user_id,
 case 
	when item_brand = favorite_brand then 'Yes'
	else 'No' end as Category
from CTE_1



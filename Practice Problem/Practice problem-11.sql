/*
Write a SQL query that reports the buyers who have purchased the product A8 but not an iPhone ?
*/


SELECT DISTINCT s.buyer_id
FROM sales_table s
JOIN product_table p ON s.product_id = p.product_id
WHERE p.product_name = 'A8'

except 

SELECT DISTINCT s2.buyer_id
  FROM sales_table s2
  JOIN product_table p2 ON s2.product_id = p2.product_id
  WHERE p2.product_name = 'iphone'


SELECT DISTINCT s.buyer_id
FROM sales_table s
JOIN product_table p ON s.product_id = p.product_id
WHERE p.product_name = 'A8'
AND s.buyer_id NOT IN (
  SELECT DISTINCT s2.buyer_id
  FROM sales_table s2
  JOIN product_table p2 ON s2.product_id = p2.product_id
  WHERE p2.product_name = 'iphone'
);



GO
with CTE_1 as
(
SELECT DISTINCT s.buyer_id
FROM sales_table s
JOIN product_table p ON s.product_id = p.product_id
WHERE p.product_name = 'A8'
),
CTE_2 as
(
SELECT DISTINCT s2.buyer_id
  FROM sales_table s2
  JOIN product_table p2 ON s2.product_id = p2.product_id
  WHERE p2.product_name = 'iphone'
)
select C1.buyer_id from CTE_1 as C1
except
select C2.buyer_id from CTE_2 as C2


go 
SELECT s.buyer_id
FROM sales_table s
INNER JOIN product_table p ON s.product_id = p.product_id
WHERE EXISTS (SELECT product_id
 FROM product_table p1
 WHERE s.product_id = p1.product_id
 AND product_name IN('A8', 'iphone'))
GROUP BY s.buyer_id
HAVING COUNT(1) = 1;


go 
SELECT DISTINCT s.buyer_id
FROM sales_table s
JOIN product_table p ON s.product_id = p.product_id
WHERE p.product_name = 'A8'
except 
SELECT DISTINCT s2.buyer_id
  FROM sales_table s2
  JOIN product_table p2 ON s2.product_id = p2.product_id
  WHERE p2.product_name = 'iphone'





 

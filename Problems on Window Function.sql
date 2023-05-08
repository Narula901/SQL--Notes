/*
Window functions in SQL are a type of analytical function that performs calculations across a set of rows that are related to the current row.
window functions operate on a "window" of rows that is defined by an OVER clause, allowing you to compute values based on specific ranges or partitions of data.

Window functions can be used to calculate running totals, rankings, percentiles, and other common statistical and analytical metrics. 
They can also be used to compare values between rows, or to perform calculations on aggregates within a group.
*/

--Question 1. Find the top 3 most ordered products in each category, along with the total number of times they have been ordered

--Solution 1. Order and Product tables are used 
SELECT
  category,
  product_name,
  order_count
FROM (
  SELECT
    category,
    product_name,
    COUNT(*) AS order_count,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS rn
  FROM orders as o
  JOIN products as p ON o.product_id = p.product_id
  GROUP BY category, product_name
) t
WHERE rn <= 3


--Question 2. For each month, find the top 5 customers who have spent the most in that month.

--Solution 2. Order and Product Tables are used
SELECT
  month,
  customer_name,
  total_spent
FROM (
  SELECT
    DATE_TRUNC('month', order_date) AS month,
    customer_id,
    customer_name,
    SUM(order_amount) AS total_spent,
    ROW_NUMBER() OVER (PARTITION BY DATE_TRUNC('month', order_date) ORDER BY SUM(order_amount) DESC) AS rn
  FROM orders
  JOIN customers ON orders.customer_id = customers.customer_id
  GROUP BY DATE_TRUNC('month', order_date), customer_id, customer_name
) t
WHERE rn <= 5


--Question 3. Write a query to Segregate all the Expensive, Mid and Cheaper Phones?

--Solution 3. Only Product Table is used.
Select Product Name,
case when X.buckets = 1 then 'Expensive Phones'
     when X.buckets = 2 then 'Mid Range Phones'
	 when X.buckets = 3 then 'Cheaper Phones'
	 End Phone_Category
from(
		select * , NTILE(3) over(order by price desc) as buckets
		from Product
		where product_category = 'Phone') X


	 
--Question 4. Write a query to display the second most expensive product under each category?

--Solution 4. Only Product Table is Used.
Select *,
NTH_VALUE(Product_Name,2) over (partition by Product_Category order by price desc range between unbounded preceding and unbounded following)
from DimProductCategory


--Question 5. Write a query that orders all employees by the calculated metric, sorted by employees with the lowest salary related to the max salary of their department?

-- Solution 5. Only Employee table is Used
SELECT 
   employee_id,
   full_name,
   department,
   salary,
   salary/MAX(salary) OVER (PARTITION BY department ORDER BY salary DESC)
			AS salary_metric
FROM employee


---Question 6. Write a SQL query to calculate the 7-day moving average of visits for each date.

---"web_traffic" Table is used
SELECT 
    date, 
    visits, 
    AVG(visits) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as seven_day_avg
FROM 
    web_traffic;






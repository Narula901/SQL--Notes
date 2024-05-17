Sales Analysis 


The Northwind database represents a fictional wholesale trading company that sells various products to customers.

Here's an overview of the tables included in the Northwind data set:












"Customers": Contains information about the company's customers, including their names, addresses, contact details, and other relevant information.

"Employees": Stores data about the employees working for the company, such as their names, titles, birth dates, hire dates, and other related details.

"Orders": Contains information about the orders placed by customers, including order IDs, order dates, customer IDs, employee IDs, and other relevant details.

"Order Details": Stores details about individual items within each order, such as product IDs, quantities, unit prices, discounts, and other related information.

"Products": Contains information about the products available for sale, including product names, suppliers, categories, unit prices, and other relevant details.

"Suppliers": Stores data about the suppliers who provide the products to the company, including supplier names, addresses, contact details, and other related information.

"Categories": Contains details about the categories to which the products belong, such as category names and descriptions.

"Shippers": Stores information about the shipping companies used by the company, including shipper names, phone numbers, and other related details.

"Employees Territories": Represents the relationship between employees and territories, linking each employee to the territories they are responsible for.

"Region": Contains information about different regions, such as region names.

"Territories": Stores details about the territories covered by the company, including territory names and region IDs

Problem 1: 
We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.

Solution: Three Tables are used: Customers, Orders, and Order Details








Problem 2: 
Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.

Solution: Three Tables are used: Customers, Orders, and Order Details

      																																	


Problem 3: 
At the end of the month, salespeople are likely to try much harder to get orders, to meet their month-end quotas. Show all orders made on the last day of the month. Order by EmployeeID and OrderID

Solution: Orders Table is Used   

                                                                                                                 								
							



Problem 4: 
Show the 10 orders with the most line items, in order of total line items.

Solution: Orders and Orders Details Table are Used   











Problem 5: 
There might be a chance that ties in the number of order details for the top 10 orders,
If yes, which orders are tied and how many order details do they have

Solution: Orders and Orders Details Table are Used   













Problem 6: 
Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered a line item on an order, with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more. Show all the OrderIDs with line items that match this, in order of OrderID

Solution: Orders Details Table are Used  
 











Problem 7: 
Based on the previous question, we now want to show details of the order, for orders that match the above criteria

Solution: Orders Details Table are Used  




Problem 8: 
Some customers are complaining about their orders arriving late. Which orders are late

Solution: Orders Table are Used p
 


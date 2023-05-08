
/*
Joins - Join is used to combine rows from two or more table based upon related column exist between them. 

There are Four types of Joins
1. Inner Join
2. Outer Join - Left Outer, Right Outer and Full Outer Join
3. Self Join
4. Cross Join   
*/

--Question 1. Write a SQL query to retrieve the names of all employees and the name of their department, along with the total number of employees in each department?

-- Solution 1. Table used for this problem are "Department" and "Employee" .

SELECT d.Name AS DepartmentName, e.FirstName + ' ' + e.LastName AS EmployeeName, COUNT(*) AS EmployeeCount
FROM Department as d
JOIN Employee as e ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name, e.FirstName, e.LastName
ORDER BY d.Name, e.LastName


-- Question 2. Write a SQL query to retrieve the names of all employees and the name of their manager, along with the number of direct reports each manager has?

--Solution 2. Only "Employee" table is used.

SELECT m.FirstName + ' ' + m.LastName AS ManagerName, e.FirstName + ' ' + e.LastName AS EmployeeName, COUNT(*) AS DirectReportCount
FROM Employee as e
JOIN Employee as m ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName, e.FirstName, e.LastName
ORDER BY m.LastName, e.LastName


-- Question 3. Write a SQL query to retrieve the names of all products and the names of their suppliers, along with the total quantity ordered for each product?

-- Solution 3. In this problem, "Product", "Product Vendor", "Vendor", Purchase Order Detail" tables are used.

SELECT p.Name AS ProductName, s.Name AS SupplierName, SUM(od.OrderQty) AS TotalQuantityOrdered
FROM Product as p
JOIN ProductVendor as pv ON p.ProductID = pv.ProductID
JOIN Vendor as s ON pv.BusinessEntityID = s.BusinessEntityID
JOIN PurchaseOrderDetail as od ON od.ProductID = p.ProductID AND od.BusinessEntityID = s.BusinessEntityID
GROUP BY p.Name, s.Name
ORDER BY p.Name


-- Question 4. Write a SQL query to return a list of all students and their enrolled courses, sorted by student name in ascending order?

-- Answer 4. "Students" and "enrollments" tables involved

SELECT s.name, e.course_name
FROM students as s
JOIN enrollments as e ON s.id = e.student_id
ORDER BY s.name ASC;


/* Question 5. Write a query to define high-value customers as those who've made at least 1
		   order with a total value (not including the discount) equal to $10,000 or
		   more. In addition to this, consider orders made in the year 2016? 
*/

--Solution 5. "Customers", "Orders" and "OrderDetails" are involved 
Select 
C.CustomerID,
C.CompanyName,
O.OrderID,
SUM(Quantity * UnitPrice) as Total_Order_Amount
From Customers as C
Join Orders as O
on O.CustomerID = C.CustomerID
Join OrderDetails as OD
on O.OrderID = OD.OrderID
Where
OrderDate >= '2016-01-01'
and OrderDate < '2017-01-01'
Group by
C.CustomerID,
C.CompanyName,
O.Orderid
Having Total_Order_Amount > 10000
Order by Total_Order_Amount DESC


--Ques - 

SELECT d.Name AS DepartmentName, e.FirstName + ' ' + e.LastName AS EmployeeName, COUNT(*) AS EmployeeCount
FROM HumanResources.Department d
JOIN HumanResources.Employee e ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name, e.FirstName, e.LastName
ORDER BY d.Name, e.LastName

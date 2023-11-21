/*
Write a SQL query to delete Duplicate rows in a table.
*/

-- Create the table
CREATE TABLE SampleTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Value INT
);

-- Insert sample data with some duplicate rows
INSERT INTO SampleTable (ID, Name, Value) VALUES
    (1, 'John', 20),
    (2, 'Alice', 15),
    (3, 'Bob', 25),
    (4, 'John', 20),  
    (5, 'Charlie', 30),
    (6, 'Alice', 15),  
    (7, 'David', 18),
    (8, 'Eva', 22),
    (9, 'John', 20), 
    (10, 'Alice', 15);  

select * from SampleTable

select Name, Value, count(*) as Duplicate_Key
from SampleTable
group by Name, Value
having count(*)=1


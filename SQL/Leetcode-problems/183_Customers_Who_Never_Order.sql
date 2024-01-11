--183 Customers Who Never Order
--JOIN
SELECT 
    name AS customers
FROM Customers AS c 
LEFT JOIN Orders AS o 
    ON c.id = o.customerid 
WHERE customerid IS NULL;

--Sub Query
SELECT name AS Customer
FROM Customers
WHERE ID NOT IN (
    SELECT CustomerId 
    FROM Orders
    );
--183 Customers Who Never Order
SELECT name as customers
FROM Customers as c left join Orders as o 
on c.id=o.customerid 
where customerid is null

SELECT name AS Customer
From Customers
WHERE ID NOT IN (Select CustomerId FROM Orders)
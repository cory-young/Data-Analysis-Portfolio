--183 Customers Who Never Order
--JOIN
SELECT name AS customers
FROM   customers AS c
       LEFT JOIN orders AS o
              ON c.id = o.customerid
WHERE  customerid IS NULL;

--Sub Query
SELECT name AS Customer
FROM   customers
WHERE  id NOT IN (SELECT customerid
                  FROM   orders); 
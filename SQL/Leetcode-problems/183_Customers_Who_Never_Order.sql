/* Write a solution to find all customers who never order anything.
Return the result table in any order. */

--Solution 1: JOIN
SELECT name AS customers
FROM   customers AS c
       LEFT JOIN orders AS o
              ON c.id = o.customerid
WHERE  customerid IS NULL;

--Solution 2: Sub Query
SELECT name AS Customer
FROM   customers
WHERE  id NOT IN (SELECT customerid
                  FROM   orders); 

-- Link: https://leetcode.com/problems/customers-who-never-order/description/
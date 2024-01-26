/* Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
The result format is in the following example. */
SELECT MAX(salary) as SecondHighestSalary 
FROM Employee 
WHERE salary < (SELECT MAX(salary) FROM Employee)

--Link: https://leetcode.com/problems/second-highest-salary/description/
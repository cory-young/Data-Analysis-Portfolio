/* Write a solution to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order. */

-- sum/count option is accepted but will not exclude null values
SELECT query_name,
       Round(Sum(rating / position) / Count(*), 2) AS quality,
       Round(Sum(CASE
                   WHEN rating < 3 THEN 1
                   ELSE 0
                 end) / Count(*) * 100, 2)         AS poor_query_percentage
FROM   queries
GROUP  BY query_name;

--Better Solution: round aggregate to exclude nulls
SELECT query_name,
       Round(Avg(rating / position), 2) AS quality,
       Round(Avg(rating < 3) * 100, 2)  AS poor_query_percentage
FROM   queries
GROUP  BY query_name; 

-- Link: https://leetcode.com/problems/queries-quality-and-percentage/description/
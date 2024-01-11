-- sum/count option this does not exclude null values
SELECT query_name,
    round(sum(rating/position)/count(*),2) AS quality, 
    round(sum(CASE WHEN rating <3 THEN 1 ELSE 0 END)/count(*)*100,2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;

--use round aggregate excludes nulls for you
SELECT query_name,
    round(avg(rating/position),2) AS quality,
    round(avg(rating <3)*100,2) AS poor_query_percentage
FROM Queries 
GROUP BY query_name;
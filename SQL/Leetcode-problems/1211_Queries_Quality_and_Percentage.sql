-- sum/count option this does not exclude null values
SELECT query_name,
round(sum(rating/position)/count(*),2) as quality, 
round(sum(case when rating <3 then 1 else 0 end)/count(*)*100,2) as poor_query_percentage
FROM Queries
Group by query_name;

--using the round aggregate excludes nulls for you
select query_name,
round(avg(rating/position),2) as quality,
round(avg(rating <3)*100,2) as poor_query_percentage
from Queries 
Group by query_name;
-- sum/count option this does not exclude null values
SELECT query_name,
       Round(Sum(rating / position) / Count(*), 2) AS quality,
       Round(Sum(CASE
                   WHEN rating < 3 THEN 1
                   ELSE 0
                 end) / Count(*) * 100, 2)         AS poor_query_percentage
FROM   queries
GROUP  BY query_name;

--use round aggregate excludes nulls for you
SELECT query_name,
       Round(Avg(rating / position), 2) AS quality,
       Round(Avg(rating < 3) * 100, 2)  AS poor_query_percentage
FROM   queries
GROUP  BY query_name; 
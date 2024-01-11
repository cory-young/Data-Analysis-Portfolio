-- 10 Worst cumulative win percentage since the 2002-2003 season. Excluding current season (2023-2024) 
SELECT Team
    , ROUND(
         SUM(W)/SUM(GP)*100,2
    ) as Win_percent 
FROM`cy-portfolio-project.NHL.team_summary`
WHERE Season 
NOT IN (
    SELECT Season 
    FROM `cy-portfolio-project.NHL.team_summary` 
    WHERE Season = 20232024
    )
GROUP BY Team
ORDER BY Win_percent ASC
LIMIT 10;
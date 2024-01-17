-- 10 Worst cumulative win percentage since the 2002-2003 season. Excluding current season (2023-2024) 
SELECT team,
       Round(Sum(w) / Sum(gp) * 100, 2) AS Win_percent
FROM  `cy-portfolio-project.nhl.team_summary`
WHERE  season NOT IN (SELECT season
                      FROM   `cy-portfolio-project.nhl.team_summary`
                      WHERE  season = 20232024)
GROUP  BY team
ORDER  BY win_percent ASC
LIMIT  10;

-- Total goals scores per season. Excluding shortened seasons.
SELECT Sum(gf) AS total_goals,
       season
FROM   `cy-portfolio-project.nhl.team_summary`
GROUP  BY season
HAVING Max(gp) = 82
ORDER  BY season; 
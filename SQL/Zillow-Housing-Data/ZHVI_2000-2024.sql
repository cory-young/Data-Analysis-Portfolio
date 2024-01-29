WITH cte AS (
  SELECT 
    sizerank, 
    regionname, 
    statename, 
    _2000_01_31 AS start_2000, 
    _2023_12_31 AS start_2024, 
    _2020_01_31 AS start_2020, 
  FROM 
    `cy-portfolio-project.Zillow_housing.Metro` 
  WHERE 
    sizerank <= 25 
    AND sizerank > 0
) 
SELECT 
  sizerank, 
  regionname, 
  statename, 
  ROUND(start_2000, 2) AS _2000, 
  ROUND(start_2020, 2) AS _2020, 
  ROUND(start_2024, 2) AS _2024, 
  ROUND(start_2020 - start_2000, 2) AS change_2000_2020, 
  ROUND(start_2024 - start_2020, 2) AS change_2020_2024, 
  ROUND(start_2024 - start_2000, 2) AS change_2000_2024 
FROM 
  cte 
ORDER BY 
  sizerank
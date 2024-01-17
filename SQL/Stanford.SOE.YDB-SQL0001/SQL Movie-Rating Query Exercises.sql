
--Q1 
--Find the titles of all movies directed by Steven Spielberg.
SELECT titles
FROM   movie
WHERE  director = "steven spielberg";

--Q2
--Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
SELECT DISTINCT M.year
FROM   movie AS M,
       rating AS R
WHERE  M.mid = R.mid
       AND R.stars >= 4
ORDER  BY M.year;

--Q3
--Find the titles of all movies that have no ratings.
SELECT DISTINCT M.title
FROM   movie AS M,
       rating AS R
WHERE  M.mid NOT IN (SELECT mid
                     FROM   rating);

--Q4
-- Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
SELECT NAME
FROM   reviewer AS r1,
       rating AS R2
WHERE  r1.rid = r2.rid
       AND ratingdate IS NULL;

--Q5
--Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
SELECT NAME  AS reviewer_name,
       title AS movie_title,
       stars,
       ratingdate
FROM   reviewer,
       movie,
       rating
WHERE  movie.mid = rating.mid;

--Q6
--For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
SELECT reviewer.NAME,
       movie.title
FROM   rating AS r1
       LEFT JOIN movie
              ON movie.mid = r1.mid
       LEFT JOIN reviewer
              ON r1.rid = reviewer.rid,
       rating AS r2
WHERE  r1.rid = r2.rid
       AND r1.mid = r2.mid
       AND r1.stars > r2.stars
       AND r1.ratingdate > r2.ratingdate;

--Q7
--For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
SELECT M1.title,
       Max(R1.stars)
FROM   movie AS M1,
       rating AS R1
WHERE  M1.mid = R1.mid
GROUP  BY title
ORDER  BY title;

--Q8
--For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title
SELECT M1.title,
       ( Max(R1.stars) - Min(R1.stars) ) AS rating_spread
FROM   movie AS M1,
       rating AS R1
WHERE  M1.mid = R1.mid
GROUP  BY title
ORDER  BY rating_spread DESC,
          M1.title;

--Q9
--Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
WITH t1
     AS (SELECT DISTINCT M1.mid,
                         Avg(R1.stars) AS avg1
         FROM   movie AS M1
                JOIN rating AS R1
                  ON M1.mid = R1.mid
         WHERE  M1.year < 1980
         GROUP  BY M1.mid),
     t2
     AS (SELECT DISTINCT M1.mid,
                         Avg(R1.stars) AS avg2
         FROM   movie AS M1
                JOIN rating AS R1
                  ON M1.mid = R1.mid
         WHERE  M1.year > 1980
         GROUP  BY M1.mid)
SELECT Avg(avg1) - Avg(avg2)
FROM   t1,
       t2; 
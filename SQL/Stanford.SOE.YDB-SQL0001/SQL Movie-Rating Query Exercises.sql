
--Q1 
--Find the titles of all movies directed by Steven Spielberg.
SELECT 
    titles
FROM 
    Movie 
WHERE 
    director = "Steven Spielberg";

--Q2
--Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
SELECT DISTINCT 
    M.year
FROM 
    Movie AS M
    , Rating AS R
WHERE 
    M.mid=R.mid
AND 
    R.stars>=4
ORDER BY 
    M.year;

--Q3
--Find the titles of all movies that have no ratings.
SELECT DISTINCT 
    M.title 
FROM 
    Movie AS M
    , Rating AS R
WHERE 
    M.mid NOT IN 
(
    SELECT 
        mID 
    FROM 
        Rating
);

--Q4
-- Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
SELECT 
    name
FROM 
    Reviewer AS r1
    , Rating AS R2
WHERE 
    r1.rID=r2.rID 
AND 
    ratingDate IS NULL;

--Q5
--Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
SELECT 
    name AS reviewer_name
    , title AS movie_title
    , stars
    , ratingDate
FROM 
    Reviewer
    , Movie
    , Rating
WHERE 
    Movie.mID = Rating.mID;

--Q6
--For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
SELECT 
    Reviewer.name
    , Movie.Title
FROM 
    Rating AS r1
LEFT JOIN Movie
    ON Movie.mID = r1.mID
LEFT JOIN Reviewer 
    ON r1.rID = Reviewer.rID
    , Rating AS r2
WHERE
    r1.rID = r2.rID AND
    r1.mID = r2.mID AND
    r1.stars > r2.stars AND
    r1.ratingDate > r2.ratingDate;

--Q7
--For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
SELECT
	M1.title
    , max(R1.stars) 
FROM
	Movie AS M1
    , Rating AS R1
WHERE 
    M1.mId=R1.mID
GROUP BY 
    title
ORDER BY 
    title;

--Q8
--For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title
SELECT
    M1.title
    , (max(R1.Stars)-min(R1.stars)) AS rating_spread
FROM
    Movie AS M1
    , Rating AS R1
WHERE
    M1.mID = R1.mID
GROUP BY
    title
ORDER BY
    rating_spread desc
    , M1.title;

--Q9
--Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
WITH
t1 AS (
    SELECT DISTINCT
        M1.mID
        , avg(R1.stars) AS avg1 
    FROM
        movie AS M1 
    JOIN 
        Rating AS R1
        on M1.mId = R1.mID
    WHERE
        M1.year < 1980
    GROUP BY 
        M1.mID
    ),
t2 AS (
    SELECT DISTINCT 
        M1.mID
        , avg(R1.stars) AS avg2
    FROM
        movie AS M1 
    JOIN 
        Rating AS R1
        ON M1.mId = R1.mID
    WHERE 
        M1.year > 1980
    GROUP BY 
        M1.mID
    )
SELECT 
    avg(avg1)-avg(avg2) 
FROM 
    t1
    , t2;
--Q1
--Find the names of all students who are friends with someone named Gabriel.
SELECT 
    name 
FROM
    Highschooler 
WHERE 
    ID 
IN (
	SELECT 
        ID1 
    FROM 
        Friend 
    WHERE 
        ID2 
    IN (
        SELECT 
            ID 
        FROM 
            Highschooler 
        WHERE 
            name = 'Gabriel'
        )
 );

--Q2
--For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
SELECT H1.name
    , H1.grade
    , H2.name
    , H2.grade
FROM 
    Highschooler AS H1
    , Likes AS L1
    , Highschooler AS H2
WHERE 
    H1.ID = L1.ID1 
 AND 
    H2.ID = L1.ID2 
 AND 
    (H1.grade-H2.grade) >= 2;

--Q3
--For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
Select 
H1.name
    , H1.grade
    , H2.name
    , H2.grade
FROM 
    Likes as L1
    , Likes as L2 
Join 
    Highschooler as H1 
ON 
    H1.ID = L1.ID1  
JOIN 
    Highschooler as H2 
ON 
    H2.ID = L1.ID2
WHERE 
    L1.ID1 = L2.ID2 
AND 
    L2.ID1 = L1.ID2 
AND
    H1.name < H2.name;

--Q4
--Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
SELECT 
    name
    , grade
FROM 
    Highschooler 
WHERE 
    ID 
NOT IN (
    SELECT 
        DISTINCT ID1 
    FROM 
        Likes
    UNION
    SELECT 
        DISTINCT ID2 
    FROM 
        Likes
    )
ORDER BY 
    grade
    , name;

--Q5
--For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
SELECT 
    H1.name
    , H1.grade
    , H2.name
    , H2.grade
FROM 
    Highschooler AS H1 
INNER JOIN
    Likes as L 
ON 
    H1.ID = L.ID1
INNER JOIN 
    Highschooler as H2 
ON 
    H2.ID = L.ID2
WHERE 
    H2.ID 
NOT IN (
    SELECT 
        DISTINCT ID1 
    FROM Likes 
    );

--Q6
--Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
SELECT 
    H1.name
    , H1.grade 
FROM 
    Highschooler AS H1
WHERE 
    H1.id 
NOT IN (
	SELECT 
        ID1 
    FROM 
        Highschooler AS H2
        , Friend AS F
	WHERE 
        H1.ID = F.ID1 
    AND 
        H2.ID = F.ID2 
    AND 
        H1.grade <> H2.grade
)
ORDER BY 
    grade
    , name;

--Q7
--For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
SELECT 
    a.name AS a_name
	, a.grade AS a_grade
	, b.name AS b_name
	, b.grade AS b_grade
	, c.name AS c_name
	, c.grade AS c_grade
FROM
    Likes 
INNER JOIN 
    Friend AS ac
ON 
    Likes.ID1 = ac.ID1
INNER JOIN 
    Friend as bc
ON 
    Likes.ID2 = bc.ID2
INNER JOIN 
    Highschooler AS a
ON 
    ac.ID1 = a.ID
INNER JOIN 
    Highschooler AS b
ON 
    bc.ID2 = b.ID
INNER JOIN 
    Highschooler AS c
ON 
    ac.ID2 = c.ID
WHERE
	ac.ID2 = bc.ID1
AND NOT EXISTS(
	SELECT *
	FROM Friend as ab
	WHERE ab.ID1 = a.ID AND ab.ID2=b.ID
)


--Q8
--Find the difference between the number of students in the school and the number of different first names.
SELECT 
    COUNT(
        *
    ) 
    - COUNT(
        DISTINCT(name)
    ) 
FROM
    Highschooler

--Q9
--Find the name and grade of all students who are liked by more than one other student.
SELECT 
    H1.name
    , H1.grade 
FROM 
    Highschooler as H1
INNER JOIN 
    Likes as L 
ON 
    H1.ID = L.ID2
GROUP BY H1.ID
HAVING 
    count(
        *
    ) > 1;
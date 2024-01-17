--Q1
--Find the names of all students who are friends with someone named Gabriel.
SELECT NAME
FROM   highschooler
WHERE  id IN (SELECT id1
              FROM   friend
              WHERE  id2 IN (SELECT id
                             FROM   highschooler
                             WHERE  NAME = 'Gabriel'));

--Q2
--For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
SELECT H1.NAME,
       H1.grade,
       H2.NAME,
       H2.grade
FROM   highschooler AS H1,
       likes AS L1,
       highschooler AS H2
WHERE  H1.id = L1.id1
       AND H2.id = L1.id2
       AND ( H1.grade - H2.grade ) >= 2;

--Q3
--For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
SELECT H1.NAME,
       H1.grade,
       H2.NAME,
       H2.grade
FROM   likes AS L1,
       likes AS L2
       JOIN highschooler AS H1
         ON H1.id = L1.id1
       JOIN highschooler AS H2
         ON H2.id = L1.id2
WHERE  L1.id1 = L2.id2
       AND L2.id1 = L1.id2
       AND H1.NAME < H2.NAME;

--Q4
--Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
SELECT NAME,
       grade
FROM   highschooler
WHERE  id NOT IN (SELECT DISTINCT id1
                  FROM   likes
                  UNION
                  SELECT DISTINCT id2
                  FROM   likes)
ORDER  BY grade,
          NAME;

--Q5
--For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
SELECT H1.NAME,
       H1.grade,
       H2.NAME,
       H2.grade
FROM   highschooler AS H1
       INNER JOIN likes AS L
               ON H1.id = L.id1
       INNER JOIN highschooler AS H2
               ON H2.id = L.id2
WHERE  H2.id NOT IN (SELECT DISTINCT id1
                     FROM   likes);

--Q6
--Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
SELECT H1.NAME,
       H1.grade
FROM   highschooler AS H1
WHERE  H1.id NOT IN (SELECT id1
                     FROM   highschooler AS H2,
                            friend AS F
                     WHERE  H1.id = F.id1
                            AND H2.id = F.id2
                            AND H1.grade <> H2.grade)
ORDER  BY grade,
          NAME;

--Q7
--For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
SELECT a.NAME  AS a_name,
       a.grade AS a_grade,
       b.NAME  AS b_name,
       b.grade AS b_grade,
       c.NAME  AS c_name,
       c.grade AS c_grade
FROM   likes
       INNER JOIN friend AS ac
               ON likes.id1 = ac.id1
       INNER JOIN friend AS bc
               ON likes.id2 = bc.id2
       INNER JOIN highschooler AS a
               ON ac.id1 = a.id
       INNER JOIN highschooler AS b
               ON bc.id2 = b.id
       INNER JOIN highschooler AS c
               ON ac.id2 = c.id
WHERE  ac.id2 = bc.id1
       AND NOT EXISTS(SELECT *
                      FROM   friend AS ab
                      WHERE  ab.id1 = a.id
                             AND ab.id2 = b.id)

--Q8
--Find the difference between the number of students in the school and the number of different first names.
SELECT Count(*) - Count(DISTINCT( NAME ))
FROM   highschooler

--Q9
--Find the name and grade of all students who are liked by more than one other student.
SELECT H1.NAME,
       H1.grade
FROM   highschooler AS H1
       INNER JOIN likes AS L
               ON H1.id = L.id2
GROUP  BY H1.id
HAVING Count(*) > 1; 
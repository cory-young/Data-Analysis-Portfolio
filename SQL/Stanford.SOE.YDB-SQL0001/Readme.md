## Relational DB SQL
Answers to Stanfords SOE.YDB-SQL0001

Executed using SQLite

Showcasing RDBM skills and SQL code best practices for ease of use

### Schema Reference
**Movie Ratings:**
- Movie(mID int, title text, year int, director text);
- Reviewer(rID int, name text);
- Rating(rID int, mID int, stars int, ratingDate date)

**Social Network:**
- Highschooler(ID int, name text, grade int);
- Friend(ID1 int, ID2 int);
- Likes(ID1 int, ID2 int);

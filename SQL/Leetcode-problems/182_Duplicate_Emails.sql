--182 Duplicate Emails
-- Example of using Having vs where
select email (select email, count(email) as c
from Person
group by email) as temp
where c > 1;

select email
from Person
group by email
having count(email)>1;
-- Having in this example is a great alternative to writing out a subquery that uses where
--In 9.sql, write a SQL query to list the names of all people who starred in a movie released in 2004, ordered by birth year.
--Your query should output a table with a single column for the name of each person.
--People with the same birth year may be listed in any order.
--No need to worry about people who have no birth year listed, so long as those who do have a birth year are listed in order.
--If a person appeared in more than one movie in 2004, they should only appear in your results once.


SELECT name FROM people WHERE id IN (
    SELECT stars.person_id FROM stars
    JOIN movies ON movies.id = stars.movie_id
    WHERE movies.year = 2004)
    ORDER BY birth;



-- the below  is to check:

--SELECT count(DISTINCT(name)) FROM people WHERE id IN (
    --SELECT stars.person_id FROM stars
    --JOIN movies ON movies.id = stars.movie_id
    --WHERE movies.year = 2004)
    --ORDER BY birth;

--gives the result that in the doc it should be count-wise, but what if they appeared in more than one movie in 2004 then they should appear more than once!

--SELECT count((name)) FROM people WHERE id IN (
    --SELECT stars.person_id FROM stars
    --JOIN movies ON movies.id = stars.movie_id
    --WHERE movies.year = 2004)
    --ORDER BY birth;

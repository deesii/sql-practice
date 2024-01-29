-- In 12.sql, write a SQL query to list the titles of all movies in which both Bradley Cooper and Jennifer Lawrence starred.
-- Your query should output a table with a single column for the title of each movie.
-- You may assume that there is only one person in the database with the name Bradley Cooper.
-- You may assume that there is only one person in the database with the name Jennifer Lawrence.

--FILTER THE MOVING IDS BY JL AND BC AND THEN GROUP AND FIND ANY COUNT OF THE AGGREGATE FUNCTION GREATER THAN ONE.

SELECT title FROM movies where ID IN(
        SELECT movie_id FROM stars
        JOIN people ON people.id = stars.person_id
        WHERE people.name = 'Jennifer Lawrence'
        OR people.name = 'Bradley Cooper'
        GROUP BY movie_id
        HAVING COUNT(movie_id) = 2);

--JOINING
--SELECT stars.movie_id FROM stars
--JOIN people ON people.id = stars.person_id
--WHERE people.name = 'Bradley Cooper');


-- ALTERNATIVE WAY OF IMPLICITLY JOINING
--SELECT movies.TITLE FROM people, stars, movies
--WHERE people.id = stars.person_id
--AND stars.movie_id = movies.id
--AND name = 'Bradley Cooper'



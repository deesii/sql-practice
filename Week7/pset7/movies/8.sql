--In 8.sql, write a SQL query to list the names of all people who starred in Toy Story.
--Your query should output a table with a single column for the name of each person.
--You may assume that there is only one movie in the database with the title Toy Story.

SELECT name FROM people WHERE id IN (
    SELECT stars.person_id FROM stars
    JOIN movies ON movies.id = stars.movie_id
    WHERE movies.title = 'Toy Story');
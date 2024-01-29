--In 13.sql, write a SQL query to list the names of all people who starred in a movie in which Kevin Bacon also starred.
--Your query should output a table with a single column for the name of each person.
--There may be multiple people named Kevin Bacon in the database. Be sure to only select the Kevin Bacon born in 1958.
--Kevin Bacon himself should not be included in the resulting list.


--1. find out the movie ids that Kevin Bacon has stared in
--2. Using the movie_id, find all stars in these movies


SELECT DISTINCT(name) FROM people WHERE id IN(
    SELECT person_id FROM stars WHERE movie_id IN (
        SELECT movie_id FROM stars
        JOIN people ON people.id = stars.person_id
        WHERE people.name = 'Kevin Bacon'
        AND people.birth = 1958)) AND people.name <> 'Kevin Bacon' ;


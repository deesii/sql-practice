--In 10.sql, write a SQL query to list the names of all people who have directed a movie that received a rating of at least 9.0.
--Your query should output a table with a single column for the name of each person.
--If a person directed more than one movie that received a rating of at least 9.0, they should only appear in your results once.



--get a list of movie ids which have ratings equal to or above 9.0
--display the director id if the movie id is in that above list
--display the name of the director if the person id is in the director id list

--below is not distinct name but matches the testing number of rows...

SELECT name FROM people WHERE id IN (
    SELECT directors.person_ID from directors WHERE directors.movie_id IN (
        SELECT movies.id FROM movies
        JOIN ratings
        ON movies.id = ratings.movie_id
        WHERE ratings.rating >= 9.0
        )
    );

--check count, noting that there are no distinct names here

--SELECT COUNT(name) FROM people WHERE id IN (
    --SELECT directors.person_ID from directors WHERE directors.movie_id IN (
        --SELECT movies.id FROM movies
        --JOIN ratings
        --ON movies.id = ratings.movie_id
        --WHERE ratings.rating >= 9.0
        --)
    --);

--if distinct:

--SELECT COUNT(DISTINCT(name)) FROM people WHERE id IN (
    --SELECT directors.person_ID from directors WHERE directors.movie_id IN (
        --SELECT movies.id FROM movies
        --JOIN ratings
        --ON movies.id = ratings.movie_id
        --WHERE ratings.rating >= 9.0
        --)
    --);


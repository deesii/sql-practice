--In 7.sql, write a SQL query to list all movies released in 2010 and their ratings, in descending order by rating. For movies with the same rating, order them alphabetically by title.
--Your query should output a table with two columns, one for the title of each movie and one for the rating of each movie.
--Movies that do not have ratings should not be included in the result.

--
SELECT ratings.rating, movies.title FROM movies
    JOIN ratings
    ON movies.id = ratings.movie_id
    WHERE movies.year = 2010
    ORDER BY
        ratings.rating DESC,
        movies.title ASC;




-- should not be using left join, as there are null values in the ratings, so using join uses inner join where there are the coreect number of rows?



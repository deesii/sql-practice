--In 11.sql, write a SQL query to list the titles of the five highest rated movies (in order) that Chadwick Boseman starred in, starting with the highest rated.
--Your query should output a table with a single column for the title of each movie.
--You may assume that there is only one person in the database with the name Chadwick Boseman.


-- get a list of the movies that Chadwick has starred in
--1. join people with stars
-- 2. Getting the list of the movie ID
--3. Linking that with the ratings table and ordering by ratings before limiting to 5
--4. Linking back to the movies table with the title

-- checking what the ratings are

--SELECT title, id from movies WHERE id IN (
   --SELECT movie_id, rating FROM ratings WHERE movie_id IN (
        --SELECT movie_id FROM stars
        --JOIN people ON people.id = stars.person_id
        --WHERE name = 'Chadwick Boseman')
        --ORDER BY ratings.rating DESC LIMIT 5);


--the reading is by the order in which the database wants to assign order so that from the 5 limited based on rating, the database takes that and
-- assgins the title of the 5 and orders by the ID (or whatever the database so choose to, the other table based on rating is "forgotten" ).

--SELECT title, id from movies WHERE id IN (
   --SELECT movie_id FROM ratings WHERE movie_id IN (
        --SELECT movie_id FROM stars
        --JOIN people ON people.id = stars.person_id
        --WHERE name = 'Chadwick Boseman')
        --ORDER BY rating DESC LIMIT 5);

--using implicit join which works to join all these tables together on specific keys
-- can use multiple select to work also... and left join i guess..

SELECT movies.title FROM people, stars, movies, ratings
WHERE people.id = stars.person_id
AND stars.movie_id = movies.id
AND movies.id = ratings.movie_id
AND name = 'Chadwick Boseman'
ORDER BY ratings.rating DESC LIMIT 5;
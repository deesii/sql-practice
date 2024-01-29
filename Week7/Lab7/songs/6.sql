--In 6.sql, write a SQL query that lists the names of songs that are by Post Malone.
--Your query should output a table with a single column for the name of each song.
--You should not make any assumptions about what Post Malone’s artist_id is.

--gives you the columns to check

-- SELECT songs.name, songs.artist_id, artists.name FROM songs JOIN artists ON songs.artist_id = artists.id WHERE artists.name = 'Post Malone';

--gives you the  exact answer:


SELECT songs.name FROM songs JOIN artists ON songs.artist_id = artists.id WHERE artists.name = 'Post Malone';
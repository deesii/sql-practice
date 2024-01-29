--In 7.sql, write a SQL query that returns the average energy of songs that are by Drake.
--Your query should output a table with a single column and a single row containing the average energy.
--You should not make any assumptions about what Drake’s artist_id is.


--within the bracket shows a list

-- IN due to multiple data

SELECT AVG(energy) AS 'Average Energy From Drake Songs' FROM songs WHERE energy IN (SELECT songs.energy FROM songs JOIN artists ON songs.artist_id = artists.id WHERE artists.name = 'Drake');
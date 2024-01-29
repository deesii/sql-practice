
-- Just a snippet because there were too many to put into here saving time ...

SELECT * FROM shows WHERE title LIKE 'B9%';
UPDATE shows SET title ='Brooklyn Nine-Nine' WHERE title LIKE 'B9%';

SELECT * FROM shows WHERE title LIKE 'The of%';
UPDATE shows SET title ='The Office' WHERE title LIKE 'The of%';

SELECT * FROM shows WHERE title LIKE 'of%';
UPDATE shows SET title ='The Office' WHERE title LIKE 'of%';

UPDATE shows SET title ='The Office' WHERE title LIKE 'thevof%';

SELECT * FROM shows WHERE title LIKE 'q%';
UPDATE shows SET title ="The Queen's Gambit" WHERE title LIKE 'q%';

SELECT * FROM shows WHERE title LIKE 'The U%';
UPDATE shows SET title ='The Untamed' WHERE title LIKE 'The U%';

SELECT DISTINCT(title) FROM shows ORDER BY title ASC;

-- Counted 79 distinct titles

SELECT COUNT(DISTINCT(title)) FROM shows ORDER BY title ASC;


-- three that were not mentioned on the page were Criminal Minds, Billions and The Great British Bake Off
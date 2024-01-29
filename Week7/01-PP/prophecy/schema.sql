CREATE TABLE students_only (
    id INTEGER,
    student_name TEXT,
    PRIMARY KEY(id)
);

CREATE TABLE house (
    house_id INTEGER,
    house_name TEXT,
    PRIMARY KEY(house_id)
);

CREATE TABLE assignment (
    student_id INTEGER,
    house INTEGER,
    FOREIGN KEY(student_id) REFERENCES students_only(id)
    FOREIGN KEY(house) REFERENCES house(house_id)
);

ALTER TABLE house
ADD head TEXT;

-- directly using insert into table queries

INSERT INTO house (house_name,head)
VALUES ('Slytherin', 'Severus Snape')

INSERT INTO house (house_name,head)
VALUES ('Gryffindor', 'Minerva McGonagall');

INSERT INTO house (house_name,head)
VALUES ('Ravenclaw', 'Filius Flitwick');

INSERT INTO house (house_name,head)
VALUES ('Hufflepuff', 'Pomona Sprout');
SELECT * FROM house;

ALTER TABLE house
RENAME COLUMN house_id TO id;

ALTER TABLE assignment
RENAME COLUMN house TO house_id;

--when altering the names of the columns, the references also change...

ALTER TABLE students_only
ALTER COLUMN student_name data_type NOT NULL;

-- cannot alter schema and add NOT NULL constraint to existing table on SQLite. Can create a new table with the constraint with coping the same structure

-- this is equivalent to doing the same as going over each row and copying over from the csv into a new database:

INSERT INTO students_only SELECT * FROM students;


-- equivalent to selecting the unique houses and the associated house head from the table of students (( in alphabetical order))

INSERT INTO house (house_name, head) SELECT DISTINCT(house) , head FROM students ORDER BY house ASC;

DELETE FROM house;

--joining the two tables students and the house so that there is an id

SELECT * FROM students JOIN house ON students.house = house.house_name;

-- want to now insert the selected items from the temporary table and insert into the assignment table:

INSERT INTO assignment(student_id) SELECT id FROM students;

-- experimenting with creating a temporary table

CREATE TABLE temp_assignment (
    student_id INTEGER,
    house_id INTEGER,
    house_name TEXT,
    PRIMARY KEY(house_id)
);

--can insert into another table selecting specific columns within another table

INSERT INTO assignment(student_id, house_name) SELECT id, house FROM students;

-- experimenting with join etc

SELECT * FROM assignment JOIN house ON temp_assignment.house_name = house.house_name;

-- adding a temporary column to the assignment (so that I could use a conditional to update the column)

ALTER TABLE assignment
ADD COLUMN house_name TEXT;

-- using conditionals to set the house_id to a specific value (updating the rows)

UPDATE assignment SET house_id = '1' WHERE house_name ='Slytherin';
UPDATE assignment SET house_id = '2' WHERE house_name ='Ravenclaw';
UPDATE assignment SET house_id = '3' WHERE house_name ='Hufflepuff';
UPDATE assignment SET house_id = '4' WHERE house_name ='Gryffindor';

-- then deleting the temporary column from the schema

ALTER TABLE assignment
DROP COLUMN house_name;

-- dropping the temporary table that ultimately did not work

DROP TABLE temp_assignment;

-- better create table

CREATE TABLE students_only (
    id INTEGER NOT NULL,
    student_name TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE house (
    house_id INTEGER,
    house_name TEXT NOT NULL,
    head TEXT NOT NULL,
    PRIMARY KEY(house_id)
);

CREATE TABLE assignment (
    id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    house INTEGER NOT NULL,
    FOREIGN KEY(student_id) REFERENCES students_only(id)
    FOREIGN KEY(house) REFERENCES house(house_id)
    PRIMARY KEY (id)
);

--in alphabetical order of the houses

UPDATE assignment SET house_id = '1' WHERE house_name ='Gryffindor';
UPDATE assignment SET house_id = '2' WHERE house_name ='Hufflepuff';
UPDATE assignment SET house_id = '3' WHERE house_name ='Ravenclaw';
UPDATE assignment SET house_id = '4' WHERE house_name ='Slytherin';

-- wanting to find out the counts of each house -id

SELECT house_id, COUNT(house_id) FROM assignment GROUP BY house_id;

--trying to join multiple tables and doing a count . Here we do the count first before the joining.

SELECT house.house_name, L.house_count FROM house
    LEFT JOIN (
    SELECT house_id, COUNT(house_id) as house_count
    FROM assignment
    GROUP BY house_id
    ) L
    ON L.house_id = house.id;

-- found it difficult to do the join first then do the count ... but the following works with the join (not left or right join)

SELECT house_name, COUNT(house_name) FROM assignment JOIN house ON assignment.house_id = house.id GROUP BY house_name;

--joining, the assignment is the table that now has all the columns, therefore after joining with house, house_name is now part of the table, therefore you can do counts

SELECT house_name FROM assignment JOIN house ON assignment.house_id = house.id;

--i.e the following: SELECT COUNT(house_name) FROM assignment JOIN house ON assignment.house_id = house.id;

SELECT COUNT(house_name) FROM assignment JOIN house ON assignment.house_id = house.id;
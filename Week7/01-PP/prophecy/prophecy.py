from cs50 import SQL
import csv

with open("students.csv", "r") as file:

    # removes the header
    #reading the content of the csv file

    contents = csv.DictReader(file)
    id = []
    student_name = []

    #iterating over every row

    db = SQL("sqlite:///roster.db")

    for row in contents:
        # connecting to the database roster.db and setting it to the variable db

        id = row["id"]
        student_name = row["student_name"]
        #id.append(row["id"])
        #student_name.append(row["student_name"])
        db.execute("INSERT INTO students_only (student_name) VALUES(?)",student_name)

    #importing the contents of the file into the specific table

    #this returns the primary key of a newly inserted rows 



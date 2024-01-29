import csv

#
with open("favorites.csv", "r") as file:

    # removes the header
    reader = csv.DictReader(file)
    scratch, c, python = 0, 0, 0
    for row in reader:
        #settting a variable [1] here is a list of the second element in the line
        favourite = row["language"]
        print(favourite)


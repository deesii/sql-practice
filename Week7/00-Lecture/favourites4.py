# Counts favorites using variables

import csv

# Open CSV file
with open("favorites.csv", "r") as file:

    # Create DictReader
    reader = csv.DictReader(file)

    # Counts
    counts = {}

    # Iterate over CSV file, counting favorites based on the problem 
    for row in reader:
        favorite = row["problem"]
        if favorite in counts:
            counts[favorite] += 1
        else:
            counts[favorite] = 1

# defining a new function which passes in language parameter, and the output is the count of that language (temporary function), in that dictionary called counts

def get_value(problem):
    return counts[problem]

# Print counts, this time based on the key [favorite], and now using sorted to sort the favourites by count i can use sorted (counts), and pass the get_value function as an argument to the sorted
# using the key = something  , you are overiding the key which was the key itself (the C , Python, Scratch )

#key = lambda : this is an anonymous function if you dont want to only create a function once

# one line version that does not need to create a function above:
# key=lambda language: counts[language]

for favorite in sorted(counts, key=get_value, reverse=True):
    print(f"{favorite}: {counts[favorite]}")
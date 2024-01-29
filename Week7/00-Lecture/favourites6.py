from cs50 import SQL


db = SQL("sqlite:///favourites.db")


favorite = input("Favorite: ")

# Search for title
rows = db.execute("SELECT COUNT(*) AS n FROM favourites WHERE problem LIKE ?", "%" + favorite + "%")

# Get first (and only) row
row = rows[0]

# Print popularity
# print(row["COUNT(*)"])
print(row["n"])
#can use n as alias
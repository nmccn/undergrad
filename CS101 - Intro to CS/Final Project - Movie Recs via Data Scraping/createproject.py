import requests
from bs4 import BeautifulSoup
import time
import random

'''Movie Object Class'''


# Each Movie will be represented as an object, so we can search/filter by attribute.
class movieObject:

    # parameterized constructor function
    def __init__(self, title, year, ageRating, duration, genre, rating, metascore, directors, castedStars):
        self.title = title  # title
        self.year = year  # Year movie came out
        self.ageRating = ageRating  # The rating for movie (PG, PG-13, etc)
        self.duration = duration  # Length of the movie
        self.genre = genre  # genre(s)
        self.rating = rating  # rating in stars
        self.metascore = metascore  # Metascore of the movie
        self.directors = directors  # directors
        self.castedStars = castedStars  # a few actors in the film


'''General Methods '''


# Create the initial Data file.
def createDataArray():
    # List for all of the movie objects
    filmsListed = []

    # Use the request library to obtain the HTML code for a web page, in this case an IMdb listing
    # This could be easily expanded by hardcoding more urls (simply changing the  start=), or by prompting the user for # of urls or something similar
    URLs = ['https://www.imdb.com/search/title/?title_type=feature&year=2019-04-01,2020-04-01&sort=num_votes,desc',
            'https://www.imdb.com/search/title/?title_type=feature&year=2019-04-01,2020-04-01&sort=num_votes,desc&start=51&ref_=adv_nxt',
            'https://www.imdb.com/search/title/?title_type=feature&year=2019-04-01,2020-04-01&sort=num_votes,desc&start=101&ref_=adv_nxt',
            'https://www.imdb.com/search/title/?title_type=feature&year=2019-04-01,2020-04-01&sort=num_votes,desc&start=151&ref_=adv_nxt',
            'https://www.imdb.com/search/title/?title_type=feature&year=2019-04-01,2020-04-01&sort=num_votes,desc&start=201&ref_=adv_nxt']

    for url in URLs:
        # Because the program takes a few seconds to respond, I thought it felt better with this simple print statement
        print("Grabbing data for 50 movies from IMDB...")
        html = requests.get(url)

        # Get the data using BS and the retrieved HTML.
        data = BeautifulSoup(html.text, features="html.parser")

        # iterate hru the HTML and write the useful information to a new textfile?
        for film in data.findAll('div', 'lister-item mode-advanced'):
            # list for the actors, to keep it a little simpler, as there tend to be several listed
            castedStars = []

            title = film.h3.a.text  # Get the title from the first </a>
            year = film.find('span', 'lister-item-year').contents[0]  # Get the year from the </span>
            if film.find('span', 'certificate'):
                ageRating = film.find('span', 'certificate').text  # Get the movie rating (PG, PG-13, R, etc)
            else:
                ageRating = 'Not Rated'
            duration = film.find('span', 'runtime').contents[0]  # Get the duration
            genre = film.find('span', 'genre').contents[0].strip()  # Get the genres
            rating = film.strong.text
            if film.find('div', 'inline-block ratings-metascore'):
                metascore = film.find('span', 'metascore').contents[0]
            else:
                metascore = 'Not Scored'

            # The directors and actors are nested stranglely in the HTML so we will need to use a loop to find them
            count = 0
            for a in film.find('p', '').findAll('a'):
                # The first listed name is the director
                if count == 0:
                    director = a.text
                # All other listed names are actor/actress
                else:
                    castedStars.append(a.text)
                count += 1

            filmsListed.append(
                movieObject(title, year, ageRating, duration, genre, rating, metascore, director, castedStars))

    print("Array created! The number of movies found is: ", len(filmsListed))
    return filmsListed


# Print the Menu
def printMenu():
    print("Nic's Movie Picker!")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    print("Enter an option: ")
    print("1. Narrow Search By Title ")
    print("2. Narrow Search By Year ")
    print("3. Narrow Search By Age Rating (PG, PG-13, etc) ")
    print("4. Narrow Search By Duration ")
    print("5. Narrow Search By Genre ")
    print("6. Narrow Search By Rating (Stars)")
    print("7. Narrow Search By Metascore (/100)")
    print("8. Narrow Search By Director ")
    print("9. Narrow Search By Actor ")
    print("0. Choose a Movie! ")


# Option 1, Narrow by Title
def narrowTitle(list):
    # temp list to store the movies not being removed
    tempList = []
    searchTitle = str(input("Enter a title: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the title isn't the searched title
        if searchTitle in x.title:
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 2, Narrow by Year
def narrowYear(list):
    # temp list to store the movies not being removed
    tempList = []
    searchYear = str(input("Enter a year: "))
    searchYear = '(' + searchYear + ')'
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the title isn't the searched year
        if searchYear == str(x.year):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 3, Narrow by Age
def narrowAgeRating(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Provide the MAXIMUM age requirement (ie. PG-13 will show PG and G,)")
    print("If the user types 'TV', the results will  be filtered by TV results here")
    searchAge = str(input("Enter an age rating: "))
    # While there are more movies to check: This loop turned to absolute CRAP real fast :(, probably should have made
    # lists of responses and corresponding ratings, but alas
    while list:
        x = list.pop()
        # if the user entered R, add all movies (and TV-)
        if 'R' in searchAge:
            tempList.append(x)
        # if the user entered 13, add everything besides R, adds TV-
        elif '13' in searchAge and 'R' not in x.ageRating:
            tempList.append(x)
        # if the user enters PG or the like (Filters out TV- as well)
        elif '13' not in searchAge and 'PG' in searchAge and (
                'R' not in x.ageRating and '13' not in x.ageRating and 'TV' not in x.ageRating):
            tempList.append(x)
        # if the user enters G, also filters TV-
        elif 'P' not in searchAge and 'G' in searchAge and (
                'R' not in x.ageRating and '13' not in x.ageRating and 'TV' not in x.ageRating
                and 'P' not in x.ageRating and 'Un' not in x.ageRating):
            tempList.append(x)
        # if the user enters TV, only TV shows will be remaining.
        elif 'TV' in searchAge and 'TV' in x.ageRating:
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 4, Narrow by Duration
def narrowDuration(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Provide the MAXIMUM duration of film (ie. 120 will runtime <= 120)")
    searchDuration = int(input("Enter a duration: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the runtime is <= the entered amount, add to the list
        test = int(x.duration[0:3].replace('m', '').strip())
        if searchDuration >= int(x.duration[0:3].replace('m', '').strip()):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 5, Narrow by Genre
def narrowGenre(list):
    # temp list to store the movies not being removed
    tempList = []
    searchGenre = str(input("Enter a genre: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the genre list contains the searched genre
        if searchGenre in str(x.genre):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 6, Narrow by Rating
def narrowRating(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Enter a decimal value for the MINIMUM number of stars (ie. 7.0): ")
    searchRating = float(input("Enter an amount of stars: "))

    # While there are more movies to check
    while list:
        x = list.pop()
        # if the rating is higher than what was searched
        if searchRating <= float(x.rating):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 7, Narrow by Metascore
def narrowMetascore(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Enter a value for the MINIMUM metascore of the film (# out of 100): ")
    searchScore = int(input("Enter a metascore: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the title isn't the searched year
        if 'Not' not in x.metascore:
            if searchScore <= int(x.metascore):
                tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 8, Narrow by Director
def narrowDirector(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Enter the first or last (or both) of a Director.")
    searchDirector = str(input("Enter a director: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the name is found in the list of directors
        if searchDirector in str(x.directors):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# Option 9, Narrow by Actor
def narrowActor(list):
    # temp list to store the movies not being removed
    tempList = []
    print("Enter the first or last (or both) of a Director.")
    searchActor = str(input("Enter an actor/actress: "))
    # While there are more movies to check
    while list:
        x = list.pop()
        # if the name is found in the list of actors
        if searchActor in str(x.castedStars):
            tempList.append(x)
    # Clear original list
    list.clear()
    # Re-populate original list
    while tempList:
        list.append(tempList.pop())
    return list


# gets and validates the user choice
def getUserChoice():
    validchoices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    userChoice = int(input("OPTION> "))
    if userChoice not in validchoices:
        print("ERROR: Please choose from [0-9]")
        print("OUTPUT ERROR")
        getUserChoice()
    else:
        return userChoice


# Option 0 and sometimes called otherwise (output film)
def outputFilm(list):
    n = time.time()
    timestamp = time.ctime(n)
    file = open("movie.txt", "a")
    print("Choosing a movie!")
    if len(list) == 1:
        file.write("The only remaining movie is : " + " " +  list[0].title + " "  + str(timestamp))
        file.write("\n")
        exit(0)
    elif len(list) == 0:
        file.write("There are no matching results! " + str(timestamp))
        file.write("\n")
        exit(0)
    else:
        movie = random.choice(list)
        file.write(movie.title + " directed by " + movie.directors + " This result was generated on: " + str(timestamp))
        file.write("\n")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    return False


# Function for asking whether or not to continue
def continueConverter(list):
    yesOptions = ["y", "ye", "yes", "yes!"]
    noOptions = ["n", "no", "no!"]
    options = yesOptions + noOptions
    print("Would you like to continue narrowing (y/n)?")
    state = str(input("CONTINUE> "))

    # while the input is not valid (yes or no) ask again
    while (state.lower() not in options):
        print("Would you like to continue narrowing (y/n)?")
        state = str(input("CONTINUE> "))

    # determine the return value
    if state.lower() in yesOptions:
        print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
        return True
    else:
        print("No longer narrowing search")
        outputFilm(list)


'''Driver Method'''


def moviePicker(masterList):
    keepGoing = True
    while keepGoing:
        # If we somehow narrow the list to be empty or only 1 movie, should exit
        printMenu()
        playerChoice = getUserChoice()
        if playerChoice == 0:
            keepGoing = outputFilm(masterList)
        elif playerChoice == 1:
            masterList = narrowTitle(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 2:
            masterList = narrowYear(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 3:
            masterList = narrowAgeRating(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 4:
            masterList = narrowDuration(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 5:
            masterList = narrowGenre(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 6:
            masterList == narrowRating(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 7:
            masterList = narrowMetascore(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 8:
            masterList = narrowDirector(masterList)
            keepGoing = continueConverter(masterList)
        elif playerChoice == 9:
            masterList = narrowActor(masterList)
            keepGoing = continueConverter(masterList)
        else:
            keepGoing = continueConverter(masterList)


# Create the data array from the URLs provided.
masterList = createDataArray()
# Run thru the user selections
moviePicker(masterList)



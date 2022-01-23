#   Nicholas McClellan
#   ​CSCI 101 – Section A
#   Python Lab 6

#Prints the menu
def printMenu():
    print("\n")
    print("Review Search & Sort: ")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    print("Enter an option: ")
    print("1. Enter a new list ")
    print("2. Deploy Binary Search ")
    print("3. Deploy Selection Sort")
    print("4. Quit ")

#gets and validates the user choice
def getUserChoice():
    validchoices = [1, 2, 3, 4]
    userChoice = int(input("OPTION> "))
    if userChoice not in validchoices:
        print("ERROR: Please choose from [1-4]")
        print("OUTPUT ERROR")
        return 0
    else:
        return userChoice

#functions to do options  1-4 (and a couple other things)
#Function for the quitting(4), prints goodbye and returns false
def quitConverter():
    print("OUTPUT Goodbye!")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    return False

#Function for asking whether or not to continue
def continueConverter():
    yesOptions = ["y", "ye", "yes", "yes!"]
    noOptions  = ["n", "no", "no!"]
    options = yesOptions + noOptions
    print("Would you like to continue (y/n)?")
    state = str(input("CONTINUE> "))

    #while the input is not valid (yes or no) ask again
    while (state.lower() not in options):
        print("Would you like to continue (y/n)?")
        state = str(input("CONTINUE> "))

    #determine the return value
    if state.lower() in yesOptions:
        print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
        return True
    else:
        quitConverter()

#Function to build the list (option 1)
def buildList():
    #start with new line
    print()
    #output prompts
    print("OPTION 1: ENTER A NEW LIST")
    print("How many items are in this list?")
    numElements = input("LIST-SIZE> ")

    #if the given size is valid, fill the array, otherwise exit.
    if numElements.isdigit() and not int(numElements) <= 0:
        #populate the list
        numElements = int(numElements)
        for i in range(numElements):
            item = input("ITEM " + str(i) + "> ")
            #if the item is a number, add to the list
            if item.isdigit():
                myList.append(int(item))
            else:
                print("ERROR: ", item, " is not a valid integer")
                print("OUTPUT ERROR")
                return 0
    else:
        print("ERROR: ", numElements, " is not a valid integer")
        print("OUTPUT ERROR")
        return 0
    return myList


#Function to deploy Binary Search (option 2)
def binarySearch(list):
    x = 2
#Function to deploy Selection Sort (option 3)
def selectionSort(list):
    x = 3

#Variable to hold the list being worked with.
myList = []
#Print the header for the converter
print("Welcome to my Search & Sort Program!")
print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
keepGoing = True
while keepGoing:
    printMenu()
    playerChoice = getUserChoice()
    if playerChoice == 4:
        keepGoing = quitConverter()
    elif playerChoice == 1:
        myList = buildList()
        print(myList)
        keepGoing = continueConverter()
    elif playerChoice == 2:
        binarySearch(myList)
        keepGoing = continueConverter()
    elif playerChoice == 3:
        selectionSort(myList)
        keepGoing = continueConverter()
    else:
        keepGoing = continueConverter()


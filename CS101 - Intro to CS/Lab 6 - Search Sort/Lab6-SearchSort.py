#   Nicholas McClellan
#   ​CSCI 101 – Section A
#   Python Lab 6

# Prints the menu
def printMenu():
    print("\n")
    print("Review Search & Sort: ")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    print("Enter an option: ")
    print("1. Enter a new list ")
    print("2. Deploy Binary Search ")
    print("3. Deploy Selection Sort")
    print("4. Quit ")


# gets and validates the user choice
def getUserChoice():
    validchoices = [1, 2, 3, 4]
    userChoice = int(input("OPTION> "))
    if userChoice not in validchoices:
        print("ERROR: Please choose from [1-4]")
        print("OUTPUT ERROR")
        return 0
    else:
        return userChoice


# functions to do options  1-4 (and a couple other things)
# Function for the quitting(4), prints goodbye and returns false
def quitConverter():
    print("OUTPUT Goodbye!")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    return False


# Function for asking whether or not to continue
def continueConverter():
    yesOptions = ["y", "ye", "yes", "yes!"]
    noOptions = ["n", "no", "no!"]
    options = yesOptions + noOptions
    print("Would you like to continue (y/n)?")
    state = str(input("CONTINUE> "))

    # while the input is not valid (yes or no) ask again
    while (state.lower() not in options):
        print("Would you like to continue (y/n)?")
        state = str(input("CONTINUE> "))

    # determine the return value
    if state.lower() in yesOptions:
        print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
        return True
    else:
        quitConverter()


# Function to build the list (option 1)
def buildList():
    # clears list before starting, incase user gives 2 different lists in 1 run
    myList.clear()
    # start with new line
    print()
    # output prompts
    print("OPTION 1: ENTER A NEW LIST")
    print("How many items are in this list?")
    numElements = input("LIST-SIZE> ")

    # if the given size is valid, fill the array, otherwise exit.
    if numElements.isdigit() and not int(numElements) <= 0:
        # populate the list
        numElements = int(numElements)
        for i in range(numElements):
            item = input("ITEM " + str(i) + "> ")
            # if the item is a number, add to the list
            if item.isdigit():
                myList.append(int(item))
            else:
                print("ERROR: ", item, " is not a valid integer")
                print("OUTPUT ERROR")
                return []
    else:
        print("ERROR: ", numElements, " is not a valid integer")
        print("OUTPUT ERROR")
        return []

    return myList


# Function to deploy Binary Search (option 2)
def binarySearch(myList):
    # check if the list is empty
    if len(myList) == 0:
        print("ERROR: Empty list! Please select option (1) to reenter a list.")
        print("OUTPUT ERROR")
        return myList

    # check if the list is sorted
    for i in range(len(myList)):
        if i > 0:
            if myList[i] < myList[i - 1]:
                print("ERROR: List unsorted! Please select option (3) to sort the list.")
                print("OUTPUT ERROR")
                return myList

    # if both checks are met, this block of code is reachable
    # variables needed for output / search
    numOfComparisons = 0
    minIndex = 0
    maxIndex = len(myList) - 1

    # print input list
    print("Input list: ", myList)

    # get number to search for
    targetNumber = int(input("BINARY-SEARCH-TARGET> "))

    # while the list is not empty?
    while (maxIndex <= len(myList)) and (minIndex >= 0):
        # increment comparison
        numOfComparisons += 1
        # find middle
        midIndex  = minIndex + (maxIndex - minIndex) // 2

        # if the number is found
        if myList[midIndex] == targetNumber:
            print("Target value ", targetNumber, "found at index ", midIndex)
            print("OUTPUT ", midIndex)
            print("Total number of comparisons: ", numOfComparisons)
            print("OUTPUT ", numOfComparisons)
            return
        # if the number is bigger than what we found
        elif targetNumber > myList[midIndex]:
            # update minIndex by shifting right of middle 1
            minIndex = midIndex + 1
        # if the number is smaller than what we found
        elif targetNumber < myList[midIndex]:
            # update maxIndex by shifting left of middle 1
            maxIndex = midIndex - 1

    print("Target ", targetNumber, " NOT found in list.")
    print("OUTPUT NOTFOUND")
    print("Total number of comparisons: ", numOfComparisons)
    print("OUTPUT ", numOfComparisons)


# Function to deploy Selection Sort (option 3)
def selectionSort(myList):
    # check if the list is empty
    if len(myList) == 0:
        print("ERROR: Empty list! Please select option (1) to reenter a list.")
        print("OUTPUT ERROR")
        return myList

    #initialize minimum val to first value
    minVal = myList[0]

    #iterate through every element in list
    for i in range(len(myList)):
        minIndex = i
        #finding minimum value
        for j in range(i + 1, len(myList)):
            if myList[minIndex] > myList[j]:
                minIndex = j
        #swapping minimum value and the last unsorted position
        #inspired by : https://stackoverflow.com/questions/2493920/how-to-switch-position-of-two-items-in-a-python-list
        myList[i], myList[minIndex] = myList[minIndex], myList[i]

    print(myList)

    return myList


# Variable to hold the list being worked with.
myList = []
# Print the header for the converter
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
        myList = selectionSort(myList)
        keepGoing = continueConverter()
    else:
        keepGoing = continueConverter()


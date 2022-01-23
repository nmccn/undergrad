#   Nicholas McClellan
#   ​CSCI 101 – Section A
#   Python Lab 7

# Prints the menu
def printMenu():
    print("\n")
    print("Simple Image Compression: ")
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    print("Enter an option: ")
    print("1. Encode Image")
    print("2. Decode Image")
    print("3. Display Image")
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


# Encode an Image(option 1)
def encodeImage():
    # start with new line
    print()
    # output prompts
    print("OPTION 1: ENCODE IMAGE")
    userString = input("ORIGINAL-STR> ")
    encodedString = ""
    previousChar = ''
    count = 1

    for char in userString:
        #if any of the characters are numbers, we print an error message and return
        if char.isdigit():
            print("ERROR: Number Compression is not supported.")
            print("OUTPUT ERROR")
            return
        #otherwise we will compress the string (atleast attempt to)
        else:
            #if the character is the same as the last char, increment our count and keep goin.
            if char == previousChar:
                count += 1
            else:
                #ignore the first pass through.
                if previousChar != '':
                    encodedString += str(count) + previousChar
                count = 1
                previousChar = char

    #add the last char + count
    encodedString += str(count) + previousChar
    #print the string when done
    print("OUTPUT " + encodedString)

# Function to deploy Binary Search (option 2)
def decodeImage():
    # start with new line
    print()
    # output prompts
    print("OPTION 2: DECODE IMAGE")
    userString = input("ENCODED-STR> ")
    count = ''
    decodedString = ""

    for char in userString:
        # if any of the characters are numbers, that is the count for the following letter
        if char.isdigit():
            #get the count as a character for now, can typecast later
            count += char
        # otherwise, a letter is printed the previous count amount of times.
        else:
            #print the found letter count amount of times.
            decodedString += int(count) * char
            #reset count
            count = ''

    # print the string when done
    print("OUTPUT " + decodedString)

# Function to deploy Selection Sort (option 3)
def displayImage():
    # start with new line
    print()
    # output prompts
    print("OPTION 3: DISPLAY IMAGE")
    userString = input("IMAGE> ")
    numRow = int(input("ROW> "))
    numCol = int(input("COLUMN> "))

    imageList = list(userString)
    #variable for the array
    imageArr = [0] * numRow

    count = 0

    #for a newline before the matrix
    print()
    ##There is no error checking here, ie, it is not gauranteed the data fills the given matrix, nor that the data will fit in the given matrix.
    for i in range(numRow):
        thisLine = ""
        for j in range(numCol):
            thisLine += imageList[count]
            count += 1
        print(thisLine)
        if(thisLine != "0"):
            imageArr.append(thisLine)

    printedList = str(imageArr)
    print("OUTPUT " + printedList)


# Print the header for the converter
print("Welcome to my Simple Encode/Decode Program")
print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
keepGoing = True
while keepGoing:
    printMenu()
    playerChoice = getUserChoice()
    if playerChoice == 4:
        keepGoing = quitConverter()
    elif playerChoice == 1:
        encodeImage()
        keepGoing = continueConverter()
    elif playerChoice == 2:
        decodeImage()
        keepGoing = continueConverter()
    elif playerChoice == 3:
        displayImage()
        keepGoing = continueConverter()
    else:
        keepGoing = continueConverter()


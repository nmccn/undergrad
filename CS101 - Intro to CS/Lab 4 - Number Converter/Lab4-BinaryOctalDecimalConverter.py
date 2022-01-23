#   Nicholas McClellan
#   ​CSCI 101 – Section A
#   Python Lab 4

#Prints the menu
def printMenu():
    print("Enter an option: ")
    print("1. Binary-Decimal Conversion ")
    print("2. Decimal-Binary Conversion ")
    print("3. Octal-Decimal Conversion  ")
    print("4. Decimal-Octal Conversion  ")
    print("5. Quit ")

#gets and validates the user choice
def getUserChoice():
    printMenu()
    validchoices = [1, 2, 3, 4, 5]
    userChoice = int(input("OPTION> "))
    if userChoice not in validchoices:
        print("ERROR: Please choose from [1-5]")
        print("OUTPUT ERROR")
        return 0
    else:
        return userChoice

#functions to do options  1-5 (and a couple other things)
#Function for the quitting(5), prints goodbye and returns false
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

#Function for Binary->Decimal (option 1)
def binaryToDecimal():
    binary = (input("BINARY-STR> "))
    validChars = [0, 1]
    result = 0
    for i in binary:
        if int(i) not in validChars:
            print("ERROR: Input", binary, " is NOT a binary number.")
            print("OUTPUT ERROR")
            return result
    #iterate backwards iterator + weight to increment
    i = len(binary) - 1
    weight = 0
    while i >= 0:
        if binary[i] == '1':
            result += 2 ** weight
        else:
            result += 0
        i -= 1
        weight += 1

    print("Binary ", binary, "is Decimal ", result)
    print("OUTPUT ", result)
    return result

#Function for Octal->Decimal (option 3)
def octalToDecimal():
    octal = (input("OCTAL-STR> "))
    validChars = [0, 1, 2, 3, 4, 5, 6, 7]
    result = 0
    for i in octal:
        if int(i) not in validChars:
            print("ERROR: Input ", octal, " is NOT an octal number.")
            print("OUTPUT ERROR")
            return result
    #iterate backwards iterator + weight to increment
    i = len(octal) - 1
    weight = 0
    while i >= 0:
        if octal[i] != '0':
            result += int(octal[i]) * (8 ** weight)
        else:
            result += 0
        i -= 1
        weight += 1

    print("Octal ", octal, "is Decimal ", result)
    print("OUTPUT ", result)
    return result

def decimalToOctal():
    origDecimal = (input("DECIMAL-STR> "))
    validChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    result = ""
    decimal = origDecimal
    for i in decimal:
        if str(i) not in validChars:
            print("ERROR: Input ", decimal, "is NOT a decimal number.")
            print("OUTPUT ERROR")
            return result

    decimal = int(decimal)
    while decimal > 0:
        remainder = decimal % 8
        decimal = decimal // 8
        result += str(remainder)

    result = result[::-1]

    print("Decimal ", origDecimal, "is Octal ", result)
    print("OUTPUT ", result)
    return result

def decimalToBinary():
    origDecimal = (input("DECIMAL-STR> "))
    validChars = [0,1,2,3,4,5,6,7,8,9]
    result = ""
    decimal = origDecimal
    for i in decimal:
        if int(i) not in validChars:
            print("ERROR: Input ", decimal, "is NOT a decimal number.")
            print("OUTPUT ERROR")
            return result

    decimal = int(decimal)
    while decimal > 0:
        remainder = decimal % 2
        decimal = decimal // 2
        result += str(remainder)

    result = result[::-1]

    print("Decimal ", origDecimal, "is Binary ", result)
    print("OUTPUT ", result)
    return result

#Print the header for the converter
print("Welcome to the Binary-Octal-Decimal Converter ")
print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
keepGoing = True
while keepGoing:
    playerChoice = getUserChoice()
    if playerChoice == 5:
        keepGoing = quitConverter()
    elif playerChoice == 1:
        result = binaryToDecimal()
        keepGoing = continueConverter()
    elif playerChoice == 3:
        result = octalToDecimal()
        keepGoing = continueConverter()
    elif playerChoice == 2:
        result = decimalToBinary()
        keepGoing = continueConverter()
    elif playerChoice == 4:
        result = decimalToOctal()
        keepGoing = continueConverter()
    else:
        keepGoing = continueConverter()


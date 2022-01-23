#   Nicholas McClellan
#   ​CSCI 101 – Section A
#   Python Lab 5


#make roundNumber work
#Prints the menu
def printMenu(roundNumber):
    print("Truth Table Generator | Round# " + str(roundNumber))
    print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
    print("Enter an option: ")
    print("1. OR Gate ")
    print("2. AND Gate ")
    print("3. XOR Gate  ")
    print("4. NOR Gate  ")
    print("5. NAND Gate ")
    print("6. Quit ")

#gets and validates the user choice
def getUserChoice():
    validchoices = [1, 2, 3, 4, 5, 6]
    userChoice = int(input("OPTION> "))
    if userChoice not in validchoices:
        print("ERROR: Please choose from [1-6]")
        print("OUTPUT ERROR")
        return 0
    else:
        return userChoice

#functions to do options  1-6 (and a couple other things)
#Function for the quitting(6), prints goodbye and returns false
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

#Function for output results of OR gate (option 1)
def orGate():
    a = 0
    b = 0
    #Prefacing this with the fact that this is the craziest way of doing this I can think of
    print("a b | OR ")
    print("==========")
    print(str(a) + " " + str(b) + " | " + str(a or b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a or b) + " | ")
    b = b - 1
    a = a + 1
    print(str(a) + " " + str(b) + " | " + str(a or b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a or b) + " | ")

#Function for output results of AND gate (option 2)
def andGate():
    a = 0
    b = 0
    #Prefacing this with the fact that this is the craziest way of doing this I can think of
    print("a b | AND ")
    print("===========")
    print(str(a) + " " + str(b) + " | " + str(a and b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a and b) + " | ")
    b = b - 1
    a = a + 1
    print(str(a) + " " + str(b) + " | " + str(a and b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a and b) + " | ")

#Function for output results of XOR gate (option 3)
def xorGate():
    a = 0
    b = 0
    #Prefacing this with the fact that this is the craziest way of doing this I can think of
    print("a b | XOR ")
    print("===========")
    print(str(a) + " " + str(b) + " | " + str(a ^ b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a ^ b) + " | ")
    b = b - 1
    a = a + 1
    print(str(a) + " " + str(b) + " | " + str(a ^ b) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(a ^ b) + " | ")

#Function for output results of NOR gate (option 4)
def norGate():
    a = 0
    b = 0
    #Prefacing this with the fact that this is the craziest way of doing this I can think of
    print("a b | NOR ")
    print("===========")
    print(str(a) + " " + str(b) + " | " + str(int(not(a or b))) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a or b))) + " | ")
    b = b - 1
    a = a + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a or b))) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a or b))) + " | ")

#Function for output results of NOR gate (option 5)
def nandGate():
    a = 0
    b = 0
    #Prefacing this with the fact that this is the craziest way of doing this I can think of
    print("a b | NAND ")
    print("============")
    print(str(a) + " " + str(b) + " | " + str(int(not(a and b))) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a and b))) + " | ")
    b = b - 1
    a = a + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a and b))) + " | ")
    b = b + 1
    print(str(a) + " " + str(b) + " | " + str(int(not(a and b))) + " | ")

#Print the header for the converter
print("Welcome to the Binary-Octal-Decimal Converter ")
print("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=")
roundNumber = 0
keepGoing = True
while keepGoing:
    printMenu(roundNumber)
    roundNumber += 1
    playerChoice = getUserChoice()
    if playerChoice == 6:
        keepGoing = quitConverter()
    elif playerChoice == 1:
        orGate()
        keepGoing = continueConverter()
    elif playerChoice == 3:
        xorGate()
        keepGoing = continueConverter()
    elif playerChoice == 2:
        andGate()
        keepGoing = continueConverter()
    elif playerChoice == 4:
        norGate()
        keepGoing = continueConverter()
    elif playerChoice == 5:
        nandGate()
        keepGoing = continueConverter()
    else:
        keepGoing = continueConverter()


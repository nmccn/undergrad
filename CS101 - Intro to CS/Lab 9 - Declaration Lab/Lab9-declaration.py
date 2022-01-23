# Nicholas McClellan
# CSCI 101 - Section A
# Python Lab 9
import random
import string

#open the file
file = open("Declaration_of_independence.txt")
#make an empty dictionary
wordFreq = dict()
#for each line in the file
for line in file:
    #make lowercase and remove leading/trailing whitespace
    line = line.lower().strip()
    #remove the punctuation
    #I learned about the translator on pythonprogramming.in for what thats worth.
    translator = str.maketrans('', '', string.punctuation)
    line = line.translate(translator)
    #split line word by word
    words = line.split(" ")

    #iterate thru every word in the line
    for word in words:
        #if already in dict, increment count
        if word in wordFreq:
            wordFreq[word] += 1
        #otherwise, start count at 1
        else:
            wordFreq[word] = 1

#initialize to 0 and loop to get a valid choice
userChoice = 0;
while userChoice != 1 and userChoice != 2:
    print("Would you like to print the number of times a specific word appears OR print the number of words fo a specific length? (1 or 2)")
    userChoice = int(input("CHOICE> "))

#if first choice
if userChoice == 1:
    count = 0
    wordToFind = input("WORD> ")
    wordToFind = wordToFind.lower()
    if wordToFind in wordFreq:
        print("The number of times", wordToFind, "appears in the document is", wordFreq.get(wordToFind))
        print("OUTPUT", wordFreq.get(wordToFind))
    else:
        print("The number of times", wordToFind, "appears in the document is: 0")
        print("OUTPUT 0")

#if second choice
if userChoice == 2:
    lengthToFind = input("LENGTH> ")
    lengthToFind = int(lengthToFind)
    #for every key in the dictionary, add the assosciated value to the running sum and the key to a list of words
    validWords = []
    totalWords = 0
    for key in wordFreq:
        if len(key) == lengthToFind:
            totalWords += wordFreq[key]
            validWords.append(key)

    print("Number to initialize the random generator:")
    seedNumber = int(input("SEED> "))
    random.seed(seedNumber)
    index = random.randint(0, len(validWords))

    if totalWords == 0:
        print("The number of words in the document with length", lengthToFind, "is:", totalWords)
        print("OUTPUT 0")
        print("No example random word of this length exists")
        print("OUTPUT ERROR")
    else:
        print("The number of words in the document with length", lengthToFind, "is:", totalWords)
        print("OUTPUT", totalWords)
        print("One example random word of this length is:", validWords[index])
        print("OUTPUT", validWords[index])







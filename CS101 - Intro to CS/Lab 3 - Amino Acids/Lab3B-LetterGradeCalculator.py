# Nicholas McClellan
# CSCI 101 – Section A
# Python Lab 3B

##prompts for all the variables
firstName = str(input("FIRSTNAME> "))
scholars = str(input("SCHOLARS> "))
weight1 = float(input("WEIGHT1> "))
weight2 = float(input("WEIGHT2> "))
grade1 = int(input("GRADE1> "))
grade2 = int(input("GRADE2> "))

##determine grade %
totalGrade = float(weight1*grade1 + weight2*grade2)
letterGrade = ''

##determine letter grade
if totalGrade >= 90:
    letterGrade = 'A'
elif totalGrade >= 80:
    letterGrade = 'B'
elif totalGrade >= 70:
    letterGrade = 'C'
elif totalGrade >= 60:
    letterGrade = 'D'
else:
    letterGrade = 'F'

##determine scholarship status
scholarship = ""
if firstName in scholars:
    if letterGrade == 'A' or letterGrade == 'B':
        scholarship = "Current"
    elif letterGrade == 'C':
        scholarship = "Probation"
    else:
        scholarship = "Terminated"
else:
    if letterGrade == 'A':
        scholarship = "New"
    else:
        scholarship = "None"
##outputs
print("OUTPUT " + str(totalGrade) + "%")
print("OUTPUT " + str(letterGrade))
print("OUTPUT " + str(scholarship))





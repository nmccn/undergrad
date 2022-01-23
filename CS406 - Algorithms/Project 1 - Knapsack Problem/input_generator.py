from random import randint
from random import seed
seed(1)
input_file = open("e4.txt", "w")
# write the weight
input_file.write("150\n")
# write number of items
input_file.write("24\n")
for i in range(24):
    value = randint(1,100)
    weight = randint(1,100)
    input_file.write(str(value) + " " + str(weight) + "\n")
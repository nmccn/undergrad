# Attempt at a greedy approach, that is we take the 'best' move at each individual step.
# General Approach
#   Start with [1,2] (Ascending elements, [1,1] is invalid)
#       If adding any known element gets us to the targer, we do that
#       Otherwise, we add the largest element that doesn't put us over target (1 will always satisfy this
#           in the worst case?)
def naive(filename):
    # Read input file
    file = open(filename, "r")
    length = int(file.readline())
    data = file.readline()
    master_array = data.split(" ")
    # convert to integers.. 
    master_array = [int(i) for i in master_array]
    # Variables for my algorithm
    my_array = []
    seen_values = [1]
    additions = 0
    idx = 0

    # attempt the naive approach, that is, always add 1
    while my_array != master_array:
        start_val = max(seen_values)
        next_val = start_val + 1
        seen_values.append(next_val)
        additions+=1
        # if the next value is in the master_array, add to my own at the same index. 
        if (next_val) == master_array[idx]:
            my_array.append(next_val)
            idx+=1
    
    print(additions)
    print(seen_values)
    print(my_array)

def greedy(filename):
    # Read input file
    file = open(filename, "r")
    length = int(file.readline())
    data = file.readline()
    master_array = data.split(" ")
    # convert to integers.. 
    master_array = [int(i) for i in master_array]
    # Variables for my algorithm
    my_array = []
    seen_values = [1]
    additions = 0
    idx = 0

    # attempt the naive approach, that is, always add 1
    while my_array != master_array:
        start_val = max(seen_values)
        #Loop to find max value that gives us <=... = is always going to be a higher number than <
        max_val = 0
        for value in seen_values:
            if start_val + value <= master_array[idx] and start_val + value > max_val:
                max_val = start_val + value
        next_val = max_val
        seen_values.append(next_val)
        additions+=1
        # if the next value is in the master_array, add to my own at the same index. 
        if (next_val) == master_array[idx]:
            my_array.append(next_val)
            idx+=1
    
    print(additions)
    print(seen_values)
    print(my_array)

#out = naive("input.txt")
out2 = greedy("input.txt")
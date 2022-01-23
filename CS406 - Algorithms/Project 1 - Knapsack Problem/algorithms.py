import time
# My attempt at implementing the two provided knapsack solutions.
class items:
    def __init__(self, value, weight):
        self.value = int(value)
        self.weight = int(weight)
    
    # Function used to sort, there might be a way to just natively use division, but alas this works fine. 
    def div(self):
        return (self.value / self.weight)

# I took some inspiration from various responses here: https://stackoverflow.com/questions/1482308/how-to-get-all-subsets-of-a-set-powerset
# The solution I went with is the one I found to be most similar to the 'copy & union' method we discussed in lecture.
def find_pset(orig_set):
    if (len(orig_set) == 0):
        return [[]]
    else:
        main_subset = []
        for small_subset in find_pset(orig_set[1:]):
            main_subset += [small_subset]
            main_subset += [[orig_set[0]] + small_subset]
        return main_subset

# The heuristic method as outlined in the assignment handout.
def heuristic(capacity, num_items, item_pairs):
    start_time = time.time()
    # the initial setting of our bag + allowed maximum weight
    knapsack = []
    allowedWeight = int(capacity)
    # sort items in decreasing order by value/weight
    item_pairs.sort(key=items.div, reverse=True)
    # the loop to determine which items we select
    for item in item_pairs:
        if (item.weight <= allowedWeight):
            knapsack.append(item)
            allowedWeight -= item.weight
    print("%s seconds \n" % (time.time() - start_time))
    return knapsack

# The exhaustive method as outlined in the assignment handout. 
def exhaustive(capacity, num_items, item_pairs):
    start_time = time.time()
    # Determine the powerset
    power_set = find_pset(item_pairs)
    knapsack = []
    bestValue = 0
    # Loop through each subset in the powerset (size = 2^n)
    for subset in power_set:
        subsetValue = 0
        subsetWeight = 0
        # Loop through each item in the subset to determine each sets weight/value
        for item in subset:
            subsetValue += item.value
            subsetWeight += item.weight
        # Comparison to determine if we have a new 'bestValue'
        if (subsetWeight <= int(capacity)) & (subsetValue > bestValue):
            bestValue = subsetValue
            knapsack = subset
    print("%s seconds \n" % (time.time() - start_time))       
    return knapsack

# Driver code, reads in the provided input file and runs the algorithm provided ( == 'e' and != 'e' for simplicity)
def read_inputf(filename, flag):
    item_pairs = []
    # open the file
    file = open(filename, "r")
    # read the max capacity + number of items
    capacity = file.readline()
    num_items = int(file.readline())
    # place the items into a container.
    for item in range(num_items):
        data = file.readline()
        item = data.split(" ")
        item_pairs.append(items(item[1], item[0]))
    # run the desired algorithm (exhaustive() or heuristic())
    if (flag == 'e'):
        return exhaustive(capacity, num_items, item_pairs)
    else:
        return heuristic(capacity, num_items, item_pairs)

# Test runs
my_sack = read_inputf("e4.txt", 'e')
# for item in my_sack:
#    print("Value: " + str(item.value) + " Weight: " + str(item.weight))
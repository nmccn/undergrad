# Project 4 - Maze Problem
#   Written By: Nicholas McClellan

# My general approach will be the following:
#   - Read # of nodes and # of roads, set up both of these data structures (2d arrays)
#   - For the next # of roads lines, build up the adjacency matrix, storing color AND line_type.
#   - After the adjacency matrix, we create a new graph of the possible paths we can take. 
#       - May need a way to determine a dead end.
#       - What if I stop after each road has been discovered? (IDK if this is valid AT ALL)
#   - Perform DFS/BFS on this new graph to travel from A -> j.

# Class for the roads, to store color and line_type.
class Road:
    def __init__(self, color, line_type):
        self.color = color
        self.line_type = line_type

# Method to get the index from the letter, probably a better way to do this but alas. 
def letter_index(letter):
    index = {'A':0, 'B':1, 'C':2, 'D':3, 'E':4, 'F':5, 'G':6, 'H':7, 'I':8, 'J':9, 'K':10, 'L':11, 'M':12, 'N':13, 'O':14, 'P':15, 'Q':16, 'R':17, 'S':18, 'T':19, 'U':20, 'V':21, 'W':22, 'X':23, 'Y':24, 'Z':25,
            'a':26, 'b':27, 'c':28, 'd':29, 'e':30, 'f':31, 'g':32, 'h':33, 'i':34, 'j':35}
    return index[letter]

# gets number of nodes and roads.
def read_input(filename):
    # list of the roads (70 roads in our case)
    list_of_roads = []
    # read in the number of towns/roads and the list of roads itself.
    with open(filename) as f:
        maze_specs = f.readline().split()
        num_nodes, num_roads = (maze_specs[0], maze_specs[1])
        list_of_roads = f.readlines()
    return num_nodes, num_roads, list_of_roads

# Setup the data structures & restructure the list of roads slightly to work with it later. 
def setup_adjmat(num_nodes, num_roads, list_of_roads):
    count = 0
    # Restructure each element of the list
    for i in range(len(list_of_roads)):
        list_of_roads[i] = list_of_roads[i].split()
    # Create adjacency matrix 
    adj_matrix = [[None for i in range(int(num_roads))] for j in range(int(num_roads))]
    # Populate the ajdacency matrix (roads are bi-directional here...?)
    for i in range(len(list_of_roads)):
        target = list_of_roads[i][1]
        for j in range(len(list_of_roads)):
            if list_of_roads[j][0] == target:
                if list_of_roads[i][2] == list_of_roads[j][2] or list_of_roads[i][3] == list_of_roads[j][3]:
                    adj_matrix[i][j] = 1
                    adj_matrix[j][i] = 1
   
    visited = [False] * int(num_roads)
    return adj_matrix, visited

def attempt_search(list_of_roads, adj_matrix, start, visited):
    q = [start]
    visited[start] = True
    while q:
        vis = q[0]
        print('(' + list_of_roads[vis][0] + ' ' + list_of_roads[vis][1] + ')', end=' ')
        q.pop(0)
        for i in range(len(list_of_roads)):
            if adj_matrix[vis][i] == 1 and not visited[i]:
                q.append(i)
                visited[i] = True

n, m, o = read_input('input.txt')
data, v = setup_adjmat(n,m,o)
print(data[49][60])
attempt_search(o, data, 0, v)
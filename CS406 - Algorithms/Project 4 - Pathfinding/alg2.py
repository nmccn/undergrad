# Project 4 - Maze Problem
#   Written By: Nicholas McClellan

# My General Approach is the following:
# 1. Read in the input file, determining the # of nodes, roads, and storing the roads in a list_of_roads.
# 2. Make a graph of all the possible connections between nodes. (This will be done in a series of smaller steps)
#   a. I create an adjacency list in the form of a dictionary to store all of the potential roads any single road may turn to, disregarding transit_color or transit_type
#   b. I create a second dictionary to store the actual graph represenation. 
#       i.  I just assume that the maze has to start using the first road, as this problem does require some sort of Initial Conditions (I.C.)
#       ii. I then iterate thru the list of roads to determine which connections in the simple_adjacencies list are actually valid (correct transit_color/transit_type & not looping)
#           A. if they are valid, add an edge (corresponds to adding the entry to my graph dictionary)
# 3. Search the created graph/dictionary using BFS/DFS to determine a path from start to finish. 
#   a. I used BFS to find the shortest path, but I also implemented DFS as it may be more 'efficient' in a computing sense. 
# 4. I will attempt to visualize the graph I made... (With the help of a some online library)

# In order to use a dictionary where the key may or may not exist yet, you need to use a default dict.
# Found this out here after several KeyErrors: https://www.geeksforgeeks.org/defaultdict-in-python/
from collections import defaultdict

# Read in # of nodes/roads and construct a list of all of the roads found in the map
def read_input(filename):
    # list of the roads
    list_of_roads = []
    # read in the number of towns/roads and the list of roads itself.
    with open(filename) as f:
        num_nodes, num_roads = f.readline().split()
        list_of_roads = f.readlines()
    # Restructure each element of the list, so that the color/cart can be indexed.
    for i in range(len(list_of_roads)):
        list_of_roads[i] = list_of_roads[i].split()
    return num_nodes, num_roads, list_of_roads

# Parse the list of roads and create simple_Adj list as well as the actual graph representation of the maze. 
def make_graph(list_of_roads):
    # Dictionary of simple adjacencys, not accounting for anything such as color/cart. And Another for the graph representation. 
    simple_adj = defaultdict(list)
    graph = defaultdict(list)
    for i in range(len(list_of_roads)):
        # roads are bidirectional
        simple_adj[list_of_roads[i][0]].append((list_of_roads[i][1], list_of_roads[i][2], list_of_roads[i][3]))
        simple_adj[list_of_roads[i][1]].append((list_of_roads[i][0], list_of_roads[i][2], list_of_roads[i][3]))
    # Run thru the list of roads and find all tru adjacencies.
    for i in range(len(list_of_roads)):
        # initial conditions will be the first entry, i=0, obviously.
        if i == 0:
            graph[list_of_roads[i][i]] = [list_of_roads[i][i]+list_of_roads[i][i+1]]
        else:
            # evaluate both directions... A->B is not the same path as B->A, the conditions could be different, etc. 
            for targ, color, line in simple_adj[list_of_roads[i][0]]:
                if (targ != list_of_roads[i][1]) and (color == list_of_roads[i][2] or line == list_of_roads[i][3]):
                    graph[targ+list_of_roads[i][0]].append(list_of_roads[i][0]+list_of_roads[i][1])
            for targ, color, line in simple_adj[list_of_roads[i][1]]:
                if (targ != list_of_roads[i][0]) and (color == list_of_roads[i][2] or line == list_of_roads[i][3]):
                    graph[targ+list_of_roads[i][1]].append(list_of_roads[i][1]+list_of_roads[i][0])
    return graph

# BFS - Find Shortest Path... follows the algorithm found here: https://www.geeksforgeeks.org/building-an-undirected-graph-and-finding-shortest-path-using-dictionaries-in-python/
def shortest_path(graph, start, end):
    # nodes visited
    explored = []
    # nodes to assess
    queue = [[start]]
    # While there are still nodes to check
    while queue:
        # pop the most shallow
        path = queue.pop(0)
        node = path[-1]
        if node not in explored:
            # get adjacent nodes
            adj_list = graph[node]
            for adj in adj_list:
                # add to a path
                new_path = list(path)
                new_path.append(adj)
                queue.append(new_path)
                # if the path contains our destination
                if adj == end:
                    #print(" ", *new_path)
                    return new_path
            # add node to the list of checked nodes.
            explored.append(node)
    # If a path hasn't been found yet, there is no path. 
    print("No such path.\n")

# pretty print function for the path the maze takes, this just makes the printed path match the expected format... I used road instead of villages as my vertices. 
def pprint_path(path):
    # For each entry in the list of vertices, the 'node' visited is the shared element of the road...
    for i in range(len(path)):
        if i != 0:
            path[i] = path[i][1:]
    for hop in path:
        print (hop, end=' ')
    print('\n')
    return path


a,b, c = read_input('input.txt')
g = make_graph(c)
p = shortest_path(g, 'A', 'ij')
p2 = pprint_path(p)

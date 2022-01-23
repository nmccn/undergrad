# Project 3 - DP Trebuchet Project
# Written By: Nicholas McClellan
import math
import time

# Recursive algorithm, derived straight from the handout
def recursive_alg(p, t):
    # base cases
    if p == 1:
        return t
    if t == 0:
        return 0 
    if t == 1:
        return 1
    # recursive step [ x is between 1 and t, inclusive ], it is the loop variable
    maxes = []
    for i in range(1, t+1, 1):
        # We want 2x recursive calls here?
        maxes.append(max(recursive_alg(p-1, i-1), recursive_alg(p, t-i)))
    return 1 + min(maxes)

def dp_alg(p, t):
    visited = []
    # Table to avoid recomputation & to support traceback
    dp_table = traceback_table = [[None for i in range(t+1)] for j in range(p+1)]
    traceback_table = [[None for i in range(t+1)] for j in range(p+1)]
    # Values for the dp_table entry and the target value
    dp_entry, target = None, None
    # Nested loop to avoid calculating any entry more than once. 
    for j in range(t + 1):
        for i in range(p + 1):
            # Base cases, both theassosciated  target and dp_entry  
            if i == 1:
                dp_entry = j
                target = 1
            elif j == 1:
                dp_entry = 1
                target = 1
            elif j == 0:
                dp_entry = 0
                target = 0
            # Otherwise, we need to calculate the new value based on values already calculated in the table. 
            else:
                # An arbitrarily high value for the predetermined minimum and an index
                #   - terrible practice but I couldn't remember how to get infinity to work in python. 
                min_val = 10000
                min_idx = None
                # loop to find minimum number of throws, and the index we found that at.
                for x in range(1, j + 1):
                    throws = max(dp_table[i - 1][x - 1], dp_table[i][j - x])
                    if throws < min_val:
                        min_val = throws
                        min_idx = x
                target = min_idx
                dp_entry = 1 + min_val
            #Update both tables with their respective entries, done only once per entry.
            traceback_table[i][j] = target
            dp_table[i][j] = dp_entry
    traceback(p, t, 0, traceback_table, visited)
    print(dp_table[p][t])
    for i in visited:
        print(i, end=" ")
    return 

def traceback(p,t, adj_targ, traceback_table, visited):
    # As an aside, these 'tie-breaker' rules I'm not really sure are important here, I was getting consistent outputs (?)
    # ALWAYS START AT BOTTOM RIGHT ELEMENT
    target = traceback_table[p][t]
    # Still need to consider the 'base cases'
    visited.append(target + adj_targ)
    if t == 1 or t == 0 or p == 1:
        return target
    # if the pumpkin were to explode, we would consider the subproblem t(p-1, i-1), but this is never the case here (?)
    # elif target.exploded:
    # traceback(p-1, t-1, target+adj_targ, traceback_table, visited)
    # always t(p, t-x) [BECASUE THE PUMPKIN NEVER EXPLODES] (move left the value we just used # of times)
    else:
        traceback(p, t - target, target+adj_targ, traceback_table, visited)



start_time = time.time()
print(dp_alg(8, 1600))
print("--- %s seconds ---" % (time.time() - start_time))






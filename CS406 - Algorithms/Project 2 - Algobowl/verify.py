# An attempt at a script to verify any given output/input file combination.
# In general, the verifier should do the following:
#   - Compare the number of additions with the number of lines in the file (reporting the correct # of additions)
#   - Ensure that the target array is contained in the array of seen values (solution arrives at the correct result)
#   - Determine whether any line contains a number not previously computed (operations may appear in any order in the output, as long as it appears after the two operations that compute its operands. )

def verify(infile, outfile):
    # Read input file
    input_file = open(infile, "r")
    length = int(input_file.readline())
    master_array = input_file.readline().split(" ")
    # convert to integers.. 
    master_array = [int(i) for i in master_array]
    # Read in the output file & compare number of lines/additions
    output_file = open(outfile, "r")
    num_additions = int(output_file.readline())
    addition_list = []
    for i in range(num_additions):
        addition = output_file.readline().strip().split()
        # too few additions (we read in a blank line)
        if addition == []:
            print("too few additions")
            return False
        else:
            addition_list.append(addition)
    # too many additions
    if output_file.readline():
        print("too many additions")
        return False
    # determine if the additions provided are valid
    if addition_list[0] != ['1', '1']:
        print("first addition not 1 + 1 ")
        return False
    seen_values = [1, 2] 
    for pair in addition_list:
        # check if the values being added have been used, and then add the sum to seen_values
        if int(pair[0]) in seen_values and int(pair[1]) in seen_values:
            seen_values.append(int(pair[0]) + int(pair[1]))
        else:
            print("bad number used in summation")
            return False
    # last, we check if all elements of master_array are contained in seen_values... which would mean we found the target array.
    for num in master_array:
        if num in seen_values:
            continue
        else:
            print("the target array was not reached")
            print(num)
            return False
    return True

# Driver code to test each groups code
print(verify("files/input_group244.txt", "files/output_from_250_to_244.txt"))
print(verify("files/input_group247.txt", "files/output_from_250_to_247.txt"))
print(verify("files/input_group252.txt", "files/output_from_250_to_252.txt"))
print(verify("files/input_group253.txt", "files/output_from_250_to_253.txt"))

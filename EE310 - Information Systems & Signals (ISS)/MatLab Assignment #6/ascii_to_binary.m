function [bin_rep] = ascii_to_binary(myString)
%ASCII_TO_BINARY Generate output for string characters in binary
% the requirement was to output the binary representation in 8-bits
%
% myString = string given to the function, to be converted to binary
% 
% bin_rep = binary representation of the string (or character if length=1)
%%%%%%%%%%%%%%% put your code here %%%%%%%%%%%%%%%%%%%
%%convert to ascii
myString = abs(myString);
temp_vec = [];
loop_size = strlength(myString);
for i = 1:loop_size
   temp_bin = dec2bin(myString(i), 8);
   temp_vec = [temp_vec, temp_bin];
end
bin_rep = temp_vec;
end


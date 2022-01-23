function maxVal = mymax(bound, x)
maxVal = 0;
%maxVal function will find the maximum value (below the given bound) in
%vector x.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%usage:
%maxVal = mymax(bound, x)
%inputs:
%bound is the highest number we are concerned with checking for
%x is the vector of data being input
%outputs:
%maxVal is the maximum value found in the vector

%first check if the number of inputs is even correct, ie. 2
if nargin<2
    error("Incorrect number of inputs provided");
    return
end

%another check, this time to see if the inputs are of a valid size
if size(bound, 1) > 1 || size(bound, 2) > 1
    error("Incorrect dimension on the given boundary");
    return
end

if size(x,1) > 1 && size(x,2) > 1
    erorr("Incorrect dimension on the given vector");
   return
end

%Actually checking and updating the highest value found **THIS CHECKS A
%COLUMN VECTOR***
if size(x,2) == 1
    for i = 1:size(x)
        if x(i) > maxVal && x(i) < bound 
            maxVal = x(i);
        elseif x(i) == maxVal && x(i) < bound
            maxVal = x(i);
        else
        end
    end
end

if size(x,1) == 1
    for j = 1:size(x,2)
        if x(1,j) > maxVal && x(1,j) < bound 
            maxVal = x(1,j);
        elseif x(1,j) == maxVal && x(1,j) < bound
            maxVal = x(1,j);
        else
        end
    end
end    

    
%Detailed Explantion? It the loop iterates through the given data and
%finds the highest number that does not exceed the given bound. Further,
%there are a couple of checks to help ensure that the data being given tot
%he function is usable. 
end


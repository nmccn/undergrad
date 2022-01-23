function z = interlace(x,y)
%interlace function will combine two vectors, such that every other value
%belongs to a respective vector.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%usage:
%z = interlace(x, y)
%inputs:
%x is a vector to be interlaced with y 
%y is a vector to be interlaced with x
%outputs:
%z is the vector after the previous have been interlaced

if size(x) ~= size(y)
    error("These vectors are not the same dimensions!");
end

if size(x, 1) == 1
    z = [x;y];
    z = z(:).';
end

if size(x, 2) == 1
    z = [x.';y.'];
    z = z(:);
end

%Detailed explanation:
%The error compares the sizes of the two vectors to ensure that they are of
%the same dimensions. Further, the next if statement deals with when the
%vector is a row vector, and it combines the two vectors before flattening
%with '(:)" and transposing ".'". Similarly,  the next if block deals with
%the vectors that are column vectors, and as such needs to transpose the
%inputs before flattening, otherwise the vector will be in the original
%order.
end


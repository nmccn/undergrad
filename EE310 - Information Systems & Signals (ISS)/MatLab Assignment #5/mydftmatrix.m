function [W] = mydftmatrix(N0)
%MYIDFTLOOP this function takes in an input of a column vector, Fr, of DFT
%coeffecients to produce an ouput column vector, fk, of recovered samples
%USAGE:%   [fk] = mydftloop(Fr)
% Fr = output vector of discrete fourier coeffecients, also a column vector
% fk = input vector of samples, provided as a column vector
W = [];
%N = number of coeffecients (entries in Fr) 

W = dftmtx(N0);


%EXPLANATION: 
%Creating DFT Matrix using matlab command dftmtx
end


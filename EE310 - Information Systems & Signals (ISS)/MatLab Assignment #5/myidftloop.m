function [fk] = myidftloop(Fr)
%MYIDFTLOOP this function takes in an input of a column vector, Fr, of DFT
%coeffecients to produce an ouput column vector, fk, of recovered samples
%USAGE:%   [fk] = mydftloop(Fr)
% Fr = output vector of discrete fourier coeffecients, also a column vector
% fk = input vector of samples, provided as a column vector
fk = [];
%N = number of coeffecients (entries in Fr) 
N=size(Fr,1);

for k=1:N
  fk(k)=0;
  for r=1:N
    fk(k)=(1/N)*(fk(k)+Fr(r).*exp(-1j.*2.*pi.*(r-1).*(k-1)./N));
  end
end


%EXPLANATION: 
%Basic implementation of I-DFT from the provided formula.
end


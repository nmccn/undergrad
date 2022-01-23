function [Fr] = mydftloop(fk)
%MYDFTLOOP this function takes in an input of a column vector, fk, of
%samples to produce an ouput column vector, Fr, of DFT coeffectients
%USAGE:%   [Fr] = mydftloop(fk)
% Fr = output vector of discrete fourier coeffecients
% fk = input vector of samples, provided as a column vector
Fr = [];
%N = number of samples (entries in fk) 
N=size(fk,1);

for k=1:N
  Fr(k)=0;
  for r=1:N
    Fr(k)=Fr(k)+fk(r).*exp(-1j.*2.*pi.*(r-1).*(k-1)./N);
  end
end

%%Needed to be commented out for #4, not exactly sure the reason
%%(uncommented for #6)
Fr = Fr';

%EXPLANATION: 
%Basic implementation of DFT from the provided formula.
end


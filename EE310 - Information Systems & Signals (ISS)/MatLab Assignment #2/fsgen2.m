function [Dn] = fsgen2(N)
% FSGEN Function to calculate Fourier Series coefficients% for a particular signal
% usage:%   [Dn] = fsgen(N)
% N = number of highest harmonic to calculate
% Dn = vector of FS coeffs Dn=[D_{-N}, ... , D_{-1}, D_0, D_1, ..., D_N]
%

n = [-N:N];
i = 1;
while(i <= 2*N+1)
    if(n(i) == 0)
        Dn(i) = 0;
    else
        Dn(i) = (j*(-1)^n(i)/(n(i)*pi));
    end
    i = i + 1;
end

end


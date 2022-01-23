function [Dn] = fsgen(N)
% FSGEN Function to calculate Fourier Series coefficients% for a particular signal
% usage:%   [Dn] = fsgen(N)
% N = number of highest harmonic to calculate
% Dn = vector of FS coeffs Dn=[D_{-N}, ... , D_{-1}, D_0, D_1, ..., D_N]
%
Dang = [];
Dmag = [];
index = [];

for n=-N:N
    i=n+N+1;
    index(i) = i;
    if n~=0
        Dn(i)=(j*(-1)^n)/(n*pi);
        Dang(i) = angle(Dn(i));
        Dmag(i) = abs(Dn(i));
    else
        Dn(i)=0;
        Dang(i) = 0;
        Dmag(i) = 0;
    end 
 
    
end

stem(index, Dmag)
xlabel('Dn')
ylabel('Magnitude')
title('Stem plot of Fourier Coeffecient Magnitudes')
stem(index, Dang)
xlabel('Dn')
ylabel('Phase Angle')
title('Stem plot of Fourier Coeffecient Phase Angles')









end


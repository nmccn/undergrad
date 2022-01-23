function f = fssyn(Dn, w0, dt, dur)
%FSSYN Function to synthesize a sum of cosine waves
% usage:
% fssyn(Dn, w0, dt, dur)
% Dn = vector of FS coeffs Dn=[D_{-N}, ... , D_{-1}, D_0, D_1, ..., D_N]
% w0 = fundamental frequency
% dt = time interval for plotting
% dur = total time duration of the signal to plot
time = 0:dt:dur;
max = (length(Dn)-1)/2;
coeff = -max:max;

for i = 1:length(time)
    f(i) = sum(exp(j*w0.*coeff*time(i)).*Dn);
end
f = real(f);
plot(time, f);
xlabel('Time (s)');
ylabel('f(t)');
title('Signal Constructed via Fourier Synthesis');
    
end




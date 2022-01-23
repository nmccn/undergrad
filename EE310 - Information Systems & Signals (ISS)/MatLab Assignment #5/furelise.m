load furelise;
Fr = fft(FE);
figure(10);
clf;
N0 = size(Fr,1);
T = 0.000133;
stem([0:1:N0-1]*T,Fr);
xlabel('time (seconds)'); 
ylabel('sample (scaled by T)');
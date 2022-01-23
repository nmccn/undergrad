function [filter1_out, filter2_out] = bandpass_filter(fk, Fs)
%%From Recitation
%%Create Impulse Responses for Bandpass Filters
L = 160;
%low pass filter with bandwidths given
h = blackman(L)';
h = h / sum(h);
%convert to band pass filters
filt1 = 2*h.*cos(2*pi*(1650/Fs)*(0:L-1));
filt2 = 2*h.*cos(2*pi*(1850/Fs)*(0:L-1));
% plot the frequency response
figure(2)
freqz(filt1,1,[],Fs)
hold on
figure(3)
freqz(filt2,1,[],Fs)

%%filter outputs
filter1_out = conv(filt1, fk);
filter2_out = conv(filt2, fk);

%%Figures
figure(4);
t = (1/Fs)*(1:length(filter1_out));
plot(t, filter1_out, 'b-', t, filter2_out, 'g-');
FontSize = 20;

end


function [filter1_out, filter2_out] = butterpass_filter(fk, Fs)
%%Halving the frequency
Fs_new = Fs/2;
%%Setting up butterworth bandpass filters using given freq
[B,A] = butter(2, [1600, 1700]/Fs_new);
[D,C] = butter(2, [1800, 1900]/Fs_new);

% plot the frequency response
figure(2)
freqz(B,A);
hold on
figure(3)
freqz(D,C);

%find filter outputs
filter1_out = filter(B, A, fk);
filter2_out = filter(D, C, fk);

%%Figures
figure(4);
t = (1/Fs)*(1:length(filter1_out));
plot(t, filter1_out, 'b-', t, filter2_out, 'g-');
FontSize = 20;

end


function fk = fsk_gen( bitstr, bps, Fs)
%FSKGEN generate the FSK sinusoids at 1650 and 1850 Hz
% 1650 encodes a "1", 1850 encodes a "0"
%
% bitstr = STRING of zeros and ones.
% bps = bits per second
% Fs = sampling rate
% fk = synthesized FSK signal
%%%%%%%%%%%%%%% put your code here %%%%%%%%%%%%%%%%%%%
dspi = [];
T = 1/Fs;
dur = ((1/bps) - T);
tn = 0:T:dur;
enc1 = 1650 * 2 * pi * ones(size(tn));
enc0 = 1850 * 2 * pi * ones(size(tn));

loop_size = strlength(bitstr);
for i = 1:loop_size
    if(bitstr(i) == '0')
        dspi = [dspi, enc0];
    else
        dspi = [dspi, enc1];
    end
end
fk = cos(cumsum(dspi)/Fs);
end
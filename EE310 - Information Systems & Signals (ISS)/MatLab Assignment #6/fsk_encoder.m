function fk = fsk_encoder(message, bps, Fs )
%FSKENCODER encode an FSK message.
%
% message = STRING message to be encoded
% Fs = sampling rate% bps = bits per second for FSK signal
% fk = synthesized FSK signal
%%%%%
%ASCII of the message
 messageascii = abs(message);
 % form long bit 
 messagebits = dec2bin(messageascii,8)';
 % put message bits into a vector
 stringmessagebits = messagebits(:)';
%%%%%%%%%%%%%% put your code here %%%%%%%%%%%%%%%%%%%%
%%This  is  accomplished  by  sending  a  pre-ordained  pattern  of  bits.   
%For  theimplementation in this supplement,  the preamble sent prior to 
%the message bits will be a
%sequence of six ?01? pairs followed by eight ones:  01010101010111111111.
for i = 1:6
    stringmessagebits = [01, stringmessagebits];
end

for i = 1:8
    stringmessagebits = [1, stringmessagebits];
end

%%add the terminating bits (16 '1's to the end of the string)
for i = 1:16
    stringmessagebits = [stringmessagebits, 1];
end
%%(you will want to call fskgen)
fk = fsk_gen(stringmessagebits, bps, Fs);
spectrogram(fk, 100, [], [], Fs, 'yaxis');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DTMF tones (used for telephones)
% Ask user to press a key, then play the sum of DTMF tones corresponding 
% to that key. Also plots the resulting signal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 8192; % sampling frequency (Hz)
tVec = 0:1/Fs:1/2; % sample times, from 0 to 0.5 seconds

while 1
    keypressed = input('press any digit or * or #: ' ,'s');
    %%% INSERT YOUR CODE HERE. DON"T FORGET '*' and '#'
    % Set the two frequencies (in Hz)
    if keypressed == '1'
        F1 = 697; F2 = 1209;
    elseif keypressed == '2'
        F1 = 697; F2 = 1336;
    elseif keypressed == '3'
        F1 = 697; F2 = 1477;
    elseif keypressed == '4'
        F1 = 770; F2 = 1209;
    elseif keypressed == '5'
        F1 = 770; F2 = 1336;
    elseif keypressed == '6'
        F1 = 770; F2 = 1477;
    elseif keypressed == '7'
        F1 = 852; F2 = 1209;
    elseif keypressed == '8'
        F1 = 852; F2 = 1336;
    elseif keypressed == '9'
        F1 = 852; F2 = 1477; 
    elseif keypressed == '0'
        F1 = 697; F2 = 1336;
    elseif keypressed == '*'
        F1 = 941; F2 = 1209;
    elseif keypressed == '#'
        F1 = 941; F2 = 1477;            
    else
        fprintf(' Key not recognized; quitting.\n');
        break;
    end
    
    % Construct signal as sum of two cosines, one with frequency F1, and one
    % with frequency F2. Each should be sampled at times in tVec.
    % Hint: for example, a "middle A" pure tone would be cos(2*pi*440*tVec)
    %%% INSERT YOUR CODE HERE
    signal = cos(2*pi*F1*tVec)+cos(2*pi*F2*tVec);
    
    % Play the sound
    sound(signal,Fs);
    
    % Plot the signal
    fprintf([' F1 = ' num2str(F1) 'Hz, F2 = ' num2str(F2) 'Hz\n']);
    figure(1);clf;
    plot(tVec,signal);
    xlabel('time (seconds)');
    title(['Pressed ' keypressed ': F1 = ' num2str(F1) 'Hz, F2 = ' num2str(F2) 'Hz']);
end


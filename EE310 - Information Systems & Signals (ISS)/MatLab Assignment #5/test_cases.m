%%From the Handout, f[k]
% %%Problem #1
% T = 0.1e-3;
% N0 = 128;
% T0 = N0*T;
% ft = inline('cos(2*pi*1100*t)');
% fk = T*ft([0:1:N0-1]'*T);

%%testing
% figure(1);
% clf;
% stem([0:1:N0-1],fk);
% xlabel('k');
% ylabel('f_k');
% figure(2);
% clf;
% stem([0:1:N0-1]*T,fk);
% xlabel('time (seconds)');
% ylabel('sample (scaled by T)');

% %%Problem #2
% Fr = mydftloop(fk);
% figure(3);
% clf;
% subplot(211);
% stem([0:1:N0-1],abs(Fr));
% xlabel('r'); ylabel('|F_r|');
% subplot(212);
% stem([0:1:N0-1],angle(Fr));
% xlabel('r');
% ylabel('angle(F_r)');
% figure(4);
% clf;
% freqVec = [0:1:N0-1]/T0;
% subplot(211);
% stem(freqVec,abs(Fr));
% xlabel('frequency (Hz)');
% ylabel('DFT magnitude');
% subplot(212);
% stem(freqVec,angle(Fr));
% xlabel('frequency (Hz)');
% ylabel('DFT phase');


%%Problem #4 Comment the transpose 
% T = 0.1e-3;
% N0 = 128;
% T0 = N0*T;
% ft = inline('cos(2*pi*1100*t)');
% fk = T*ft([0:1:N0-1]'*T);
% Fr = mydftloop(fk);
% fkrecon = myidftloop(Fr);
% maxError = max(abs(fk-fkrecon))   % this should be very small

%%Problem 6
T = 0.1e-3;
N0 = 128;
T0 = N0*T;
ft = inline('cos(2*pi*1100*t)');
fk = T*ft([0:1:N0-1]'*T);
Fr = mydftloop(fk);
W = mydftmatrix(N0);
FrViaMatrix = (W*fk);
maxError = max(abs(Fr-FrViaMatrix))   % this should be very small

%%Problem 7
% N0vec=[32 64 128 256 512 1024 2048 4096];% you can reduce N0vec if you run out of memory
% T = 0.1e-3;
% ft = inline('cos(2*pi*1100*t)');
% mydftlooptime = zeros(size(N0vec));
% matrixmulttime = zeros(size(N0vec));
% ffttime = zeros(size(N0vec));
% for nn=1:length(N0vec)N0 = N0vec(nn);
%     fk = T*ft([0:1:N0-1]'*T);
%     tic
%     Fr = mydftloop(fk);
%     mydftlooptime(nn) = toc;
%     W = mydftmatrix(N0);
%     tic
%     FrViaMatrix = W*fk;
%     matrixmulttime(nn) = toc;
%     maxError = max(abs(Fr-FrViaMatrix))   % this should be very small
%     tic
%     FrViaFFT = fft(fk);
%     ffttime(nn) = toc;
%     maxError = max(abs(Fr-FrViaFFT))   % this should be very small
% end
% figure(7);
% clf;
% plot(N0vec,mydftlooptime,'*-',N0vec,matrixmulttime,'--',N0vec,ffttime,'s-');
% legend('Time for mydftloop','Time for matrix mult','Time for fft');
%             xlabel('Number of samples');
%             ylabel('Elapsed Time (sec)');
% figure(8);
% clf;
% loglog(N0vec,mydftlooptime,'*-',N0vec,matrixmulttime,'--',N0vec,ffttime,'s-');
%             legend('Time for mydftloop','Time for matrix mult','Time for fft');
%                         xlabel('Number of samples');
%                         ylabel('Elapsed Time (sec)');




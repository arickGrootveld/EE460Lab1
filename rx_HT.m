%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GIVEN PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bitsPerTeam = 1000;
Fs = 44100;
t_total = 10;
numSamples = t_total*Fs;
fc = 5000;              % Carrier frequency
M = floor(numSamples/((bitsPerTeam/2)*3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELATE received signal with pulse shape
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pulse = hamming(M);
x1 = 2*filter((fliplr(pulse)/pow(pulse)*M), 1, y);
plotspec(x1,1/Fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMODULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = 1/Fs:1/Fs:10;
demod = cos(2*fc*pi*t); 
x2 = y'.*demod;          % Demod received signal
%plotspec(x1,1/Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LPF demodulated signal, x2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 50;
lpf = firpm(N, [0, 2100, 4410, Fs/2]/(Fs/2), [1 1 0 0]);
x3 = 2*filter(lpf, 1, x2);
%plotspec(x2, 1/Fs)
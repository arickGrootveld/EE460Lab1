%% GIVEN PARAMETERS
% Changeable values
bitsPerTeam = 1000;
t_total = 10;
% Constants
Fs = 44100;
numSamples = t_total*Fs;
fc = 5000;              % Carrier frequency
M = floor(numSamples/((bitsPerTeam/2)*3));

%% DEMODULATION
t = 1/Fs:1/Fs:length(y)/Fs;
carrier = cos(2*fc*pi*t); 
demod = y'.*carrier;          % Demod received signal
figure(1)
plotspec(demod,1/Fs)

%% LPF demodulated signal, x2
N = 50;
lpf = firpm(N, [0, 2100, 4410, Fs/2]/(Fs/2), [1 1 0 0]);
x2 = 2*filter(lpf, 1, demod);
figure(2)
plotspec(x2, 1/Fs)

%% CORRELATE received signal with pulse shape
pulse = hamming(M);
x1 = 2*filter((fliplr(pulse)/pow(pulse)*M), 1, y);
%plotspec(x1,1/Fs)


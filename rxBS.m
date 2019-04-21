%% GIVEN PARAMETERS
% Changeable values
bitsPerTeam = 1200;
numUsers = 3;
gain = 4.8;
gain2 = gain*0.8;

% Constants
Fs = 44100;
timeTrans = 10;
numSamples = timeTrans*Fs;
fc = 5000;              
M = floor(numSamples/(((bitsPerTeam)*numUsers)+1)); %Number of samples per frame

%% Correlation
pulseShape = hamming(M);
t = 1/Fs:1/Fs:M/Fs;
carrierSig = cos(2*pi*fc*t);
pulseShape = pulseShape.' .*carrierSig;
correlatedData = xcorr(y.',pulseShape.');

% Locate preamble start
[maximum,i] = max(correlatedData);

z = correlatedData(i + M:M:(i + ((bitsPerTeam)*numUsers)*M));
figure(3);
plot(z);
title('Correlated Data');
z = [((z(1)/(max(abs(z)))*gain2)) ((z(2:length(z))/max(abs(z))) * gain)];

% Quantize z
figure(4), plot([1:length(z)],z,'.') % plot quantized data
title('Quantized Data');
z = quantalph(z,[-5,-3,-1,1,3,5]);

bitchecker;
if(symbols == z)
    disp('This worked');
end

%Decoding CDMA
user1data = [];
user1code = [1 2 2];
for a=1:3:length(z)
    user1data = [user1data ((user1code(1) * z(a) + user1code(2) * z(a+1) + user1code(3) * z(a+2))/9)];
end
%Symbols to bits 
finalData = quantalph(user1data, [0, 1]);
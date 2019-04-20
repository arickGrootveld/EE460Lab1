%% GIVEN PARAMETERS
% Changeable values
bitsPerTeam = 2;
t_total = 10;
num_teams = 3;

% Constants
teamNumber = 3;
ch1 = [1 2 2];  % Brad and Sara
ch2 = [2 -2 1]; % Arick
ch3 = [2 1 -2]; % David and Micah

user1_msg = zeros(1,3);
user2_msg = zeros(1,3);
user3_msg = zeros(1,3);

preamble = [15];
Fs = 44100;
numSamples = t_total*Fs;
fc = 5000;              % Carrier frequency
M = floor(numSamples/(((bitsPerTeam/2)*3)+1));

% %% DEMODULATION
% t = 1/Fs:1/Fs:length(y)/Fs;
% carrier = cos(2*fc*pi*t); 
% demod = y'.*carrier;          % Demod received signal
% figure(1)
% plotspec(demod,1/Fs)
% 
% %% LPF demodulated signal, x2
% N = 50;
% lpf = firpm(N, [0, 2100, 4410, Fs/2]/(Fs/2), [1 1 0 0]);
% x2 = 2*filter(lpf, 1, demod);
% figure(2)
% plotspec(x2, 1/Fs)

%% CORRELATE received signal with pulse shape
pulse = hamming(M);
% x1 = 2*filter((fliplr(pulse)/pow(pulse)*M), 1, y);
% Recreate pulse shape
% rand('seed',10);
% pulse = 2.*rand(1,M) - 1;
t = 1/Fs:1/Fs:M/Fs;
modulator = cos(2*pi*fc*t);
pulse = pulse.' .* modulator;

% Correlate
corr = xcorr(y.',pulse.');
figure(3);
plot(corr)
title('After correlation')

% Locate preamble start
[z,i] = max(corr);

% Grab symbols w/ header
%z = corr(i:M:(i + (bitsPerTeam+1)*M));
% Normalize
%z = z/max(abs(z)) * 15; % 15 is preamble
% Grab symbols w/o header
z = corr(i + M:M:(i + (bitsPerTeam+1)*M)); 
%z = z(2:1:(bitsPerTeam+2)); % Further development this line

%normz = max(abs(z));

% Normalize
%z = z/normz; % 15 is preamble
z = z/max(abs(z)) * 9;
% Quantize z
figure(4), plot([1:length(z)],z,'.') % plot soft decisions
title('Soft decisions');
z = quantalph(z,[-15,-11,-9,-7,-5,-3,-1,1,3,5,7,9,11,15]);

%Decode CDMA
fin = length(z);

for (j = 1:fin)
    user1 = ch1 .* z(i:i+2);
    user1_chnk = user1(1) + user1(2) + user1(3);
    user1_msg = [user1_msg user1_chnk];

    user2 = ch2 .* z(i:i+2);
    user2_chnk = user2(1) + user2(2) + user2(3);
    user2_msg = [user2_msg user2_chnk];
    
    user3 = ch3 .* z(i:i+2);
    user3_chnk = user3(1) + user3(2) + user3(3);
    user3_msg = [user3_msg user3_chnk];
    i = i + 3;
end
user1_msg = user1_msg ./ num_teams;    
user2_msg = user2_msg ./ num_teams;  
user3_msg = user3_msg ./ num_teams;

msg_length = length(user1_msg);

user1_msg = user1_msg(2:msg_length);
user2_msg = user2_msg(2:msg_length);
user3_msg = user3_msg(2:msg_length);

bits = user3_msg.';
rxTest;


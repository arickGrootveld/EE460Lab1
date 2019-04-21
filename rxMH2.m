%% GIVEN PARAMETERS
% Changeable values
bitsPerTeam = 600;
t_total = 10;
num_teams = 3;
gain = 4.8;

% Constants
teamNumber = 3;
ch1 = [1 2 2];  % Brad and Sara
ch2 = [2 -2 1]; % Arick
ch3 = [2 1 -2]; % David and Micah


user1_msg = zeros(1,3);
user2_msg = zeros(1,3);
user3_msg = zeros(1,3);

Fs = 44100;
numSamples = t_total*Fs;
fc = 5000;              % Carrier frequency
M = floor(numSamples/(((bitsPerTeam)*3)+1));

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
truncatedLength = numSamples - (0.5*M);


[z,i] = max(y);
figure(6); plot(y);
title('Recieved Signal');

%truncSig = y(i + .5*M:1:(i + truncatedLength)-1);
figure(7); plot(truncSig)
%% AGC
% agcgrad.m: minimize J(a)= avg{|a|(1/3 a^2 r^2 - ds)} by choice of a

% n=length(truncSig);                           % number of steps in simulation
% r=truncSig;                        % generate random inputs
% ds=0.15;                           % desired power of output
% mu=0.001;                          % algorithm stepsize
% lenavg=2*M;                        % length over which to average
% a=zeros(n,1); a(1)=1;              % initialize AGC parameter
% s=zeros(n,1);                      % initialize outputs
% avec=zeros(1,lenavg);              % vector to store terms for averaging
% for k=1:n-1
%   s(k)=a(k)*r(k);                  % normalize by a(k)
%   avec=[sign(a(k))*(s(k)^2-ds),avec(1:lenavg-1)];  % incorporate new update into avec
%   a(k+1)=a(k)-mu*mean(avec);       % average adaptive update of a(k)
% end
% 
% figure(8); plot(s);

%% CORRELATE received signal with pulse shape
pulse = hamming(M);
% x1 = 2*filter((fliplr(pulse)/pow(pulse)*M), 1, y);
% Recreate pulse shape
% rand('seed',10);
% pulse = 2.*rand(1,M) - 1;
t = 1/Fs:1/Fs:M/Fs;
modulator = cos(2*pi*fc*t);
pulse = pulse.' .* modulator;

%% Filter Code
freqs = [0 0.01 0.1 1];
amps = [0 0 1 1];
order = 300;
grootvaFilter = firpm(order,freqs,amps);
thing = filter(grootvaFilter,1,y);

figure(420);
plotspec(thing,1/Fs);

y = thing;


%% Correlate
corr = xcorr(y.',pulse.');
figure(3);
plot(corr)
title('After correlation')

% Locate preamble start
[maximum,i] = max(corr);

% Grab symbols w/ header
%z = corr(i:M:(i + (bitsPerTeam+1)*M));
% Normalize
%z = z/max(abs(z)) * 15; % 15 is preamble
% Grab symbols w/o header
z = corr(i + M:M:(i + ((bitsPerTeam)*3)*M));
%z = z(2:1:(bitsPerTeam+2)); % Further development this line

%normz = max(abs(z));

% Normalize
%z = z/normz; % 15 is preamble
figure(500);
plot(z);

maxValAfter = max(abs(z));
z = z/max(abs(z)) * gain;

% Quantize z
figure(4), plot([1:length(z)],z,'.') % plot soft decisions
title('Soft decisions');
z = quantalph(z,[-5,-3,-1,1,3,5]);

bitchecker;
if(symbols == z)
    disp('This worked');
end


%Decoding CDMA

%Divide received signal into groups of 3:

user1data = [];

user1code = [1 2 2];

for a=1:3:length(z)
    user1data = [user1data ((user1code(1) * z(a) + user1code(2) * z(a+1) + user1code(3) * z(a+2))/9)]
end


finalData = quantalph(user1data, [0, 1])




























%% Decode CDMA
% fin = length(z);
% 
% for (j = 1:fin)
%     user1 = ch1 .* z(i:i+2);
%     user1_chnk = user1(1) + user1(2) + user1(3);
%     user1_msg = [user1_msg user1_chnk];
% 
%     user2 = ch2 .* z(i:i+2);
%     user2_chnk = user2(1) + user2(2) + user2(3);
%     user2_msg = [user2_msg user2_chnk];
%     
%     user3 = ch3 .* z(i:i+2);
%     user3_chnk = user3(1) + user3(2) + user3(3);
%     user3_msg = [user3_msg user3_chnk];
%     i = i + 3;
% end
% user1_msg = user1_msg ./ num_teams;    
% user2_msg = user2_msg ./ num_teams;  
% user3_msg = user3_msg ./ num_teams;
% 
% msg_length = length(user1_msg);
% 
% user1_msg = user1_msg(2:msg_length);
% user2_msg = user2_msg(2:msg_length);
% user3_msg = user3_msg(2:msg_length);
% 
% bits = user3_msg.';
% rxTest;
% 










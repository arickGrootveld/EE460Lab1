% This script will be used for generating and playing the 
% composite transmitted signal for collaborative receiver evaluation.
% It assumes that transmitters named "tx1B_collaborative.m", "tx2B_collaborative.m", etc
% are in the current path. 
%
% Make sure to set the "bitsPerTeam" correctly, which
% should be the same for all teams within a subgroup.

%% tweakable parameters
bitsPerTeam=1200;  % number of bits sent by each team
subgroup='C';      % enter your subgroup letter (A, B, or C)

%% parameters that probably won't change
numTeams=3;        % number of student teams
seed=421;          % random number seed
fs=44100;          % sampling rate
T=10;              % total time of each signal in seconds

%% generate transmitted signal
% set random num seed, generate random bits for each team
rand('seed',seed);
bits=round(rand(1e4, numTeams));
bits=bits(1:bitsPerTeam, :);

% create composite signal by calling each team's transmitter
y=zeros(fs*T,1);
for i=1:numTeams
    y=y+eval(['tx' num2str(i) subgroup '_collaborative(bits(:,' num2str(i) '))']);
end

%% normalize transmit waveform and transmit
silence = zeros(1,fs*3);
y = y.';
y = [silence y];
y = y.';
y=y/max(abs(y));
sound(y,fs)
figure(10);
plot(y);
title('transmitted signal');


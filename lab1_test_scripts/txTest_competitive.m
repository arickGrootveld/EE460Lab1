% This script will be used for generating and playing the 
% composite transmitted signal for competitive receiver evaluation.
% It assumes that transmitters named "tx1B_competitive.m", 
% "tx2B_competitive.m", etc are in the current path. 
%
% When testing, make sure to set the "bitsPerTeam" variable correctly
% FOR YOUR TEAM. You will not know the values for your competitors,
% but that is ok.

%% tweakable parameters
bitsPerTeam=[  20     % number of bits sent by team 1
               80     % number of bits sent by team 2
              700]';  % number of bits sent by team 3
subgroup='B';         % enter your subgroup letter (A, B, or C)


%% parameters that probably won't change
seed=1234;         % random number seed
fs=44100;          % sampling rate
T=10;              % total time of each signal

%% generate transmitted signal
numTeams=size(bitsPerTeam,2);  % number of student teams

% set random num seed, generate random bits for each team
rand('seed',seed);
bits=round(rand(1e4, numTeams));

% create composite signal by calling each team's transmitter
y=zeros(fs*T,1);
for i=1:numTeams
    temp=eval(['tx' num2str(i) subgroup '_competitive(bits(1:bitsPerTeam(' num2str(i) '),' num2str(i) '))']);
    if max(abs(temp))>1
        error(['Team ' num2str(i) ' exceeded peak power constraint.'])
    end
    if length(temp)~=T*fs
        error(['Team ' num2str(i) ' did not provide a signal of appropriate length.'])
    end    
    y=y+temp(:);
end

%% normalize transmit waveform and transmit
y=y/max(abs(y));
sound(y,fs)

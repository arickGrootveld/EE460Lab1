% Changeable parameters
fs = 44100;
T = 10;
t = 1/fs:1/fs:12;
t = t.';
numSamples = fs*T;
carrierFreq = 3000;
modulator = cos(2*pi*carrierFreq*t);
bitlength = 2;
upSampleRate = floor(numSamples/(bitlength*3/2));

%%%%
% pulse = hamming(upSampleRate);
% pulse = pulse.';
% pulse = [pulse zeros(1, numSamples - length(pulse))];
% pulse = pulse .* modulator.';
% pulse = pulse(1:upSampleRate);
%%%%

rand('seed',10);
pulse = 2.*rand(1,upSampleRate) - 1;
pulse = [pulse zeros(1, numSamples + 88200 - length(pulse))];
pulse = pulse .* modulator.';
pulse = pulse(1:upSampleRate);

plot(pulse);
    




% if ~exist('fs')
%     error('You need to set the variable ''fs'' to a reasonable sampling rate first.')
% end
% 
% % given a sampling frequency, start recording
% r = audiorecorder(fs, 16, 1);
% disp('Press any key to begin recording (or "receiving").')
% pause
% record(r);
% disp('Press any key to stop recording.')
% pause
% stop(r);
% y = double(getaudiodata(r, 'int16'));
% y=y/max(abs(y));
% % end record

%y = y.*cos(2*pi*carrierFreq*t)


%corr = xcorr(pulse, y)

corr = xcorr(y, pulse);


%plot(y);

%plotspec(y,1/fs)
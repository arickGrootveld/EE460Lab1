function encodedSignal = CDMATransmitter(bits)
% Collaberative CDMA Transmitter that all groups will use

%%
% Changeable parameters
Fs = 44100;
carrierFreq = 20;
upSampleRate = 100;
% Each team should input their own CDMA vector here
CDMAVector = [2 -2 1];
%% Main code

symbols = bits2PAM(bits);

CDMASymbols = symbols2CDMA(symbols, CDMAVector);
lengthSymbols = length(CDMASymbols);

upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
pulse = hamming(upSampleRate);

baseBandSignal = filter(pulse,1,upSampledSignal);
t = 1/upSampleRate:1/upSampleRate:length(baseBandSignal)/upSampleRate;

carrierSignal = cos(2*pi*carrierFreq * t);

encodedSignal = carrierSignal .* baseBandSignal;
end
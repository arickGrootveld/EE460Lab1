function encodedSignal = CDMATransmitter(bits, CDMAVector);
% Collaberative CDMA Transmitter that all groups will use

    %%
    numSamples = 441000;
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 5000;
    %% Main code
    symbols = bits2PAM(bits);

    CDMASymbols = symbols2CDMA(symbols, CDMAVector);
    lengthSymbols = length(CDMASymbols);
    
    % Calculating the upsample rate so we use the full window were allowed
    upSampleRate = floor(numSamples/lengthSymbols);
    upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
    upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
    pulse = hamming(upSampleRate);

    baseBandSignal = filter(pulse,1,upSampledSignal);
    t = 1/Fs:1/Fs:10;

    carrierSignal = cos(2*pi*carrierFreq * t);
    
    baseBandSignal = [baseBandSignal zeros(1, numSamples - length(baseBandSignal))];
    
    encodedSignal = carrierSignal .* baseBandSignal;
    % Transposing the output to work with Kleins function    
    encodedSignal = encodedSignal.';
end
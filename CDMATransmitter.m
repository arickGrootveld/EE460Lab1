function encodedSignal = CDMATransmitter(bits, CDMAVector);
% Collaberative CDMA Transmitter that all groups will use

    %%
    numSamples = 441000;
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 3000;
    %% Main code
    symbols = bits2PAM(bits);

    CDMASymbols = symbols2CDMA(symbols, CDMAVector);
    lengthSymbols = length(CDMASymbols);
    
    % Calculating the upsample rate so we use the full window were allowed
    upSampleRate = floor(numSamples/lengthSymbols);
    upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
    upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
    
    % Generating a cosine to modulate our hamming pulse with    
    t = 1/Fs:1/Fs:upSampleRate/Fs;
    modulator = cos(2*pi*carrierFreq*t);
    pulse = hamming(upSampleRate);
    pulse = pulse .* modulator.';
    
    figure(1);
    plot(pulse);
    
    baseBandSignal = filter(pulse,1,upSampledSignal);
    
    baseBandSignal = [baseBandSignal zeros(1, numSamples - length(baseBandSignal))];
    
    % Transposing the output to work with Kleins function    
    encodedSignal = baseBandSignal.';
end
function encodedSignal = CDMATransmitter(bits, CDMAVector);
% Collaberative CDMA Transmitter that all groups will use

    %%
    numSamples = 441000;
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 3000;
    %% Main code
    symbols = bits2PAM(bits);
    preamble = [11];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Allocate space for CDMASymbols output vector
    output = zeros(1,3*length(symbols));
    CDMASymbols = zeros(1,(length(output) + length(preamble)));  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Output vector w/o preamble
    %CDMASymbols = symbols2CDMA(symbols, CDMAVector); 
    % Add preamble into CDMA output vector
    CDMASymbols = [preamble symbols2CDMA(symbols, CDMAVector)];
    lengthSymbols = length(CDMASymbols);
    
    % Calculating the upsample rate so we use the full window we're allowed
    upSampleRate = floor(numSamples/lengthSymbols);
    upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
    upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
    
    % Generating a cosine to modulate our hamming pulse with    
    t = 1/Fs:1/Fs:upSampleRate/Fs;
    modulator = cos(2*pi*carrierFreq*t);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %pulse = hamming(upSampleRate);
    %pulse = pulse .* modulator.';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Generate and modulate discrete pulse shape
    rand('seed',10);
    pulse = 2.*rand(1,upSampleRate) - 1;
    figure(1);
    plot(pulse)
    pulse = pulse.' .* modulator.';
    figure(2);
    plotspec(pulse, 1/Fs)
    %%%
    
    baseBandSignal = filter(pulse,1,upSampledSignal);
    
    baseBandSignal = [baseBandSignal zeros(1, numSamples - length(baseBandSignal))];
    
    % Transposing the output to work with Kleins function    
    encodedSignal = baseBandSignal.';
end
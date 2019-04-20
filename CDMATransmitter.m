function encodedSignal = CDMATransmitter(bits, CDMAVector);
% Collaberative CDMA Transmitter that all groups will use

    %%
    numSamples = 441000;
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 5000;
    %% Main code
    symbols = bits2PAM(bits);
    preamble = [15];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Allocate space for CDMASymbols output vector
    output = zeros(1,3*length(symbols));
    CDMASymbols = zeros(1,(length(output) + length(preamble)));  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Output vector w/o preamble
    %CDMASymbols = symbols2CDMA(symbols, CDMAVector); 
    % Add preamble into CDMA output vector
    CDMASymbols = [preamble symbols2CDMA(symbols, CDMAVector)];
    %CDMASymbols = [preamble 9 9 9]
    lengthSymbols = length(CDMASymbols);
    
    % Calculate the upsample rate so we use the full window we're allowed
    upSampleRate = floor(numSamples/lengthSymbols);
    upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
    upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
    
    
    % Generate a cosine to modulate our hamming pulse with    
    t = 1/Fs:1/Fs:upSampleRate/Fs;
    modulator = cos(2*pi*carrierFreq*t);
    
    %%% Generate and modulate discrete pulse shape
%     rand('seed',10);
%     pulse = 2.*rand(1,upSampleRate) - 1;
    pulse = hamming(upSampleRate);
    figure(1);
    plot(pulse)
    title('Pulse Shape, random values between -1 +1');
    xlabel('Size M'); ylabel('Magnitude');
    pulse = pulse.' .* modulator;
    figure(2);
    title('Modulated pulse shape');
    plotspec(pulse, 1/Fs)
    %%%
    
    baseBandSignal = filter(pulse,1,upSampledSignal);
    
    baseBandSignal = [baseBandSignal zeros(1, numSamples - length(baseBandSignal))];
    
    % Transposing the output to work with Kleins function    
    encodedSignal = baseBandSignal.';
end
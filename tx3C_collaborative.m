function output = tx3C_collaborative(bits)
    % Collaberative CDMA Transmitter that all groups will use

    %%
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 5000;
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
    t = 1/Fs:1/Fs:10;

    carrierSignal = cos(2*pi*carrierFreq * t);
    
    baseBandSignal = [baseBandSignal zeros(1, 441000 - length(baseBandSignal))];
    
    output = carrierSignal .* baseBandSignal;
    
    output = output.';
end
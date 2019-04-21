function output = tx3C_collaborative(bits)
    cdmaArray = [2 -2 1];
    output = CDMATransmitter(bits,cdmaArray);
end

function encodedSignal = CDMATransmitter(bits, CDMAVector);
% Collaberative CDMA Transmitter that all groups will use
    %% Constants
    numSamples = 441000;
    % Changeable parameters
    Fs = 44100;
    carrierFreq = 5000;
    %% Main code
    symbols = bits2PAM2(bits);
    preamble = [9];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Allocate space for CDMASymbols output vector
    output = zeros(1,3*length(symbols));
    CDMASymbols = zeros(1,(length(output) + length(preamble)));  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Add preamble into CDMA output vector
    CDMASymbols = [preamble symbols2CDMA(symbols, CDMAVector)];
    %CDMASymbols = [preamble 15 15 15];
    lengthSymbols = length(CDMASymbols);
    
    % Calculate the upsample rate so we use the full window we're allowed
    upSampleRate = floor(numSamples/lengthSymbols);
    upSampledSignal = zeros(1,lengthSymbols*upSampleRate);
    upSampledSignal(1:upSampleRate:lengthSymbols*upSampleRate) = CDMASymbols;
    
    
    % Generate a cosine to modulate our hamming pulse with    
    t = 1/Fs:1/Fs:upSampleRate/Fs;
    modulator = cos(2*pi*carrierFreq*t);
    
    %%% Generate and modulate discrete pulse shape
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

function output = bits2PAM2(bits)
    LengthBits = length(bits);
    output = zeros(1, LengthBits);
    % Using template vectors for readability reasons
    zero = [0];
    one = [1];
    for i = 1:1:LengthBits
        currentBit = bits(i);
        if(currentBit == zero)
            output(i) = -1;
        elseif(currentBit == one)
            output(i) = 1;
        end
    end
end


function output = symbols2CDMA(symbols, CDMAVector)

symbolLength = length(symbols);
output = zeros(1,3*symbolLength);

for i = 1:3:symbolLength*3
    currentSymbol = symbols((i+2)/3);
    output(i:i+2) = currentSymbol .* CDMAVector;
end
end
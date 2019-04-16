function output = recievedProcessing(recievedSignal)
    %% Changeable values
    fc = 3000;
    numBits = 2;
    %% Constants
    fs = 44100;
    numSamples = 441000;
    symbolsPerBit = 1.5;
    %% Main Code
    t=1/fs:1/fs:length(recievedSignal)/fs;
    t=t.';
    figure(1);
    plot(t,recievedSignal);
    title('recieved signal');
    hammingWidth = numSamples/(numBits * symbolsPerBit);
    pulse = hamming(hammingWidth);
    correlationValue = xcorr(pulse,recievedSignal);
    
%     DELETE ME SOON
    t=1/fs:1/fs:length(recievedSignal)/fs;
    t=t.';
    plotableValue = correlationValue(1:length(recievedSignal));
    figure(5);
    stem(t,plotableValue);
    title('correlation of recieved signal with hamming pulse');
%     END OF DELETE ME SECTION
    demodulator = cos(2*pi*t*fc);
    demodulatedSignal = recievedSignal.*demodulator.';
    
    figure(4);
    plotspec(demodulatedSignal,1/fs);
    title('demodulatedSignal');
    
    freqs = [0 0.01 0.1 1];
    amps = [1 1 0 0];
    filterValues = firpm(200, freqs, amps);
    filteredSignal = filter(filterValues, 1, demodulatedSignal);
    
    figure(3);
    plotspec(filteredSignal, 1/fs);
    title('filteredSignal');
    
    newCorrelationValue = xcorr(pulse,filteredSignal);
    newCorrelationValue = flipud(newCorrelationValue);
%     newCorrelationValue = conv(pulse, fliplr(filteredSignal));
    plotableValue =  newCorrelationValue(1:length(recievedSignal));
    figure(7);
    stem(newCorrelationValue);
    
    figure(6);
    stem(t,plotableValue);
    title('correlation after signal is demodulated and filtered');
    output = 0;
end
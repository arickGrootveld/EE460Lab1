fs = 44100;
numFreqs = 10000;
finalFreq = 20000;
lengthTransmitted = 30 * fs;

obj3 = lengthTransmitted/numFreqs;

t_local = 0:1/(lengthTransmitted/numFreqs):1;


transmitted = zeros(1,lengthTransmitted);

r = audiorecorder(fs, 16, 1);

n = 1;
for i = 20:finalFreq/(numFreqs):finalFreq
    if(lengthTransmitted > (lengthTransmitted/numFreqs) + n)
       transmitted(n:1:n + lengthTransmitted/numFreqs) = sin(i * 2 *pi *t_local);
       n = n + lengthTransmitted/numFreqs;
       obj3 = i;
    end
end
plotspec(transmitted,1/fs);
record(r);
sound(transmitted, fs);
pause(30);
stop(r);


plotspec(m, 1/fs);

figure(2);
plot(m);
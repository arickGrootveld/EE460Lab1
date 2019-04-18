fs = 44100;
t = 0:0.1:999.9;

carrierfreq = 1000;

rand('seed',15);
header = 2*rand(1,10000) - 1;
header = header .* cos(2*pi*carrierfreq*t);


rand('seed',16);
array = 2*rand(1,1900) - 1;

rand('seed',117);
array2 = 2*rand(1,2000) - 1;

final = [array header array2]



poop = xcorr(final, header);

plot(poop);



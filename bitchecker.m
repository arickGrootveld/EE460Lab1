% Show Symbols
seed = 421;
numTeams = 3;
bitsPerTeam = 1200;

vectors = [1 2 2; 2 -2 1; 2 1 -2];

rand('seed',seed);
bits=round(rand(1e4, numTeams));
bits=bits(1:bitsPerTeam, :);

bit = bits(:,1);

symbols = zeros(1,bitsPerTeam*3);

for i = 1:numTeams
   bit = bits(:,i); 
   vector = vectors(:,i);
   symbols = symbols + (symbols2CDMA(bits2PAM2(bit), vector));
end

symbols = symbols.';

errorData = symbolErrorChecking(z,symbols);
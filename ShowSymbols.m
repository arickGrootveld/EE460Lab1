% Show Symbols
seed = 1234;
numTeams = 3;
bitsPerTeam = 10;

vectors = [1 2 2; 2 -2 1; 2 1 -2];

rand('seed',seed);
bits=round(rand(1e4, numTeams));
bits=bits(1:bitsPerTeam, :);

bit = bits(:,1);

symbols = zeros(1,bitsPerTeam*1.5);

for i = 1:numTeams
   bit = bits(:,i); 
   vector = vectors(:,i);
   symbols = symbols + (symbols2CDMA(bits2PAM(bit), vector));
end





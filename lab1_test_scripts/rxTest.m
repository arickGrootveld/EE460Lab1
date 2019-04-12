% This script will be used for computing your receiver
% bit error rate. It assumes that the current workspace
% contains a vector called "bits" that contains the decoded
% bits from your receiver. Make sure to set the "teamNumber"
% variable correctly.

% tweakable parameters
teamNumber=2;      % PUT YOUR TEAM NUMBER HERE (1, 2, or 3)

% you probably don't need to change these parameters
numTeams=3;        % number of student teams
seed=1234;         % random number seed (can be anything, but needs to match transmit seed)

% determine how many bits
numBits=length(bits); 

% regenerate transmitted bits
rand('seed',seed);
TxBits=round(rand(1e4, numTeams));

% discard all but current team's bits
TxBits=TxBits(1:numBits,teamNumber);

% compare received bits with transmitted bits
% and calculate bit error rate
errs=sum(bits(:)~=TxBits);
if errs==0
    disp('Congratulations!')
end
disp(['Of ' num2str(numBits) ' transmitted bits, your receiver made ' num2str(errs) ' errors for a bit error rate of ' num2str(errs/numBits) '.']);


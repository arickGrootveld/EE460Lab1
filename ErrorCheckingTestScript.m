% error Checking test script
testSymbols = [1 3 5 -5 -3 -1 1 3 5 -5 -3 -1];
testCorrectSymbols = [1 3 5 -5 -3 -1 -1 -3 -5 5 3 1];

output = symbolErrorChecking(testSymbols, testCorrectSymbols);

newTestSymbols = [];
newCorrectSymbols = [];
fullRange = [-5 -3 -1 1 3 5];
for i = -5:2:5
   for j = 1:6
      newCorrectSymbols = [newCorrectSymbols i];
   end
   newTestSymbols = [newTestSymbols fullRange];
end

newOutput = symbolErrorChecking(newTestSymbols, newCorrectSymbols);
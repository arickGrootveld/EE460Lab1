function output = symbols2CDMA(symbols, CDMAVector)

symbolLength = length(symbols);
output = zeros(1,3*symbolLength);

for i = 1:3:symbolLength*3
    currentSymbol = symbols((i+2)/3);
    output(i:i+2) = currentSymbol .* CDMAVector;
end

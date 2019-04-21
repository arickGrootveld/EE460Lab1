function errorData = symbolErrorChecking(symbols, correctSymbols)

realLength = length(symbols);
correctLength = length(correctSymbols);

errorData.errorIndexes = [];
errorData.numErrors = 0;

% +1 errors
errorData.oneToNegOne = 0;
errorData.oneToNegThree = 0;
errorData.oneToNegFive = 0;
errorData.oneToThree = 0;
errorData.oneToFive = 0;

% +3 errors
errorData.threeToNegOne = 0;
errorData.threeToNegThree = 0;
errorData.threeToNegFive = 0;
errorData.threeToOne = 0;
errorData.threeToFive = 0;

% +5 errors
errorData.fiveToNegOne = 0;
errorData.fiveToNegThree = 0;
errorData.fiveToNegFive = 0;
errorData.fiveToOne = 0;
errorData.fiveToThree = 0;

% -1 errors
errorData.negOneToNegThree = 0;
errorData.negOneToNegFive = 0;
errorData.negOneToOne = 0;
errorData.negOneToThree = 0;
errorData.negOneToFive = 0;

% -3 errors
errorData.negThreeToNegOne = 0;
errorData.negThreeToNegFive = 0;
errorData.negThreeToOne = 0;
errorData.negThreeToThree = 0;
errorData.negThreeToFive = 0;

% -5 errors
errorData.negFiveToNegOne = 0;
errorData.negFiveToNegThree = 0;
errorData.negFiveToOne = 0;
errorData.negFiveToThree = 0;
errorData.negFiveToFive = 0;

if(realLength ~= correctLength)
   disp('did not record correct number of bits, check code for errors');
elseif(symbols == correctSymbols)
    disp('data correct');
else
    for i = 1:realLength
        if(symbols(i) ~= correctSymbols(i))
           errorData.errorIndexes = [errorData.errorIndexes i];
           errorData.numErrors = errorData.numErrors + 1;
           correctValue = correctSymbols(i);
           errorValue = symbols(i);
           errorVector = [errorValue correctValue];
           % +1 Cases
           if(errorVector == [1 -1])
               errorData.oneToNegOne = errorData.oneToNegOne + 1;
           elseif(errorVector == [1,-3])
               errorData.oneToNegThree = errorData.oneToNegThree + 1;
           elseif(errorVector == [1,-5])
               errorData.oneToNegFive = errorData.oneToNegFive + 1;
           elseif(errorVector == [1,3])
               errorData.oneToThree = errorData.oneToThree + 1;
           elseif(errorVector == [1,5])
               errorData.oneToFive = errorData.oneToFive + 1;
           % +3 Cases
           elseif(errorVector == [3,-1])
               errorData.threeToNegOne = errorData.threeToNegOne + 1;
           elseif(errorVector == [3,-3])
               errorData.threeToNegThree = errorData.threeToNegThree + 1;
           elseif(errorVector == [3,-5])
               errorData.threeToNegFive = errorData.threeToNegFive + 1;
           elseif(errorVector == [3,1])
               errorData.threeToOne = errorData.threeToOne + 1;
           elseif(errorVector == [3,5])
               errorData.threeToFive = errorData.threeToFive + 1;
           % +5 Cases
           elseif(errorVector == [5,-1])
               errorData.fiveToNegOne = errorData.fiveToNegOne + 1;
           elseif(errorVector == [5,-3])
               errorData.fiveToNegThree = errorData.fiveToNegThree + 1;
           elseif(errorVector == [5,-5])
               errorData.fiveToNegFive = errorData.fiveToNegFive + 1;
           elseif(errorVector == [5,1])
               errorData.fiveToOne = errorData.fiveToOne + 1;
           elseif(errorVector == [5,3])
               errorData.fiveToThree = errorData.fiveToThree + 1;
           % -1 Cases
           elseif(errorVector == [-1,-3])
               errorData.negOneToNegThree = errorData.negOneToNegThree + 1;
           elseif(errorVector == [-1,-5])
               errorData.negOneToNegFive = errorData.negOneToNegFive + 1;
           elseif(errorVector == [-1,1])
               errorData.negOneToOne = errorData.negOneToOne + 1;
           elseif(errorVector == [-1,3])
               errorData.negOneToThree = errorData.negOneToThree + 1;
           elseif(errorVector == [-1,5])
               errorData.negOneToFive = errorData.negOneToFive + 1;
           % -3 Cases
           elseif(errorVector == [-3,-1])
               errorData.negThreeToNegOne = errorData.negThreeToNegOne + 1;
           elseif(errorVector == [-3,-5])
               errorData.negThreeToNegFive = errorData.negThreeToNegFive + 1;
           elseif(errorVector == [-3,1])
               errorData.negThreeToOne = errorData.negThreeToOne + 1;
           elseif(errorVector == [-3,3])
               errorData.negThreeToThree = errorData.negThreeToThree + 1;
           elseif(errorVector == [-3,5])
               errorData.negThreeToFive = errorData.negThreeToFive + 1;
           % -5 Cases    
           elseif(errorVector == [-5,-1])
               errorData.negFiveToNegOne = errorData.negFiveToNegOne + 1;
           elseif(errorVector == [-5,-3])
               errorData.negFiveToNegThree = errorData.negFiveToNegThree + 1;
           elseif(errorVector == [-5,1])
               errorData.negFiveToOne = errorData.negFiveToOne + 1;
           elseif(errorVector == [-5,3])
               errorData.negFiveToThree = errorData.negFiveToThree + 1;
           elseif(errorVector == [-5,5])
               errorData.negFiveToFive = errorData.negFiveToFive + 1;
           end
                   
        end
        
    end  
end
end
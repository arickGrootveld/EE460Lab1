function output = bits2PAM(bits)
    LengthBits = length(bits);
    output = zeros(1, LengthBits/2);
    % Using template vectors for readability reasons
    zeroZero = [0; 0];
    zeroOne = [0; 1];
    oneZero = [1; 0];
    oneOne = [1; 1];
    for i = 1:2:LengthBits
        currentBits = bits(i:i+1);
        if(currentBits == oneOne)
            output((i+1)/2) = 3;
        elseif(currentBits == oneZero)
            output((i+1)/2) = 1;
        elseif(currentBits == zeroZero)
            output((i+1)/2) = -1;
        elseif(currentBits == zeroOne)
            output((i+1)/2) = -3;
        end
    end
end

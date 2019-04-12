function output = bits2PAM(bits)
    LengthBits = length(bits);
    output = zeros(1, LengthBits/2);
    for i = 1:2:LengthBits
        currentBits = bits(i:i+1);
        if(currentBits == [1,1])
            output((i+1)/2) = 3;
        elseif(currentBits == [1 0])
            output((i+1)/2) = 1;
        elseif(currentBits == [0 0])
            output((i+1)/2) = -1;
        elseif(currentBits == [0 1])
            output((i+1)/2) = -3;
        end
    end
end

function output = bits2PAM(bits)
    LengthBits = length(bits);
    output = zeros(1, LengthBits);
    % Using template vectors for readability reasons
    zero = [0];
    one = [1];
    for i = 1:1:LengthBits
        currentBit = bits(i);
        if(currentBit == zero)
            output(i) = -1;
        elseif(currentBit == one)
            output(i) = 1;
        end
    end
end

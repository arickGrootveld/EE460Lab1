function output = tx2C_collaborative(bits)
    cdmaArray = [2 -2 1]; % Arick
    output = CDMATransmitter(bits,cdmaArray);
end
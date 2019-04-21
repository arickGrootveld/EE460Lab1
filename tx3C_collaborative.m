function output = tx3C_collaborative(bits)
    cdmaArray = [2 1 -2]; % David and Micah
    output = CDMATransmitter(bits,cdmaArray);
end
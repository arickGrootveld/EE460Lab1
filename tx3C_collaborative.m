function output = tx3C_collaborative(bits)
    cdmaArray = [2 -2 1];
    output = CDMATransmitter(bits,cdmaArray);
end
function output = tx1C_collaborative(bits)
    cdmaArray = [2 1 -2];
    output = CDMATransmitter(bits,cdmaArray);
end
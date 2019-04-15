function audioData = recordAudioData()
    fs = 44100;
    r = audiorecorder(fs, 16, 1);
    disp('Press any key to record...')
    pause;
    record(r);
    disp('Press any key to stop recording...')
    pause;
    stop(r);
    audioData = getaudiodata(r,'double')';
    fileSaved = false;
    for i = 0:20
        filePre = './data/data';
        fileEnding = '.mat';
        fileName = strcat(filePre, num2str(i), fileEnding);
        disp(fileName);
        if ((exist(fileName,'file') == 2) || fileSaved == true)
        else
            save(fileName,'audioData');
            fileSaved = true;
        end
        
    end
end


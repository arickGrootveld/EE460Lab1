function audioData = recordAudioData()
    fs = 44100;
    
    r = audiorecorder(fs, 16, 1);
    disp('Press any key to record...')
    pause;
    record(r);
    disp('Press any key to stop recording...')
    pause;
    stop(r);
    audioData.data = getaudiodata(r,'double')';
    t=1/fs:1/fs:length(audioData.data)/fs;
    audioData.time=t;
    
    % Error Testing Data is appended here (NOT FOR LIVE TESTS) 
    seed = 1235;
    bitsPerTeam = 2;
    numTeams = 3;
    rand('seed',seed);
    bits=round(rand(1e4, numTeams));
    bits=bits(1:bitsPerTeam, :);
    audioData.bits = bits;
    
    fileSaved = false;
    for i = 0:20
        filePre = './data/data';
        fileEnding = '.mat';
        fileName = strcat(filePre, num2str(i), fileEnding);
        if ((exist(fileName,'file') == 2) || fileSaved == true)
        else
            save(fileName,'audioData');
            fileSaved = true;
        end
    end
    figure(1);
    plot(audioData.time,audioData.data);
    title('received signal');
    ylabel('amplitude');
    xlabel('time');
end

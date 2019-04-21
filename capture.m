fs = 44100;

if ~exist('fs')
    error('You need to set the variable ''fs'' to a reasonable sampling rate first.')
end

% given a sampling frequency, start recording
r = audiorecorder(fs, 16, 1);
disp('Press any key to begin recording (or "receiving").')
pause
record(r);
disp('Press any key to stop recording.')
pause
stop(r);
y = double(getaudiodata(r, 'int16'));
y=y/max(abs(y));

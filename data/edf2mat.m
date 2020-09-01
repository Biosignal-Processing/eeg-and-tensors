patfolder = 'chb05'
exam =  '17'

[header, eeg] = edfread([patfolder,'\',patfolder,'_',exam,'.edf']);

Fs = 256 ; % sampling frequency

save([patfolder,'\',patfolder,'_',exam,'.mat'], 'header', 'eeg', 'Fs')

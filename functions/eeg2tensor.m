% PIBIC - UFC
% Author: Lucas Abdalah
% The dataset give us a 50 x 1024 matrix where wich row is a channel
% Channels x Signal (In time)

function X =eeg2tensor(EEG)

% Receive EEGs dimensions
n=size(EEG);

% Number of pages of the X tensor
pages=2;

% Variable to receive the FFT of the EEG signal
EEG_fft=zeros(n);

% Loop to calculate and assign the FFT matrix  
for ii=1:n(1,:)
	EEG_fft(ii,:)=abs(fft(EEG(ii,:)));
end

% Variable to receive the X tensor, 
% The originl matrix is the first page 
% FFT matrix is the second page

X = zeros(n(1), n(2), pages)
X(:,:,1)=EEG; 
X(:,:,2)=EEG_fft;

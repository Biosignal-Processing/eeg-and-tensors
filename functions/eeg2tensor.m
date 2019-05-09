function X = eeg2tensor(EEG,fs)
% eeg2tensor EEG signal to Tensor.
%   eeg2tensor(EEG) returns X, wich the tensor's second 'page' is the frequency matrix,
%   obtained with the FFT(X)
%  
%   The dataset give us a 50 x 1024 matrix where wich row is a channel
%   Channels x Signal (In time)
%
%   Authors: Lucas Abdalah       (lucasabdalah@gmail.com)
%         
% Version History:
% - 2019/04/05 	- ORIGINAL with FFT
% - 2019/05/09  - With Spectrogram Frequency x Time

% Number of channels equals of pages of the X tensor
pages=size(EEG,2);    

% Variable to receive the FFT of the EEG signal
[mm, nn]=size(spectrogram(EEG(:,1),[],[],[],fs,'yaxis'));

X = zeros(mm, nn, pages);

% Loop to calculate and assign the FFT matrix  
for ii=1:pages
	X(:,:,ii)=(spectrogram(EEG(:,ii),[],[],[],fs,'yaxis'));
end
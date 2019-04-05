function X = eeg2tensor(EEG)

%eeg2tensor EEG signal to Tensor.
%   eeg2tensor(EEG) returns X, wich the tensor's second 'page' is the frequency matrix,
%   obtained with the FFT(X)
%
%   Authors: Lucas Abdalah       (lucasabdalah@gmail.com)
%         
% Version History:
% - 2019/04/05 	- ORIGINAL with FFT
% 

% PIBIC - UFC
% Author: Lucas Abdalah
% The dataset give us a 50 x 1024 matrix where wich row is a channel
% Channels x Signal (In time)

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

X = zeros(n(1), n(2), pages);
X(:,:,1)=EEG; 
X(:,:,2)=EEG_fft;

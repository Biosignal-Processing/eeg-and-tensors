% PIBIC - UFC

clear all; close all; clc; % Clear all the workspace
%Tempo=datetime('now','Format','HH:mm:ss.SSS');

% Load your working dataet
% The variable ictal.mat is 50 x 1024 matrix

fs=256; % Samples/second

load('ictal'); % Carrega os dados de 'ictal'

% Transpose DATA to result in a matrix Signal X Channel(1024x50)
ictal=a'; % Recebe a matriz

% Centering and Scaling
	%ictal=center_scale(ictal);

% Skewness
	%ictal=skewness(ictal);


% Time (s) for X axis
	a1=ictal(:,1);
	ts=1/fs;
	n1=numel(a1);

	t=0:ts:(n1-1)*ts;

plot(a1,t);

% PCA 


% TENSOR



% Function that return the X tensor (Channel X Signal X Frequency)
X=eeg2tensor(ictal);
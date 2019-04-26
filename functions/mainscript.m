% PIBIC - UFC

clear all; close all; clc; % Clear all the workspace
%Tempo=datetime('now','Format','HH:mm:ss.SSS');

% Load your working dataet
% The variable ictal.mat is 50 x 1024 matrix

load('ictal'); % Carrega os dados de 'ictal'

fs=256; % Samples/second

% Transpose DATA to result in a matrix Signal X Channel(1024x50)
x=a'; %

% Centering and Scaling
	%ictal=center_scale(ictal);

	% Statistics 
		x_std=std(x);

		x_mean=mean(x);
	% Subtract the mean (and divide by the standard deviation)
		for ii=1:channels
		   disp(ii);
		   x(:,ii)=(x(:,ii) - x_mean(ii))/x_std(ii);
		end

	% Plot the heatmap of x covariance
		cov(x)>0.75;
		B = double(ans);
		figure
		heatmap(B);

% Time (s) for X axis
	a1=x(:,1);
	ts=1/fs;
	n1=numel(a1);

	t=0:ts:(n1-1)*ts;

plot(a1,t);

% PCA 

% TENSOR

% Function that return the y tensor (Channel X Signal X Frequency)
y=eeg2tensor(x);
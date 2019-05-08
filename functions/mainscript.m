% PIBIC - UFC

clearvars; close all; clc; % Clear all the workspace
%Tempo=datetime('now','Format','HH:mm:ss.SSS');

% Load your working dataet
% The variable ictal.mat is 50 x 1024 matrix

[header, a] = edfread('chb01_03.edf');

% Transpose DATA to result in a matrix Signal X Channel(1024x50)
x=a'; % Recebe a matriz

% Clear any variable different of x 
clearvars -except x

fs=256; % Samples/second

[samples, channels]=size(x);

% Time (s) for X axis
	ts=1/fs;
	t=0:ts:(samples-1)*ts;
    clear ts;
    
 figure
    plot(t,x(:,1))
    title('Canal 1: Original')
    xlabel('Tempo (s)');
    ylabel('Amplitude (mV)')    
    grid on   
 
% Centering and Scaling
	x_cs=center_scale(x);
    
pause

figure
    plot(t,x_cs(:,1),'r');
    title('Canal 1: Normalizado')
    xlabel('Tempo (s)');
    ylabel('Amplitude Normalizada (mV)')    
    grid on
    
% Function that return the y tensor (Channel X Signal X Frequency)

% 
y=eeg2tensor(x);
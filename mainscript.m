% Projeto de Iniciacao Cientifica - UFC
% Recebe o vetor de canais x sinal (no tempo)

clear all; close all; clc; % Clear all the workspace
%Tempo=datetime('now','Format','HH:mm:ss.SSS');

% Load your working dataet
% The variable ictal.mat is 50 x 1024 matrix


load('ictal'); % Carrega os dados de 'ictal'
ictal=a; % Recebe a matriz

% Function that return the X tensor (Channel X Signal X Frequency)
X=eeg2tensor(ictal);


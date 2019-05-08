% PIBIC - UFC
% EEG and Tensors


clearvars; close all; clc; % Clear all the workspace
%Tempo=datetime('now','Format','HH:mm:ss.SSS');

% Load your working dataet
% The variable ictal.mat is 50 x 1024 matrix

[header, a] = edfread('chb01_03.edf');

% Transpose DATA to result in a matrix Signal X Channel(1024x50)
x=a'; % Recebe a matriz

% Clear any variable different of x 
clearvars -except x
clc;

fs=256; % Samples/second

[samples, channels]=size(x);

% Time (s) for X axis
	ts=1/fs;
	t=0:ts:(samples-1)*ts;
    clear ts;

% Original Signal Plot
figure
    plot(t,x(:,1))
    title('Canal 1: Original')
    xlabel('Tempo (s)');
    ylabel('Amplitude (mV)')    
    grid on   

    
disp('Press Enter to Center and Scale'); 
pause
clc
% Centering and Scaling
	x_cs=center_scale(x);

% Normalized Signal Plot
figure
    plot(t,x_cs(:,1),'r');
    title('Canal 1: Normalizado')
    xlabel('Tempo (s)');
    ylabel('Amplitude Normalizada (mV)')    
    grid on
    
    
disp('Press Enter to Covariance Analysis'); 
pause
clc
% Analise de Covariancia   
    cov_x=cov(x_cs);
% Caso Geral da Covariancia
figure
    h=heatmap(cov_x);
    h.Colormap=cool;
    h.ColorLimits=[-1 1];
    title('Mapa de Calor')
    xlabel('Canais')
    ylabel('Canais')

% Caso da Covariancia Positiva
figure
	h07 = double(cov_x>0.7);
    h07=heatmap(h07);
    h07.Colormap=cool;
    h07.ColorLimits=[-1 1];
    colorbar off
    title('Mapa de Calor: Covâriancia > 0.7 ')
    xlabel('Canais')
    ylabel('Canais')

% Caso da Covariancia Positiva
figure
	hminus07 = double(cov_x<-0.7);
    hminus07=heatmap(hminus07);
    hminus07.Colormap=cool;
    hminus07.ColorLimits=[-1 1];
    colorbar off
    title('Mapa de Calor: Covâriancia < -0.7 ')
    xlabel('Canais')
    ylabel('Canais')

disp('Press Enter to PCA'); 
pause
clc
% PCA - Dimensionasionality Reduction
[coeff,score,latent]=pca(x_cs);

% Scree Plot
    figure
    scatter(1:channels,latent);
    hold on
    plot(1:channels,latent);
    yyaxis left;
    title('ScreePlot')
    xlabel('Componentes')
    ylabel('Autovalores')
    yyaxis right;
    ylim([0 100*(max(latent)/channels)]);
    ylabel('Percentual')
    grid on
    
% Function that return the y tensor (Channel X Signal X Frequency) 
%y=eeg2tensor(x);

% ALS
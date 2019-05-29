%% PIBIC - UFC
% EEG and Tensors

clearvars; close all; clc; % Clear all the workspace

%% APAGAR EM APRESENTAÇÃO
% Turn pause on to stop at each step
% pause off

%Tempo=datetime('now','Format','HH:mm:ss.SSS');

%% Load your working dataet
load('chb01_03.mat');

% Transpose DATA to result in a matrix Signal X Channel(1024x50)
x=chb01_03'; % Recebe a matriz

% Clear any variable different of x 
clearvars -except x
clc;

fs=256; % Samples/second

[samples, channels]=size(x);

% Time (s) for X axis
	ts=1/fs;
	t=0:ts:(samples-1)*ts;
    clear ts;

%% Pre Processing   
    %[flt,flt_cs,x_dc,x_cs]=pre_processing(x,fs,'norm','nocth');
    [~,x_cs,~,~]=pre_processing(x,fs,'norm','nocth');
    
    %% Analise de Covariancia   
    cov_x_cs=cov(x_cs);
% Caso Geral da Covariancia
figure
    h=heatmap(cov_x_cs);
    h.Colormap=cool;
    h.ColorLimits=[-1 1];
    title('Mapa de Calor')
    xlabel('Canais')
    ylabel('Canais')

% Caso da Covariancia Positiva
lim=0.7;
figure
	h07 = double(cov_x_cs>lim);
    h07=heatmap(h07);
    h07.Colormap=cool;
    h07.ColorLimits=[-1 1];
    colorbar off
    title(['Mapa de Calor: Covâriancia > ' num2str(lim)])
    xlabel('Canais')
    ylabel('Canais')

% Caso da Covariancia Positiva
figure
	hminus07 = double(cov_x_cs<-lim);
    hminus07=heatmap(hminus07);
    hminus07.Colormap=cool;
    hminus07.ColorLimits=[-1 1];
    colorbar off
    title(['Mapa de Calor: Covâriancia < ', num2str(lim)])
    xlabel('Canais')
    ylabel('Canais')

disp('Press Enter to PCA'); 
pause
clc

%% PCA - Dimensionasionality Reduction
[~,~,latent]=pca(x);

% Scree Plot - NÃO NORMALIZADO
    figure
    scatter(1:channels,latent);
    hold on
    plot(1:channels,latent);
    ylim([0 max(latent)])
    yyaxis left;
    title('ScreePlot')
    xlabel('Componentes')
    ylabel('Valores Singulares')
    yyaxis right;
    ylabel('Normalizado')
    grid on
    
%% PCA - Dimensionasionality Reduction
[~,~,latent]=pca(x_cs);

% Scree Plot - NORMALIZADO
    figure
    scatter(1:channels,latent);
    hold on
    plot(1:channels,latent);
    ylim([0 max(latent)])
    yyaxis left;
    title('ScreePlot')
    xlabel('Componentes')
    ylabel('Valores Singulares')
    yyaxis right;
    ylabel('Normalizado')
    grid on

%% APAGAR EM APRESENTAÇÃO
%     close all;

clearvars -except x_cs channels samples t fs
%% Function that return the y tensor (Channel X Signal X Frequency) 
    
%% 
    Y=eeg2tensor(x_cs,fs); % Complex values

    Y_norm=abs(Y); % normalized values.

%% Frequency Analysis
%  How to choose the best window design

% Hann Window


% Kaiser Window
%     Compute and plot the spectrogram of the signal. 
%     Specify a Kaiser window of length 63 with a shape 
%     parameter ?=17, 10 fewer samples of overlap between 
%     adjoining sections, and an FFT length of 256.
% 
%     nwin = 63;
%     wind = kaiser(nwin,17);
%     nlap = nwin-10;
%     spectrogram(seizure(:,1),wind,nlap,256,fs,'yaxis')
% 

%% Seizure Analysis
% Seizure Period
    t0=2996;
    t1=3036;

    % deltaT= t1-t0;
    disp(['Seizure duration: ' num2str(t1-t0) ' seconds'])
    
    seizure=x_cs(t0*fs+1:t1*fs,:); % Extracting the Seizure Periode
    
    % Windowed Signal
% 
%     for nn=1:n
%         seizure(inicio:inicio+delta,:)
%     end

% Tensor model
    T=eeg2tensor(seizure,fs); % Complex values
   
    T_norm=abs(T); % normalized values.
    
%% Visualize a Tensor
    figure
    visualize(Y_norm);
    
    figure
    visualize(T_norm);
    
    % Fazer uma análise utilizando
        % i1, i2, i3
        % i1-i2, i1-i3, i2-i3
   
%% PCA Matrix Analysis - SEIZURE
    [~,~,latent]=pca(seizure);

%ScreePlot
    figure
    scatter(1:channels,latent);
    hold on
    plot(1:channels,latent);
    ylim([0 max(latent)])
    yyaxis left;
    title('ScreePlot')
    xlabel('Compona1aqentes')
    ylabel('Valores Singulares')
    yyaxis right;
    ylabel('Normalizado')
    grid on

%% PCA Multilinear Analysis/MLSVD
    [Ue,Se,sve]=mlsvd(T);
    
    figure
    for ii = 1:3
        subplot(1,3,ii);
        semilogy(sve{ii},'.-');
        xlim([1 length(sve{ii})])
        yyaxis left;
        title('ScreePlot - MLSVD')
        xlabel('Componentes')
        ylabel('Valores Singulares Multilineares')
        yyaxis right;
        ylabel('Normalizado')
        grid on
    end
%     the multilinear singular values sigma(n)r 
%     become zero for r>Rn, in which Rn is the mode-n rank.

%% APAGAR EM APRESENTAÇÃO
%     close all;
%     clearvars -except T T_norm

%% Teste 
    t0=2996; t1=t0+0.5; t1seizure=x_cs(t0*fs+1:t1*fs,:); % Extracting the Seizure Period
    
%% ALS - AUTORAL 
    X = T_norm;
    MaxIterations=1e3;
    eps=1e-4;    
    MSE=zeros(1);
    R=1;
%    for R=1:2
        [Ahat, Bhat, Chat,error_ALS,...
            Iterations_ALS,MSE(R)] = ALS(X,R,MaxIterations,eps);

        disp(['Com posto: ', num2str(R), ', o (MSE) Erro Minímo' ...
            'Quadrático é: ' num2str(MSE)]);
%    end
    
    
    % Rank x MSE plot
    
    
%% ALS - TENSORLAB
%     [I, J, K] = size(T_norm);
%     
%     T_norm(:,:);
%     
%     R=1;
%     
%     a=zeros(1);
%     % Start supposing the rank R=1 until a stop criterion 
%     %for R=R0:Rn
%         U0 = cpd_rnd([I J K],R);
% 
%         options = struct;
%         options.Compression = false;
%         options.Algorithm = @cpd_als;
%         options.AlgorithmOptions.Display = 0;        % Dont Show the iterations
%         options.AlgorithmOptions.MaxIter = 1e3;      % Default 200
%         options.AlgorithmOptions.TolFun = eps^2;     % Default 1e-12
%         options.AlgorithmOptions.TolX = eps;         % Default 1e-6
% 
%         [Uest_als,output_als] = cpd(T_norm,U0,options);
% 
%         figure();
%         semilogy(output_als.Algorithm.fval);
%         title(['Rank ' num2str(R)])
%     
%     relerrT = frob(cpdres(T_norm,Uest_als))/frob(T_norm);
%     
%     %end
hold off    
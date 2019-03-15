% Projeto de Iniciacao Cientifica - UFC
% Recebe o vetor de canais x sinal (no tempo)
% A matriz ICTAL tem 50 x 1024, ou seja, cada linha eh o canal no tempo

clear all; close all; clc; % Limpa o ambiente do trabalho
%Tempo=datetime('now','Format','HH:mm:ss.SSS');


load('ictal'); % Carrega os dados de 'ictal'
ictal=a; % Recebe a matriz 

description=size(ictal);

for i=1:4
	figure(i);
	plot(ictal(i,:));
	grid on
end

% FFT do sinal ICTAL	
ictal_fft=zeros(description);

for i=1:description(1,:)
	ictal_fft(i,:)=abs(fft(ictal(i,:)));
end

for i=1:4
	figure(i+4);
	plot(ictal_fft(i,:));
	grid on
end

X(:,:,1)=ictal;
X(:,:,2)=ictal_fft;

% Estatisticas de primeira ordem
	% Nomes
	
% Estatisticas de segunda ordem
	% Nomes	

% Estatisticas de terceira ordem
	% Skewness - Obliquidade

% Estatisticas de quarta ordem
	% Kurtosis 

% COLOCAR FUNCAO PRA LIMPAR VARIAVEIS

%Tempo=datetime('now','Format','HH:mm:ss.SSS') - Tempo;
Tempo
%%%% ALS Script COM RUIDO %%%%
clear; close all; clc;
% Horario de Inicio do Algoritmo
t = datetime('now','Format','HH:mm:ss.SSS');

% Dimensões do tensor 
	I = 4; J = 4; K = 4;

	% Rank do tensor 
	R = 4;
% % Inicialização das matrizes fatores 
	A = randn(I, R);
	B = randn(J, R); 
	C = randn(K, R);

X=minha_funcao_gerar_tensor(A,B,C);
SNR_db=0:5:40; % Potencia - Desvio Padrao
SNR_lin=10.^(SNR_db./10); % Potencia Linear - Desvio Padrao

trial=1e2;
MC=zeros(trial,2);
len_snr=length(SNR_lin);
EQM_ITM=zeros(len_snr,2);

for ii=1:len_snr
	
	for jj=1:trial
		N=randn(I,J,K);
		
		sigma=(frob(X)^2)/((frob(N)^2)*SNR_lin(ii));

		Y=X+(sigma)*N; % Ruído

		itmax=1e3; 
		eps=1e-6;

		[MC(jj,1),MC(jj,2)]=montecarlo_minha_funcao_als(Y,X,R,itmax,eps); % RETORNA EQM e Numero de iteracoes
	end

	%VETOR QUE SALVA AS EQM E ITM PARA PLOTAR 
	EQM_ITM(ii,1)=sum(MC(:,1))/length(MC(:,1)); % Erro Medio
	EQM_ITM(ii,2)=sum(MC(:,2))/length(MC(:,2)); % Erro Medio
end

% Duracao do Algoritmo
disp('Duracao:');
t = datetime('now','Format','HH:mm:ss.SSS') - t 

%figure(1);
%semilogy(erro_als);
%Xhat=minha_funcao_gerar_tensor(Ahat,Bhat,Chat);
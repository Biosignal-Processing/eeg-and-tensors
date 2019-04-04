% Projeto de Iniciacao Cientifica - UFC
% Recebe o vetor de canais x sinal (no tempo)
% A matriz ICTAL tem 50 x 1024, ou seja, cada linha eh o canal no tempo
function(X)=eeg2tensor(EEG)













n=size(ictal);

for i=1:4
	figure(i);
	plot(ictal(i,:));



% FFT do sinal ICTAL	
ictal_fft=zeros(n);

for i=1:n(1,:)
	ictal_fft(i,:)=abs(fft(ictal(i,:)));
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



%Tempo=datetime('now','Format','HH:mm:ss.SSS') - Tempo;

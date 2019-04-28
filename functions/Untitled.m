[header, recorddata] = edfread('chb01_03.edf');
fs=256;
It=2010;
Ft=2020;
x=recorddata(1,fs*It:fs*Ft);
y=0:1/fs:(Ft-It);
%% fft
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

%% Welch
[PS,~] = pwelch(x,gausswin(128),[ ],256,fs);

%%
%subplot(2,1,1);
figure
plot(y,x)
grid on
title('EEG')
xlabel('Segundos')
ylabel('Amplitude(mV)')
%subplot(2,1,2);

figure 
plot(freq,10*log10(psdx))
grid on
title('Periodograma usando a FFT')
xlabel('Frequência (Hz)')
ylabel('Energia/Frequência (dB/Hz)')
xlim([0 128])

%%

plot(0:128,10*log10(PS))
grid on
title('Periodograma usando Método de Welch')
xlabel('Frequencia (Hz)')
ylabel('Energia/Frequência (dB/Hz)')
xlim([0 128])
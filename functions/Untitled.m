clearvars
close all
clc

addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\data\'

[header, recorddata] = edfread('chb01_03.edf');
fs=256;
% It=2010;
% Ft=2020;
% x=recorddata(1,fs*It:fs*Ft);
It= 1/fs;
Ft= size(recorddata,2)/fs;
x=recorddata(1,fs*It:fs*Ft);
y=0:1/fs:(Ft-It);


%% fft
N = length(x);
xdft = fft(x);
xdft = xdft(1:floor((N/2)+1));
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

%% Welch
[PS,~] = pwelch(x,gausswin(128),[ ],256,fs);

figure
subplot(2,1,1)
plot(y,x)
grid on
title('EEG')
xlabel('Segundos')
ylabel('Amplitude(mV)')

subplot(2,1,2)
plot(0:fs/2,10*log10(PS), ...
    'Color', [0 0.4470 0.7410], ...
    'LineStyle', '-', ...
    'LineWidth', 0.5, ...
    'Marker', 'o', ...
    'MarkerIndices', [1:floor((fs/2)/10):floor(fs/2)], ...
    'MarkerFaceColor', [0 0.4470 0.7410] ...
    );
hold on
plot(freq,10*log10(psdx), ...
    'Color', [0.8500 0.3250 0.0980], ...
    'LineStyle', ':', ...
    'LineWidth', 0.5, ...
    'Marker', 's', ...
    'MarkerIndices', [1:floor(length(freq)/10):length(freq)], ...
    'MarkerFaceColor', [0.8500 0.3250 0.0980] ...
    );
hold off
title('Periodogram')
xlabel('Frequency (Hz)')
ylabel('Energy/Frequency (dB/Hz)')
xlim([0 fs/2])
legend('Welch','FFT');

grid minor

clearvars
close
clc

%% Path and data
addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\functions\'
addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\functions\testes\'
% addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\data\'

load('data\chb01\chb01_03.mat'); % eeg, Fs, header;

%% Seizure
% File Name: chb01_03.edf
% File Start Time: 13:43:04
% File End Time: 14:43:04
% Number of Seizures in File: 1
% Seizure Start Time: 2996 seconds
% Seizure End Time: 3036 seconds

%% Samples, Time and Frequency
% Fs = 256      % Sampling Frequency
T = 1/Fs;       % Sampling period
N = size(eeg,1);       % Length of signal
t = (0:N-1)*T;  % Time vector

t0 = 2996;
tf = 3036;
cutFrame = [t0, tf];
% cutFrame = [2996, t0+4 ];

tFrame = [cutFrame(1):T:cutFrame(2)];
x = cut(eeg, cutFrame, Fs);
plot(tFrame, x + [200:200:23*200]')
grid minor

T = eeg2tensor(x',Fs);
X = T;

resfolder = 'part1';
mkdir(resfolder)

itmax=5e2;
tol=1e-20;

for R=1:10
  [Ahat, Bhat, Chat,erro_als,als_it,eqm]=minha_funcao_als(X,R,itmax,tol);

  figure;
  semilogy(erro_als);
  title(['Error ALS with Rank ', num2str(R)]);
  xlabel('Iterations');
  ylabel('NMSE');
  grid on

  Xhat=minha_funcao_gerar_tensor(Ahat,Bhat,Chat);

  saveas(gcf,[resfolder,'\rank',num2str(R),'.png']);
  save([resfolder, '\rank',num2str(R),'.mat']);
end

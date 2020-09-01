%% Path and data
addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\functions\'
addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\functions\testes\'
% addpath 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\data\'
close all
% load('rank20.mat');
load([ 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\part1\rank1.mat']);
%
% Xhat=minha_funcao_gerar_tensor(Ahat,Bhat,Chat);
figure
subplot(3,1,1)
  ii = 1
  S = Ahat*Bhat';
  S2 = mean(S,2);
  % S2 = S
  plot(abs(S2));
  xlim([0 Fs/2])
  hold on;
  title(['Posto: 1'])
  xlabel('Frequency (Hz)')
  ylabel('a.u')

  subplot(3,1,2)

  load([ 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\part1\rank6.mat']);

  S = Ahat*Bhat';
  S2 = mean(S,2);
  % S2 = S
  plot(abs(S2));
  xlim([0 Fs/2])
  hold on;
  title(['Posto: 6'])
  xlabel('Frequency (Hz)')
  ylabel('a.u')

  subplot(3,1,3)

  load([ 'C:\Users\lukin\Documents\GitHub\eeg-and-tensors\part1\rank10.mat']);

  S = Ahat*Bhat';
  S2 = mean(S,2);
  % S2 = S
  plot(abs(S2));
  xlim([0 Fs/2])
  hold on;
  title(['Posto: 10'])
  xlabel('Frequency (Hz)')
  ylabel('a.u')


% for ii = 1:10
%
%   disp('-------------------------------------------')
%
%   S = Ahat*Bhat';
%   S2 = mean(S,2);
%
%   plot(real(S));
%   xlim([0 Fs/2])
%
% end


%
% figure
% % subplot(2,1,1)
% plot(abs(S2));
% xlim([0 Fs/2])

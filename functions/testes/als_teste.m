%%%% ALS Script SEM RUIDO %%%%

clear; close all; clc;
% DimensÃµes do tensor 
% I=4; J=4; K=4;

load('ictal.mat');

X=eeg2tensor(a);

for R=1:10
    % Test with Tensor's Rank
    %R=10;

    % InicializaÃ§Ã£o das matrizes fatores 
    % A = randn(I, R);
    % B = randn(J, R); 
    % C = randn(K, R);

    %X=minha_funcao_gerar_tensor(A,B,C);

    itmax=1e3;
    eps=1e-10;

    [Ahat, Bhat, Chat,erro_als,als_it,eqm]=minha_funcao_als(X,R,itmax,eps);

    figure(R);
    semilogy(erro_als);
    title(['Erro ALS with Rank ', num2str(R)]);
    xlabel('Iterations');
    ylabel('MSE');
    grid on
    
    saveas(gcf,['Rank',num2str(R),'.png']);

end

Xhat=minha_funcao_gerar_tensor(Ahat,Bhat,Chat);

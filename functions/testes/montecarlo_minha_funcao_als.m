function [eqm,als_it] = montecarlo_minha_funcao_als(Y,X,R,itmax,eps)
% Inicializacao para os fatores de estimacao

%Ahat = randn(I, R); 
I=size(X,1);
J=size(X,2);
K=size(X,3);
    
Bhat = randn(J, R);  Chat = randn(K, R);

X1=reshape(X,[I,J*K]); % Modo 1 
X2=reshape(permute(X,[2,1,3]),[J,I*K]); % Modo 2
X3=reshape(permute(X,[3,1,2]),[K,J*I]); % Modo 3

erro_als=zeros(1,itmax);

Y1=reshape(Y,[I,J*K]); % Modo 1 


for ii = 2:itmax
    Ahat=X1*pinv(kr(Chat,Bhat).'); 
    Bhat=X2*pinv(kr(Chat,Ahat).');
    Chat=X3*pinv(kr(Bhat,Ahat).');

    X1hat=Ahat*(kr(Chat,Bhat)).'; % Modo 1 do tensor
    
    erro_als(ii)=(norm(Y1-X1hat,'fro')^2)/(norm(Y1,'fro')^2);
    
    if abs(erro_als(ii) - erro_als(ii-1))<eps   
        als_it=ii-1;
        break
    else
        als_it=itmax-1;
    end
end
% als_it=itmax;
eqm=erro_als(als_it+1);

end
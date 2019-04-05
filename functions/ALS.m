
function [Ahat, Bhat, Chat,error_ALS,Iterations_ALS,MSE] = ALS(X,R,MaxIterations,eps)
%ALS Alternating Least Square.
%   ALS(X,R) returns the estimation of Rank R factors matrices from the tensor X of third order.
%
%   ALS(X,R,MaxIterations,eps) returns the estimation of Rank R factors matrices from the
%   tensor X of third order with a limited number of MaxIterations and eps as minimum error.
%
%   Authors: Lucas Abdalah       (lucasabdalah@gmail.com)
%         
% Version History:
% - AAAA/MM/DD
% 

% Dimensions of the third order Tensor
I=size(X,1);
J=size(X,2);
K=size(X,3);

% Starting the estimation of the factors matrices

% Isn't necessary start the stimation o Ahat, because it will be updated, after the fist iteration
% Ahat = randn(I, R); 

% Bhat is randomly started 
Bhat = randn(J, R);  
% Chat is randomly started 
Chat = randn(K, R);

% Reshaping the X Tensor, to get the 3 modes: X1, X2 and X3.
X1=reshape(X,[I,J*K]); % Modo 1 
X2=reshape(permute(X,[2,1,3]),[J,I*K]); % Modo 2
X3=reshape(permute(X,[3,1,2]),[K,J*I]); % Modo 3

error_ALS=zeros(1,MaxIterations);

for ii = 2:MaxIterations
    Ahat=X1*pinv(kr(Chat,Bhat).'); 
    Bhat=X2*pinv(kr(Chat,Ahat).');
    Chat=X3*pinv(kr(Bhat,Ahat).');

    X1hat=Ahat*(kr(Chat,Bhat)).'; % Modo 1 do tensor
    
    error_ALS(ii)=(norm(X1-X1hat,'fro')^2)/(norm(X1,'fro')^2);
    
    if abs(error_ALS(ii) - error_ALS(ii-1))<eps   
        Iterations_ALS=ii-1;
        break
    else
        Iterations_ALS=MaxIterations-1;
    end
end
% Iterations_ALS=MaxIterations;
MSE=error_ALS(Iterations_ALS+1);

end

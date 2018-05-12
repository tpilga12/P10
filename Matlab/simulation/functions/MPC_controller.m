% function X=MPCcontroller(lin_sys,x,u,k)
%% MPC controller
%clc,clear all

% initialise
% for k = 1:1
    Hp = 10; % Prediction horizon
    Hu = 2;  % Control horizon
    XHp = int8(2:Hp);
    XHu = int8(2:Hu);
    for n = 1:Hp %%% Lifted A matrix
        if n == 1
            Alifted = [lin_sys.A^n];
        else
            Alifted = [Alifted ;lin_sys.A^n];
        end
    end
    
    for n = 1:Hp %%% Lifted B matrix
        
        if n == 1
            Bulifted = [lin_sys.B];
        else
            Bulifted = [Bulifted ; lin_sys.A^n*lin_sys.B];
        end
    end
    
    for n = 1:Hp %%% Lifted B Delta matrix
        
        if n == 1
            B_Deltalifted = [lin_sys.B];
        else
            B_Deltalifted(end+1:end+length(lin_sys.B),:) = [lin_sys.A^n*lin_sys.B+lin_sys.B];
        end
    end
    
    Clifted = zeros(length(lin_sys.C)*Hp,Hp)';
    for n = 1:Hp
           Clifted(n,1+length(lin_sys.C)*n-length(lin_sys.C):length(lin_sys.C)*n) =lin_sys.C(1,:);   
    end
    
    
    %%
    Q= eye(Hp);
    
    
%     Clifted = eye(Hp);
    psi = Clifted*Alifted;
    
    gamma = Clifted*Bulifted;
    theta = Clifted*B_Deltalifted;
% end
%%
% t = 1:1:999;%(sample:sample:length(h_data_hat)*sample)-sample;
% h_input(1:length(t))=0.3;%h_data_hat ;%Input height
% h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0
% X0(1:10) =0;
Sys = ss(lin_sys.A,lin_sys.B,lin_sys.C,0,20);

u=[(utank1(:,1)-utank1(1,1))'; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
[Y_hat t1 x1]=lsim(Sys,u);

%%
k = 20;
H = theta'*Q*theta;
f = 2*(x1(k)'*psi'*Q*theta)+2*(u(k-1)'*gamma'*Q*theta) - (2*(x1(k-1)'*psi' ...
    *Q*theta))-(2*(u(k-2)'*gamma'*Q*theta))-(2*(delta_u(k-1)'*theta'*Q ...
    *theta))

 X = quadprog(H,f,[],[],[],[],[],[],[]);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)

 
% end
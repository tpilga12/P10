% function X=MPCcontroller(lin_sys,x,u,k)
%% MPC controller
%clc,clear all

% initialise
% for k = 1:1
    Hp = 10; % Prediction horizon

    
% A lifted
    for n = 1:Hp %%% Lifted A matrix
        if n == 1
            Alifted = [lin_sys.A^n];
        else
            Alifted = [Alifted ;lin_sys.A^n];
        end
    end
            for n = 1:Hp %%% Lifted U Vector
        if n == 1
            Ulifted = [u.^n];
        else
            Ulifted = [Ulifted u.^n];
        end
    end
% B lifted
p = 0;

A = lin_sys.A;
B = lin_sys.B;
% A = [2 0;0 1];
% B = [1; 0];
Bulifted = zeros(length(B)*Hp,Hp)
len = length(B);
nr_inputs = length(B(1,:));
for n = 1:Hp
    for m = 1:Hp
        if m-n < 0
            insert = zeros(len,12);
        else
            insert = A^(m-n)*B;
         Bulifted((len*m-len+1):(len*m),(n*nr_inputs-nr_inputs+1):(n*nr_inputs)) = insert;
        end
    end
    p = p +1;
end
          
% Clifted   
    Clifted = zeros(length(lin_sys.C)*Hp,Hp*2)';
    for n = 1:Hp
%            Clifted(n,1+length(lin_sys.C)*n-length(lin_sys.C):length(lin_sys.C)*n) =lin_sys.C(2,:);   
           Clifted(1+size(lin_sys.C,1)*n-size(lin_sys.C,1):n*2,1+length(lin_sys.C)*n-length(lin_sys.C):length(lin_sys.C)*n) =lin_sys.C; 
    end
    
    
    %%
   B_Deltalifted =Bulifted;
    Q= eye(Hp*2);
    
    
%     Clifted = eye(Hp);
    psi = Clifted*Alifted; % R(10x263)
    
    gamma = Clifted*Bulifted; %R(10x120)
    theta = Clifted*B_Deltalifted; %R(10x120)
% end
%%
t = 1:1:500;%(sample:sample:length(h_data_hat)*sample)-sample;
 h_input(1:length(t))=0.3;%h_data_hat ;%Input height
% h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0
% X0(1:10) =0;
Sys = ss(lin_sys.A,lin_sys.B,lin_sys.C,0,20);

u=[h_input;h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
[Y_hat t1 x1]=lsim(Sys,u);
%%
x1 = x1(1,:)'-x1(2,:)';
%%

H = gamma'*Q*gamma;
% f = 2*(x1*psi'*Q*theta)+2*(u(k-1)'*gamma'*Q*theta) - (2*(x1(k-1)'*psi' ...
%     *Q*theta))-(2*(u(k-2)'*gamma'*Q*theta))-(2*(delta_u(k-1)'*theta'*Q ...
%     *theta))

f = 2*(delta_xstates(1,1:265)*psi'*Q*gamma);%+2*(u'*gamma'*Q*theta) - (2*(x1*psi' ...
    %*Q*theta))-(2*(u'*gamma'*Q*theta))-(2*(delta_u'*theta'*Q ...
   % *theta))


% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','final');
options = optimoptions('quadprog','Display','off','Algorithm','interior-point-convex');

 [X,FVAL,EXITFLAG] = quadprog(H,f,A_constraints(1:120)',b_constraints(1,120),[],[],b_constraints(2:120),[],[],options);

 
% end
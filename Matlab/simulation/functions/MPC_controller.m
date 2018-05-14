% function X=MPCcontroller(lin_sys,x,u,k)
%% MPC controller
%clc,clear all

% initialise
% for k = 1:1
    Hp = 10; % Prediction horizon
    Hu = 2;  % Control horizon
    XHp = int8(2:Hp);
    XHu = int8(2:Hu);
    
%% A lifted
    for n = 1:Hp %%% Lifted A matrix
        if n == 1
            Alifted = [lin_sys.A^n];
        else
            Alifted = [Alifted ;lin_sys.A^n];
        end
    end
    
%% B lifted
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
          

%     Bulifted = zeros(length(lin_sys.B)*Hp,Hp*size(lin_sys.B,2));
%     Hpp = Hp;
%     for n = 1:Hp %%% Lifted B matrix
%         for n_2 = 1:Hpp
%             if n_2 == 1
%                 Bulifted(n_2-length(lin_sys.B)+n*length(lin_sys.B):length(lin_sys.B)*n_2-length(lin_sys.B)+n*length(lin_sys.B),1-size(lin_sys.B,2)+size(lin_sys.B,2)*n:size(lin_sys.B,2)*n) = lin_sys.B;
%             else
%                 Bulifted(1+length(lin_sys.B)*n_2-length(lin_sys.B)-length(lin_sys.B)+n*length(lin_sys.B):length(lin_sys.B)*n_2-length(lin_sys.B)+n*length(lin_sys.B),1+size(lin_sys.B,2)*n-size(lin_sys.B,2):size(lin_sys.B,2)*n)  = lin_sys.A^(n_2-1)*lin_sys.B;
% %               Bulifted(1+length(lin_sys.B)*n-length(lin_sys.B):length(lin_sys.B)*n,1+size(lin_sys.B,2)*n-size(lin_sys.B,2):size(lin_sys.B,2)*n)  = lin_sys.A^(n_2-1)*lin_sys.B;
%             end
%         end
%     end
%     
%     for n = 1:Hp %%% Lifted B Delta matrix
%         
%         if n == 1
%             B_Deltalifted = [lin_sys.B];
%         else
%             B_Deltalifted(end+1:end+length(lin_sys.B),:) = [lin_sys.A^n*lin_sys.B+lin_sys.B];
%         end
%     end
%     
%     Clifted = zeros(length(lin_sys.C)*Hp,Hp)';
%     for n = 1:Hp
%            Clifted(n,1+length(lin_sys.C)*n-length(lin_sys.C):length(lin_sys.C)*n) =lin_sys.C(1,:);   
%     end
    
    
    %%
   B_Deltalifted =Bulifted;
    Q= eye(Hp);
    
    
%     Clifted = eye(Hp);
    psi = Clifted*Alifted; % R(10x263)
    
    gamma = Clifted*Bulifted; %R(10x120)
    theta = Clifted*B_Deltalifted; %R(10x120)
% end
%%
t = 1:1:100;%(sample:sample:length(h_data_hat)*sample)-sample;
 h_input(1:length(t))=0.3;%h_data_hat ;%Input height
% h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0
% X0(1:10) =0;
Sys = ss(lin_sys.A,lin_sys.B,lin_sys.C,0,20);

u=[(utank1(:,1)-utank1(1,1))'; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
[Y_hat t1 x1]=lsim(Sys,u);

%%
k = 20;
H = theta'*Q*theta;
% f = 2*(x1(k)'*psi'*Q*theta)+2*(u(k-1)'*gamma'*Q*theta) - (2*(x1(k-1)'*psi' ...
%     *Q*theta))-(2*(u(k-2)'*gamma'*Q*theta))-(2*(delta_u(k-1)'*theta'*Q ...
%     *theta))
f = 2*(theta'*Q*psi*x1(k))+2*(theta'*Q*gamma*u(k-1)) - (2*(x1(k-1)'*psi' ...
    *Q*theta))-(2*(u(k-2)'*gamma'*Q*theta))-(2*(delta_u(k-1)'*theta'*Q ...
    *theta))




 X = quadprog(H,f,[],[],[],[],[],[],[]);%quadprog(H,f,A,b,Aeq,beq,LB,UB,X0)

 
% end
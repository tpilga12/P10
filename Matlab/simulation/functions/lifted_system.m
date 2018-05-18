function[psi gamma theta Q Alifted Bulifted Ulifted] =  lifted_system(lin_sys,Hp) 

% Lifted system 
% [psi gamma theta] =  lifted_system(lin_sys,Hp) 
%     Hp = 10; % Prediction horizon
%     Hu = 2;  % Control horizon
    
% A lifted
    for n = 1:Hp %%% Lifted A matrix
        if n == 1
            Alifted = [lin_sys.A^n];
        else
            Alifted = [Alifted ;lin_sys.A^n];
        end
    end
    
%         for n = 1:Hp %%% Lifted A matrix
%         if n == 1
%             Ulifted = [u.^n];
%         else
%             Ulifted = [Ulifted u.^n];
%         end
%     end
    
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
    Clifted = zeros(length(lin_sys.C)*Hp,Hp)';
    for n = 1:Hp
  
           Clifted(1+size(lin_sys.C,1)*n-size(lin_sys.C,1):n*2,1+length(lin_sys.C)*n-length(lin_sys.C):length(lin_sys.C)*n) =lin_sys.C; 
    end
    
    
   B_Deltalifted =Bulifted;
   
    Q= eye(Hp*2);
    
    
%     Clifted = eye(Hp);
    psi = Clifted*Alifted; % R(10x263)
    
    gamma = Clifted*Bulifted; %R(10x120)
    theta = Clifted*B_Deltalifted; %R(10x120)
end
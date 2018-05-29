function[psi gamma theta Q Alifted Bulifted Dlifted] =  lifted_system(lin_sys,Hp,u) 

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
    %%
%   u=u';
%     for n = 1:Hp %%% Lifted D matrix
%         if n == 1
%             Dlifted = [u.^n];
%         else
%             Dlifted = [Dlifted; u.^(n-1)];
%         end
%     end
    %%
    
% B lifted
p = 0;

A = lin_sys.A;
B = lin_sys.B;
% A = [2 0;0 1];
% B = [1; 0];
Bulifted = zeros(length(B)*Hp,Hp);
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
          
% Clifted The one from lin_sys
% length_C = 0;
% Clifted = zeros(length(lin_sys.C)*Hp);
% %%
% for n=1:Hp
%    Clifted(1+length_C:length(lin_sys.C)*n,1+length_C:length(lin_sys.C)*n) =  lin_sys.C;
%     length_C = length(lin_sys.C)*n;
% end
%%
length_C = 0;
% Clifted = zeros(length(lin_sys.C)*Hp,length(lin_sys.C)*Hp);
 Clifted = zeros(Hp,length(lin_sys.C)*Hp);
C_insert=zeros(1,length(lin_sys.A)); 
% C_insert(1,262:263)=1;
counter =1;
for n = 1:length(lin_sys.StateName) % find the output
    if  contains(lin_sys.StateName(counter),'h_pipe_2_1') ==1
    
        C_insert(1,counter)=1;
    end
    
    counter = counter +1;
end    
%%
for n=1:Hp
%    Clifted(1+length_C:length(C_insert)*n,1+length_C:length(C_insert)*n) =C_insert;
Clifted(n,1+length_C:length(C_insert)*n) =C_insert;
    length_C = length(lin_sys.A)*n;
end  
%%    %




   B_Deltalifted =Bulifted;
   
%     Q= eye(length(Clifted));
     Q= eye(Hp);
    
%     Clifted = eye(Hp);
    psi = Clifted*Alifted; % R(10x263)
    
    gamma = Clifted*Bulifted; %R(10x120)
    theta = Clifted*B_Deltalifted; %R(10x120)
end
function[psi gamma theta Q Alifted Bulifted C_insert] =  lifted_system(lin_sys,Hp,u) 

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
   

    
p = 0;

A = lin_sys.A;
B = lin_sys.B;
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
          
length_C = 0;
% Clifted = zeros(length(lin_sys.C)*Hp,length(lin_sys.C)*Hp);
 Clifted = zeros(Hp,length(lin_sys.C)*Hp);
C_insert=zeros(1,length(lin_sys.A)); 
counter =1;
for n = 1:length(lin_sys.StateName) % find the output
    if  strcmp(lin_sys.StateName(counter),'h_pipe_2_1') ==1
    
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
%%
     

    B_Deltalifted =Bulifted;
    Q= eye(Hp)*1;
    psi = Clifted*Alifted; 
    gamma = Clifted*Bulifted; %Blifted;
    theta = Clifted*B_Deltalifted; %
    
end
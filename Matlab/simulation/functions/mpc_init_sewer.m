function [SUM_matrix_mpc C_matrix_mpc fitfuncv2 C_matrix_output]= mpc_init_sewer(k,Hp,lin_sys,pipe_spec) 
%%% Matrix multiplied on 
Test_matrix = zeros(k,k);
p = 0;
for m =1:k
    for n =1:k-p  
      SUM_matrix_mpc(n+p,m) = 1; 
    end
  p=p+1;
end


%%% C matrix to multiply onto the Constraints to pick the correct
%%% constraints
length_C = 0;
C_matrix_mpc = zeros(10,length(lin_sys.C)*Hp);
C_matrix_mpc_constraint=zeros(1,length(lin_sys.A)); 
C_matrix_mpc_constraint(1,37:38)=1;

for n=1:Hp
   C_matrix_mpc(n,1+length_C:length(C_matrix_mpc_constraint)*n) = C_matrix_mpc_constraint;
    length_C = length(lin_sys.A)*n;
end



Qf = pipe_spec(1).Qf;
d = pipe_spec(1).d;
h_test=0.0001:d/100:d;
for t = 1:100
    
    Q_test(t)=(0.46 - 0.5 *cos(pi*(h_test(t)/d))+0.04*cos(2*pi*(h_test(t)/d)))*Qf;
   
end
fitfuncv2 = fit(h_test',Q_test','poly9');

length_C = 0;
% Clifted = zeros(length(lin_sys.C)*Hp,length(lin_sys.C)*Hp);
 Clifted = zeros(Hp,length(lin_sys.C)*Hp);
C_matrix_output=zeros(1,length(lin_sys.A)); 
% C_insert(1,262:263)=1;
counter =1;
for n = 1:length(lin_sys.StateName) % find the output
    if  strcmp(lin_sys.StateName(counter),'h_pipe_2_35') ==1
    
        C_matrix_output(1,counter)=1;
    end
    
    counter = counter +1;
end   

end
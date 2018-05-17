%% Constraints 

%% Hent tank_spec og rør_spec ind, samt antal, data
% Bulifted = zeros(length(B)*Hp,Hp)
A_constraints = ones(2,length(xstates));
b_constraints = ones(2,length(xstates));
p = 0;
for m = 1:19
    
        pipe_states = length(data{1,m}.h(1,:));
        pipe_diameter = pipe_spec(m).d;
        lower_bound = -data{1,1}.h(1,1);
        upper_bound = pipe_diameter-data{1,1}.h(1,1);
        
        
        b_constraints(1,1+p:p+pipe_states)= [upper_bound];
        b_constraints(2,1+p:p+pipe_states)= [lower_bound];
        
        p= p+pipe_states;
%     elseif tank_spec(m).data_location == m
% %         pipe_states = length(data{1,m}.h(1,:));
%     p=p+1;
     
%         
% 
%     else
%         disp('error in constraints')
   


    
    
end



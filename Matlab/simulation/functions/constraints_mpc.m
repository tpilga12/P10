function [A_constraints b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp,sys_setup)

%% Constraints 

%% Hent tank_spec og rør_spec ind, samt antal, data
% Bulifted = zeros(length(B)*Hp,Hp)
A_constraints = ones(1,length(lin_sys.StateName))';
b_constraints = zeros(2,length(lin_sys.StateName));
counter = 1;
n =1;
for m = 1:sys_setup(4).component
    if contains(lin_sys.StateName(counter),'in') ==1
        pipe_states = length(data{1,m}.h(1,:));
        
        
        pipe_diameter = pipe_spec(n).d;
        lower_bound = -data{1,1}.h(1,1);
        upper_bound = pipe_diameter-data{1,1}.h(1,1);
        
        
%         b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
%         b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
          b_constraints(1,counter:counter)= [upper_bound];
          b_constraints(2,counter:counter)= [lower_bound];
%           b_constraints(1,counter:counter)= 0;
%           b_constraints(2,counter:counter)= 0;

          
      
    n = n+1;
    elseif contains(lin_sys.StateName(counter),'Tank') ==1
        pipe_states = length(data{1,m}.h(1,:));
        
        
        pipe_diameter = pipe_spec(m).d;
        lower_bound =-data{1,2}.h(1,1);;%-data{1,1}.h(1,1); %% Find lower bound og upper bound på tank
        upper_bound = tank_spec(1).height-data{1,2}.h(1,1);%pipe_diameter-data{1,1}.h(1,1);
        
        
%         b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
%         b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
%           b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
%           b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
          b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
          b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
        
    else
        pipe_states = length(data{1,m}.h(1,2:end));
        
        
        pipe_diameter = pipe_spec(n).d;
        lower_bound = -data{1,1}.h(1,1);
        upper_bound = pipe_diameter-data{1,1}.h(1,1);
        
        
%         b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
%         b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
%           b_constraints(1,counter:counter)= [upper_bound];
%           b_constraints(2,counter:counter)= [lower_bound];
          b_constraints(1,counter:counter)= 0;
          b_constraints(2,counter:counter)= 0;
          
        n = n+1;
    end
    counter= counter+pipe_states;
    
end
b_constraints = b_constraints';
b_constraints2 = b_constraints;
    for n = 1:Hp %%% Lifted A matrix
        if n == 1
            b_constraints= [b_constraints];
        else
            b_constraints = [b_constraints;b_constraints2];
        end
    end
    
    
end


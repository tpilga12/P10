function [b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp,sys_setup)

%% Constraints 

%% Hent tank_spec og r�r_spec ind, samt antal, data
b_constraints = zeros(2,length(lin_sys.StateName));
counter = 1;
n =1;
for m = 1:sys_setup(4).component
    if contains(lin_sys.StateName(counter),'in') ==1
        pipe_states = length(data{1,m}.h(1,:));
        pipe_diameter = pipe_spec(n).d;
        lower_bound = -data{1,1}.h(1,1);
        upper_bound = pipe_diameter-data{1,1}.h(1,1);
        b_constraints(1,counter:counter)= [upper_bound];
        b_constraints(2,counter:counter)= [lower_bound];
        n = n+1;
    elseif contains(lin_sys.StateName(counter),'Tank_') ==1
        pipe_states = length(data{1,m}.h(1,:));
        pipe_diameter = pipe_spec(m).d;
        lower_bound =-data{1,2}.h(1,1);;%-data{1,1}.h(1,1); %% Find lower bound og upper bound p� tank
        upper_bound = tank_spec(1).height-data{1,2}.h(1,1);%pipe_diameter-data{1,1}.h(1,1);
        b_constraints(1,counter:counter-1+pipe_states)= [upper_bound];
        b_constraints(2,counter:counter-1+pipe_states)= [lower_bound];
        
    elseif contains(lin_sys.StateName(counter),'Tank1_u') ==1
        pipe_states = 1;
        b_constraints(1,counter:counter-1+pipe_states)= 0.975-0.1542;
        b_constraints(2,counter:counter-1+pipe_states)= -0.1542;
    else
        pipe_states = length(data{1,m}.h(1,2:end));
        pipe_diameter = pipe_spec(n).d;
        lower_bound = -data{1,1}.h(1,1);
        upper_bound = pipe_diameter-data{1,1}.h(1,1);
        b_constraints(1,counter:counter)= 0;
        b_constraints(2,counter:counter)= 0;
        n = n+1;
    end
    counter= counter+pipe_states;
    
end   
end


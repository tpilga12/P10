function [init_data tank_spec, input] = initialize(input,sys_setup,pipe_spec,tank_spec)
%INTIALIZE Summary of this function goes here
%   Detailed explanation goes here
global error

% if length(input.u_init) < length(tank_spec) && length(tank_spec) > 0 
%     fprintf('error, initial input is not found for all actuators')
%     error = 1;
% end

if error == 1
    init_data = 'Not available';
    return
elseif error == 0
tic    
   
    init = 1; % tank function is used in simulation and initiation where this should be set to 1. 
    tank_nr = 1;
    pipe_component = 0;
    sys_component = 1;
    for x = 1:length(sys_setup)-1
        if strcmp(sys_setup(x).type,'Tank') == 1
            
            tank_spec(tank_nr).Q_out_max = pipe_spec(pipe_component+1).Qf; % sets max tank outflow to max inflow of next pipe
            [init_data{1,sys_component} input] = tank(1, [], tank_nr, x, input, tank_spec, init);
            
            input.Q_init(x+1)= init_data{1,sys_component}.Q(1,end);
            input.C_init(x+1)= init_data{1,sys_component}.C(1,end);
            
            tank_nr = tank_nr + 1;
            sys_component = sys_component + 1;
        else
            temp = init_pipe(pipe_spec((pipe_component+1):(sys_setup(x).component + pipe_component)), input, x, pipe_component, 1e-9);
            if x == 1
                init_data = temp;
            else
                init_data = [ init_data temp{:,:}];
            end
            sys_component = sys_component + sys_setup(x).component;
            pipe_component = pipe_component + sys_setup(x).component;
            
            input.Q_init(x+1)= init_data{1,sys_component-1}.Q(1,end);
            input.C_init(x+1)= init_data{1,sys_component-1}.C(1,end);
        end
    end

 input.Q_init = input.Q_init(1:x);
 input.C_init = input.C_init(1:x);
init_time = toc    
end
end


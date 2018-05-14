function [init_pipe,pipes,init_tank,tanks,state_spec]=pipe_tank_setup(call)
if call == 1
    pipe_load = 1;
    tank_load = 1;
    order = 1;
    %%%%%%%%%% IMPORTANT READ THIS %%%%%%%%%%
    % linearisation needs pipes at start and end.
    % MPC needs linear model to function.
    
    % Non-linear simulation needs pipe at the end meaning that
    % it can run with a tank at the starting point but another control
    % method than MPC is needed unless a predefined control signal is used.
    
    %%%%%%%%%%%%%%%%%% pipe1.1 %%%%%%%%%%%%%%
    pipe.length = 561; % length in meter
    pipe.sections = 30; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 0.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    pipes = pipe_load-1; % amount of pipes
    tanks = tank_load-1; % amount of tanks
    if tanks == 0
        init_tank = 0;
    end
    state_spec = find_state_count(init_pipe,sys_order'); % make list of information on system setup with state count 
return
end

end
function [init_pipe,pipes,init_tank,tanks,state_spec]=pipe_tank_setup(call)
if call == 1
    pipe_load = 1;
    tank_load = 1;
    order = 1;
    
    %%%%%%%%%%%%%%%% Tank1 %%%%%%%%%%%%%%%%%%%
    tank.size = 90; %m^3
    tank.height = 10; %m
    tank.area = tank.size/tank.height; %m^2
    tank.Q_out_max = 0.5; % m^3/s
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_tank(tank_load) = tank;
    tank_load = tank_load + 1;
    sys_order{order} = ('Tank');
    order = order +1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%% pipe1.1 %%%%%%%%%%%%%%
    pipe.length = 303; % length in meter
    pipe.sections = 15; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 0.9; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe1.2 %%%%%%%%%%%%%%
    pipe.length = 27; % length in meter
    pipe.sections = 1; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2.1 %%%%%%%%%%%%%%
    pipe.length = 155; % length in meter
    pipe.sections = 8; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0041; %bed slope
    pipe.d = 1; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe2.2 %%%%%%%%%%%%%%
    pipe.length = 295; % length in meter
    pipe.sections = 14; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0122; %bed slope
    pipe.d = 0.8; %[m] Diameter
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

    
    %%%%%%%%%%%%%%%% Tank1 %%%%%%%%%%%%%%%%%%%
    tank.size = 90; %m^3
    tank.height = 10; %m
    tank.area = tank.size/tank.height; %m^2
    tank.Q_out_max = 0.5; % m^3/s
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_tank(tank_load) = tank;
    tank_load = tank_load + 1;
    sys_order{order} = ('Tank');
    order = order +1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2.3 %%%%%%%%%%%%%%
    pipe.length = 318; % length in meter
    pipe.sections = 15; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0053; %bed slope
    pipe.d = 0.9; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe3.1 %%%%%%%%%%%%%%
    pipe.length = 110; % length in meter
    pipe.sections = 5; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0036; %bed slope
    pipe.d = 0.9; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe4.1 %%%%%%%%%%%%%%
    pipe.length = 38; % length in meter
    pipe.sections = 2; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0024; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe5.1 %%%%%%%%%%%%%%
    pipe.length = 665; % length in meter
    pipe.sections = 30; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe6.1 %%%%%%%%%%%%%%
    pipe.length = 155; % length in meter
    pipe.sections = 7; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0008; %bed slope
    pipe.d = 1; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe6.2 %%%%%%%%%%%%%%
    pipe.length = 955; % length in meter
    pipe.sections = 40; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0029; %bed slope
    pipe.d = 1.2; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe7.1 %%%%%%%%%%%%%%
    pipe.length = 304; % length in meter
    pipe.sections = 15; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 1.2; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe7.2 %%%%%%%%%%%%%%
    pipe.length = 116; % length in meter
    pipe.sections = 5; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0021; %bed slope
    pipe.d = 1.2; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe8.1 %%%%%%%%%%%%%%
    pipe.length = 283; % length in meter
    pipe.sections = 12; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0017; %bed slope
    pipe.d = 1.4; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe9.1 %%%%%%%%%%%%%%
    pipe.length = 31; % length in meter
    pipe.sections = 1; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0019; %bed slope
    pipe.d = 1.4; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe10.1 %%%%%%%%%%%%%%
    pipe.length = 125; % length in meter
    pipe.sections = 6; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0021; %bed slope
    pipe.d = 1.6; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe10.2 %%%%%%%%%%%%%%
    pipe.length = 94; % length in meter
    pipe.sections = 4; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0013; %bed slope
    pipe.d = 1.5; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% pipe10.3 %%%%%%%%%%%%%%
    pipe.length = 360; % length in meter
    pipe.sections = 15; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0046; %bed slope
    pipe.d = 1.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
    pipe.data_location = order;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_pipe(pipe_load) = pipe;
    pipe_load = pipe_load +1;
    sys_order{order} = ('Pipe');
    order = order +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe11.1 %%%%%%%%%%%%%%
    pipe.length = 736; % length in meter
    pipe.sections = 30; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0012; %bed slope
    pipe.d = 1.6; %[m] Diameter
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

%%%%%%%%%%%%%%%%%% END
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
function [init,pipes]=pipe_setup(call)
if call == 1
    load = 1;
    while load < 100 
%%%%%%%%%%%%%%%%%% pipe1.1 %%%%%%%%%%%%%%
    pipe.length = 303; % length in meter
    pipe.sections = 80; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 0.9; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe1.2 %%%%%%%%%%%%%%
    pipe.length = 27; % length in meter
    pipe.sections = 6; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2.1 %%%%%%%%%%%%%%
    pipe.length = 155; % length in meter
    pipe.sections = 10; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0041; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2.2 %%%%%%%%%%%%%%
    pipe.length = 295; % length in meter
    pipe.sections = 15; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0122; %bed slope
    pipe.d = 0.8; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2.3 %%%%%%%%%%%%%%
    pipe.length = 318; % length in meter
    pipe.sections = 20; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0053; %bed slope
    pipe.d = 0.9; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe3.1 %%%%%%%%%%%%%%
    pipe.length = 110; % length in meter
    pipe.sections = 8; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0036; %bed slope
    pipe.d = 0.9; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe4.1 %%%%%%%%%%%%%%
    pipe.length = 38; % length in meter
    pipe.sections = 3; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0024; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe6.1 %%%%%%%%%%%%%%
    pipe.length = 155; % length in meter
    pipe.sections = 8; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0008; %bed slope
    pipe.d = 1; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe6.2 %%%%%%%%%%%%%%
    pipe.length = 955; % length in meter
    pipe.sections = 50; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0029; %bed slope
    pipe.d = 1.2; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe7.1 %%%%%%%%%%%%%%
    pipe.length = 304; % length in meter
    pipe.sections = 20; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.003; %bed slope
    pipe.d = 1.2; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe7.2 %%%%%%%%%%%%%%
    pipe.length = 116; % length in meter
    pipe.sections = 6; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0021; %bed slope
    pipe.d = 1.2; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe9.1 %%%%%%%%%%%%%%
    pipe.length = 31; % length in meter
    pipe.sections = 2; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0019; %bed slope
    pipe.d = 1.4; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe10.2 %%%%%%%%%%%%%%
    pipe.length = 94; % length in meter
    pipe.sections = 5; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0013; %bed slope
    pipe.d = 1.5; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe10.3 %%%%%%%%%%%%%%
    pipe.length = 360; % length in meter
    pipe.sections = 20; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0046; %bed slope
    pipe.d = 1.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe11.1 %%%%%%%%%%%%%%
    pipe.length = 736; % length in meter
    pipe.sections = 40; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.0012; %bed slope
    pipe.d = 1.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% END
%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipes = load-1; % amount of pipes
    load = 100; % stop loop
    end
end

end
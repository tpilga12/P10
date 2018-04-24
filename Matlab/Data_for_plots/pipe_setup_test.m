function [init,pipes]=pipe_setup(call)
if call == 1
    load = 1;
    while load < 100 
%%%%%%%%%%%%%%%%%% pipe1.1 %%%%%%%%%%%%%%
    pipe.length = 303; % length in meter
    pipe.sections = 20; % Number of sections,
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
    pipe.sections = 10; % Number of sections,
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
    pipe.sections = 8; % Number of sections,
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

%%%%%%%%%%%%%%%%%% END
%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipes = load-1; % amount of pipes
    load = 100; % stop loop
    end
end

end
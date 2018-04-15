function [init,pipes]=pipe_setup(call)
if call == 1
    load = 1;
    while load < 100 
%%%%%%%%%%%%%%%%%% pipe1 %%%%%%%%%%%%%%
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 0.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Dx = 2; %[m] grid distance
    pipe.sections=80; % Number of sections,
    pipe.lat_inflow = 1; %side inflow last pipe should not have any.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2 %%%%%%%%%%%%%%
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 0.8; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65;
    pipe.Dx = 10; %[m] grid distance
    pipe.sections=20; % Number of sections,
    pipe.lat_inflow = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    init(load) = pipe ;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe3 %%%%%%%%%%%%%%
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 1.0; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65;
    pipe.Dx = 10; %[m] grid distance
    pipe.sections=30; % Number of sections,
    pipe.lat_inflow = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    init(load) = pipe ;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% END
%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipes = load-1; % amount of pipes
    load = 100; % stop loop
    end
end

end
function [init,pipes]=pipe_setup_test_jacob(call)
if call == 1
    load = 1;
    while load < 100 
%%%%%%%%%%%%%%%%%% pipe1.1 %%%%%%%%%%%%%%
    pipe.length = 80; % length in meter
    pipe.sections = 10; % Number of sections,
    pipe.Dx = pipe.length/pipe.sections; %[m] grid distance
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 0.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65; %
    pipe.Qf = 72*(pipe.d/4)^0.635*pi*(pipe.d/2)^2*pipe.Ib^0.5;
    pipe.lat_inflow = 0; %side inflow last pipe should not have any.
    
     init(load) = pipe;
    load = load +1;
    
    pipes = load-1; % amount of pipes
    load = 100; % stop loop
    
    end
end
end
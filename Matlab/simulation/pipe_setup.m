function [init,pipes]=pipe_setup(call)
if call == 1
    load = 1;
    while load < 100 
%%%%%%%%%%%%%%%%%% pipe1 %%%%%%%%%%%%%%
    pipe.Ib = 0.00214; %bed slope
    pipe.d = 0.6; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
    pipe.Theta = 0.65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipe.Dx = 8; %[m] grid distance
    pipe.sections=40; % Number of sections,

    init(load) = pipe;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% pipe2 %%%%%%%%%%%%%%
    pipe.Ib = 0.0025; %bed slope
    pipe.d = 0.8; %[m] Diameter
    pipe.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipe.Theta = 0.65;
    pipe.Dx = 10; %[m] grid distance
    pipe.sections=20; % Number of sections,
    
    init(load) = pipe ;
    load = load +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%% END %%%%
    pipes = load-1;
    load = 100;
%     init = struct2cell(init);
    end
end

end
function [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m)
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here
global Dt


% insert control here (maybe) to calculate inputs

    init = 0; % tank function is used in initiation where this should be set to 1, here it should be 0 
    tank_nr = 1;
    pipe_component = 1;
    new_pipe = 1;
    sys_component = 1;
     for x = 1:length(sys_setup)-1
         for n = 1:sys_setup(x).component
             if strcmp(sys_setup(x).type,'Tank') == 1 
                 [data{sys_component} input] = tank(m, data{1,sys_component}, tank_nr, x, input, tank_spec, init);
                 sys_component = sys_component + 1;
                 tank_nr = tank_nr + 1;
             else

                 data{sys_component} = pipe(pipe_spec, input, data, pipe_component, m, x, sys_component, new_pipe);
                 sys_component = sys_component + 1;
                 pipe_component = pipe_component + 1;
                 new_pipe = 0;
             end
         end
         
         new_pipe = 1;  
         if x < length(sys_setup)-1
         input.Q_in(m,x+1)= data{1,sys_component-1}.Q(m,end);                 
         input.C_in(m,x+1)= data{1,sys_component-1}.C(m,end);
         end
         
     end




end


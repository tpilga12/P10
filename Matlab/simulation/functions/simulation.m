function [data] = simulation(input, pipe_spec, tank_spec, data, sys_setup, iteration)
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here
global Dt

m = iteration + 1; % start at 2

% insert control here (maybe) to calculate inputs

    init = 0; % tank function is used in initiation where this should be set to 1, here it should be 0+ 
    tank_nr = 0;
    pipe_length = 1;
     component = 1;
     for x = 1:length(sys_setup)-1
         for d= 1:sys_setup(x).component
             if strcmp(sys_setup(x).type,'Tank') == 1 && x == 1
                 tank_nr = tank_nr + 1;
                 data{1,component} = tank(m, data{1,component}, tank_nr, input.Q_in, input.C_in, input,tank_spec,init);
                 component = component + 1;
             elseif strcmp(sys_setup(x).type,'Tank') == 1
                 tank_nr = tank_nr + 1;
                 data{1,component} = tank(m, data{1,component}, tank_nr, data{1,component-1}.Q(m,end), data{1,component-1}.C(m,end), input,tank_spec,init);
                 component = component + 1;                 
             else
                 data = pipe(pipe_spec, input, data, pipe_length, m, component);
                 component = component + 1;
                 pipe_length = pipe_length + 1;
             end
         end
     end
%         if m == 1
%             [data] = pipe(pipe_spec,input,data,x);
%         else
%             [data(1,x)] = pipe(pipe_spec,input,data,x);
%         end
%     end
%     else
%         break
%     end
% 










end


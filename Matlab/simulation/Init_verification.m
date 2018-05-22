clc
clear all
clear path
format long
addpath(['functions'], ['setup'], ['input'])
global Dt iterations error 
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Structure setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = init_setup_verification(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Steady state iteration %%%%%%%%%%%%%%%%%%%%%%
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.25; % initial input flow
input.tank_height_init(:) = [3 3]; % initial tank height
for k = 1:length(pipe_spec)
    input.lat.Q{k} = 0;
    input.lat.C{k} = 0;
end
error = 0;

[data tank_spec input] = initialize(input, sys_setup, pipe_spec, tank_spec);


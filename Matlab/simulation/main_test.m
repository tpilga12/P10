%% Sewer pipe equations
clc
clear all
clear path
format long
addpath(['functions'], ['setup'])
global Dt iterations  
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.3; % initial input flow
input.u_init(1:2) = 0.3; % initial tank actuator input
input.tank_height_init(1:2) = 3; % initial tank height
for k = 1:length(pipe_spec)
    input.lat.Q{k} = 0;
    input.lat.C{k} = 0;
end
error = 0;

% init_data = init_pipe(pipe_spec,input,1e-7);
tic
[init_data tank_spec] = initialize(input, sys_setup, pipe_spec, tank_spec);
toc
tic
lin_sys = linearize_it(pipe_spec, tank_spec, sys_setup, input, init_data);
toc
%% run stuff !!!!!
clc
iterations = 1000;
data = init_data;
% data{1} = 0;
for m = 1:iterations
        %%%%%% inputs %%%%%%%%%%%%
    input.C_in= 8; % concentrate input [g/m^3]
    input.Q_in = 0.3 + sin(m/100)/15;
    input.u = [0.35 0.35]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
    
    [data] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
    

end

%%

sampling = 4; %increase number to skip samples in playback to increase speed

playback_speed = 1/10; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling)


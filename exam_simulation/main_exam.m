%% Sewer pipe equations
clc
clear all
clear path
format long
addpath(['functions'], ['setup'],['disturbance'])
global Dt iterations error 
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;

[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_setup_fredericia(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.25; % initial input flow
input.tank_height_init(:) = [3 3]; % initial tank height
input.u_init = [1 1]; % dummy initialization
error = 0;

[data tank_spec, input] = initialize(input, sys_setup, pipe_spec, tank_spec);
[lin_point lin_sys] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);

%% run stuff !!!!!
clc
iterations = 300;
input.Q_in = input.Q_init;  input.C_in = input.C_init;  input.u = input.u_init;
tic
for m = 2:(iterations+1)
        %%%%%% inputs %%%%%%%%%%%%
         input.C_in(m,1) = 8; % concentrate input [g/m^3]
         if m > 40
            input.C_in(m,1) = 10;   
         end
        input.Q_in(m,1) = 0.25 + sin(m/2)/100;
         input.u(m,1) =0.19+ sin(m/10)/30; %0.14;% 
         input.u(m,2) =input.u_init(2); %0.108;%

        [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
end
toc
%%

sampling = 2; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 0)
playback_speed = 1/30; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)
%%

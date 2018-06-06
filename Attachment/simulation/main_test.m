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

[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup_experiment_2(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load disturbance_from_house_holds_and_small_industry % Load the households and small industry disturbance
load brewery_datav2.mat % load disturbance from brewery and bottle plant
brewery_disturbance = [brewery_disturbance brewery_disturbance brewery_disturbance brewery_disturbance]; 

input.C_init = 0; % initial concentrate in pipe
input.Q_init = 0.05; % initial input flow
input.u_init(:) = [0.35 0.35]; % initial tank actuator input
input.tank_height_init(:) = [0.3 3]; % initial tank height

[input] = disturbance_input(1,Dt,input,disturbance,brewery_disturbance,pipe_spec);  
error = 0;

% init_data = init_pipe(pipe_spec,input,1e-7);

[data tank_spec, input] = initialize(input, sys_setup, pipe_spec, tank_spec);
tic
[lin_point lin_sys] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);
toc
i=1;
%% run stuff !!!!!
clc

iterations = 8640;

input.Q_in = input.Q_init;  input.C_in = input.C_init;  input.u = input.u_init;
tic
for m = 2:(iterations+1)
        %%%%%% inputs %%%%%%%%%%%%
%         input.C_in(m,1) = 0; % concentrate input [g/m^3]
        
        [input] = disturbance_input(m,Dt,input,disturbance,brewery_disturbance,pipe_spec);
        %     end
        input.u(m,1) = 0.14;% 
        input.u(m,2) = 0.108;%

        [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
        
        row = m;
        [C_r(m,:) possible_Dt] = courant(data, pipe_spec, Dt, row, 1);
end
toc
%%

sampling = 10; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 0)
playback_speed = 1/100; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)
%%

%% Sewer pipe equations
clc
clear all
clear path
format long
addpath(['functions'], ['setup'])
global Dt iterations error 
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup_experiment(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.35; % initial input flow
input.u_init(:) = [0.35 0.35]; % initial tank actuator input
input.tank_height_init(:) = [3 3]; % initial tank height
for k = 1:length(pipe_spec)
    if pipe_spec(k).lat_inflow == 1
    input.lat.Q{k} = 0.0;
    else
    input.lat.Q{k} = 0;
    end
    input.lat.C{k} = 0;
    
end
error = 0;

% init_data = init_pipe(pipe_spec,input,1e-7);

[data tank_spec, input] = initialize(input, sys_setup, pipe_spec, tank_spec);
tic
[lin_point lin_sys sysT] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);
toc
%% run stuff !!!!!
clc
iterations = 500;
input.Q_in = input.Q_init;  input.C_in = input.C_init;  input.u = input.u_init;

utank1(1) = input.u_init(1,1);
utank1(2) = input.u_init(1,2);
tic
for m = 2:iterations
        %%%%%% inputs %%%%%%%%%%%%
    input.C_in(m,1) = 8; % concentrate input [g/m^3]
%     if m >= 100
%         input.Q_in(m,1) = 0.25;
%     else
    input.Q_in(m,1) = 0.35;% + sin(m/10)/35 ;%+ sin(m/100)/15;
%     end
    utank1(m,1) = input.u_init(1,1);% + sin(m/10)/35;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)

    
    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
  

end
toc
%%

sampling = 1; %increase number to skip samples to increase playback speed
starting_point = 0; % change starting point (START IS 0)
playback_speed = 1/1; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)


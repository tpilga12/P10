%% Sewer pipe equations
clc
clear all
clear path
format long
addpath(['functions'], ['setup'])
global Dt iterations m 
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
% [pipe_spec nr_pipes] = pipe_setup_test_jacob(1);
% [pipe_spec nr_pipes] = pipe_setup(1);
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
[init_data tank_spec] = initialize(input, sys_setup, pipe_spec, tank_spec);
lin_sys = linearize_it(pipe_spec, tank_spec, sys_setup, init_data);
%% run stuff !!!!!
clc
iterations = 1000;
data = init_data;
% data{1} = 0;
for m = 1:iterations
    if error == 0;
    %%%%%% inputs %%%%%%%%%%%%
    input.C_in= 8; % concentrate input [g/m^3]
    input.Q_in = 0.3 + sin(m/50)/15;
%     input.lat.Q{1} = 0;%0.01;
%     input.lat.C{1} = 20;
%     input.lat.Q{2} = 0;%0.05;
%     input.lat.C{2} = 10;

%     OD = 0.2+sin(m)/10;
    %%%%%%%%%%%%%%%%%%%%%%
% %    [Q_out error]=tank(Q_in,OD,pipe_spec,Volume,tank_height,height)
%     [tank_out error tank_height]=tank(input.Q_in,OD,pipe_spec,20,3,1);
%     input.Q_in = tank_out;
%     q_tankos(m) = tank_out;
%    hoejde_tank(m) = tank_height;
    for x = 1:nr_pipes
        if m == 1
            [data] = pipe(pipe_spec,input,data,x);
        else
            [data(1,x)] = pipe(pipe_spec,input,data,x);
        end
    end
    else
        break
    end
end

%%

sampling = 3; %increase number to skip samples in playback to increase speed

playback_speed = 1/10; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data,nr_pipes,playback_speed,Dt,pipe_spec,sampling)


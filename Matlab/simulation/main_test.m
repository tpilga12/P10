%% Sewer pipe equations
clc
clear all
clear path
format long
addpath(['functions'], ['setup'])
global Dt iterations m afstand
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
% [pipe_spec nr_pipes] = pipe_setup_test_jacob(1);
% [pipe_spec nr_pipes] = pipe_setup(1);
[pipe_spec,nr_pipes,tank_spec,nr_tanks,sys_setup] = pipe_tank_setup(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.2;
for k = 1:length(pipe_spec)
    input.lat.Q{k} = 0;
    input.lat.C{k} = 0;
end
error = 0;

init_data = init(pipe_spec,input,1e-7);
%% run stuff !!!!!
clc
iterations = 10000;
data = init_data;
% data{1} = 0;
for m = 1:iterations
    if error == 0;
    %%%%%% inputs %%%%%%%%%%%%
    input.C_in= 8; % concentrate input [g/m^3]
    input.Q_in = 0.2 + sin(m/50)/30;
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
sampling = 1000; %increase number to skip samples in playback to increase speed
playback_speed = 1/10; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu power)
plot_data(data,nr_pipes,playback_speed,Dt,pipe_spec,sampling)


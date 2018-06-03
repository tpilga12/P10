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
% [pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup(1);
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup_experiment(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load disturbance_from_house_holds_and_small_industry % Load the households and small industry disturbance
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.25; % initial input flow
input.u_init(:) = [0.35 0.35]; % initial tank actuator input
input.tank_height_init(:) = [3 3]; % initial tank height
for k = 1:length(pipe_spec)
    if pipe_spec(k).lat_inflow == 1
    input.lat.Q{k} = 0;
    else
    input.lat.Q{k} = 0;
    end
    input.lat.C{k} = 0;
    
end
error = 0;

% init_data = init_pipe(pipe_spec,input,1e-7);

[data tank_spec, input] = initialize(input, sys_setup, pipe_spec, tank_spec);
tic
[lin_point lin_sys] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);
toc
i=1;
%% run stuff !!!!!
clc
flag =1;

iterations = 8640;

input.Q_in = input.Q_init;  input.C_in = input.C_init;  input.u = input.u_init;

utank1(1) = input.u_init(1,1);
utank1(2) = input.u_init(1,2);
tic
for m = 2:(iterations+1)
        %%%%%% inputs %%%%%%%%%%%%
        input.C_in(m,1) = 8; % concentrate input [g/m^3]
    if m >= 100
%         input.Q_in(m,1) = 0.25;
        input.C_in(m,1) = 10; % concentrate input [g/m^3]
%     else
    end
 
        if i == 86400
            i =1;
            disp('var her')
        end
        input.lat.Q(3) = num2cell(disturbance.Zone1_1(i)+disturbance.Zone1_2(i)+disturbance.Zone1_3(i)+disturbance.Industry_1_1(i)+disturbance.Industry_1_3(i));
        input.lat.Q(6) = num2cell(disturbance.Zone2(i));
        input.lat.Q(7) = num2cell(disturbance.Zone3(i));
        input.lat.Q(8) = num2cell(disturbance.Zone4_1(m)+disturbance.Zone4_2(i)+disturbance.Zone4_3(i)+disturbance.Industry_4_1(i));
        input.lat.Q(9) = num2cell(disturbance.Zone5(i));
        input.lat.Q(11)= num2cell(disturbance.Zone6(i));
        input.lat.Q(13)= num2cell(disturbance.Zone7(i)+disturbance.Industry7_1(i));
        input.lat.Q(14)= num2cell(disturbance.Zone8And9(i)+disturbance.Industry_8And9(i));
%          input.lat.Q(15)= num2cell(disturbance.Zone10(m));
        input.lat.Q(18)= num2cell(disturbance.Zone11(i));

        i = m*20;
        
        
    input.Q_in(m,1) = 0.025;% + sin(m/10)/35 ;%+ sin(m/100)/15;
%     end
    utank1(m,1) = input.u_init(1,1);% + sin(m/10)/8;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)

    
    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
  

end
toc
%%

sampling = 20; %increase number to skip samples to increase playback speed
starting_point = 800; % change starting point (START IS 0)
playback_speed = 1/100; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)


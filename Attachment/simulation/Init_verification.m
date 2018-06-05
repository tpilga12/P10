clc
clear all
clear path
format long
addpath(['functions'], ['setup'], ['input'])
global Dt iterations error 
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Structure setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dt = 20;
% [pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = init_setup_verification(1);
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_setup_init_fredericia(1);
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

%%

figure(3)
plot(data{1}.fitfunc)
hold on
plot(data{1}.lut.Q,data{1}.lut.h)
xlim([-0.05 1])
ylim([-0.05 0.95])
grid
legend('Curve fit','Raw data','Location','northwest')

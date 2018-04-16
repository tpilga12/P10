%% Sewer pipe equations
clc
clear all
global Dt iterations Q_init C_init m
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
iterations = 400;
Dt = 25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C_init = 8; % initial concentrate in pipe
Q_init = 0.015;

[pipe_spec nr_pipes] = pipe_setup(1);

data{1} = 0;
for m = 1:iterations
    if error = 0;
    %%%%%% inputs %%%%%%%%%%%%
    input.C_in= 10; % concentrate input [g/m^3]
    input.Q_in = 0.015 +sin(m)/100;
    input.lat.Q{1} = 0.01;
    input.lat.C{1} = 20;
    input.lat.Q{2} = 0.05;
    input.lat.C{2} = 10;
    %%%%%%%%%%%%%%%%%%%%%%
    for x = 1:nr_pipes
        [data(1,x)] = pipe(pipe_spec,input,data,x);
    end
    else
        break
    end
end

%%
plot_data(data,nr_pipes,0.1,Dt,pipe_spec)


%data = simulation(Q_init,C_init)

% for m = 1:iterations
 %[pipe1] = pipe(setup(1),pipe1,m);
%  [pipe1] = pipe(pipe2.pipe_spec,pipe2.pipe_sim,pipe2.pipe_in,pipe2.pipe1,m);
% [Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
% end
%% Sewer pipe equations
clc
%clear all
clear path
format long
addpath(['functions'], ['setup'])
global Dt iterations m afstand
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

iterations = 25000;
Dt = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pipe_spec nr_pipes] = pipe_setup_zone_1(1);
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.01;
for k = 1:length(pipe_spec)
    input.lat.Q{k} = 0;
    input.lat.C{k} = 0;
end
error = 0;

init_data = init(pipe_spec,input);
%% run stuff !!!!!
clc
data = init_data;
% data{1} = 0;
for m = 1:iterations
    if error == 0;
    %%%%%% inputs %%%%%%%%%%%%
    input.C_in= 8; % concentrate input [g/m^3]
    input.Q_in =f1_3(m)+0.01;% 0.04 + sin(m)/1000;
    input.lat.Q{1} = f1_2(m)+0.01;%0.01;
    input.lat.C{1} = 0;
    input.lat.Q{2} = f1_1(m)+0.01;%0;%0.05;
    input.lat.C{2} = 0;

    OD = 0.2+sin(m)/10;
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
plot_data(data,nr_pipes,5e-6,Dt,pipe_spec)


%data = simulation(Q_init,C_init)

% for m = 1:iterations
 %[pipe1] = pipe(setup(1),pipe1,m);
%  [pipe1] = pipe(pipe2.pipe_spec,pipe2.pipe_sim,pipe2.pipe_in,pipe2.pipe1,m);
% [Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
% end
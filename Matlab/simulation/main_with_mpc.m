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
[pipe_spec, nr_pipes, tank_spec, nr_tanks, sys_setup] = pipe_tank_setup(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hp = 10;% Prediciton horizon
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.15; % initial input flow
input.u_init(:) = [0.35 0.35]; % initial tank actuator input
input.tank_height_init(:) = [3 3]; % initial tank height
for k = 1:length(pipe_spec)
    input.lat.Q{k} = 0;
    input.lat.C{k} = 0;
end
error = 0;

% init_data = init_pipe(pipe_spec,input,1e-7);

[data tank_spec, input] = initialize(input, sys_setup, pipe_spec, tank_spec);
tic
[lin_point lin_sys sysT] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);
toc
%% MPC HUSK AT LAVE FORSTYRELSE MATRICEN RIGTIG OG IKKE BARE KOPIR B
k = 120;
Test_matrix = zeros(k,k);
p = 0;
for m =1:k
    for n =1:k-p  
      Test_matrix(n+p,m) = 1; 
    end
  p=p+1;
end
%%
length_C = 0;
C_matrix_mpc = zeros(10,length(lin_sys.C)*Hp);
C_matrix_mpc_constraint=zeros(1,length(lin_sys.A)); 
C_matrix_mpc_constraint(1,37)=1;
%%
for n=1:4
   C_matrix_mpc(n,1+length_C:length(C_matrix_mpc_constraint)*n) = C_matrix_mpc_constraint;
    length_C = length(lin_sys.A)*n;
end

%% run stuff !!!!!
clc
iterations = 500;

h_input=[0.3 0];
u=[h_input;h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
% data = init_data;
input.C_in = input.C_init;
input.Q_in = input.Q_init;
input.u = input.u_init;
% data{1} = 0;
utank1(1) = input.u_init(1,1);
utank1(2) = input.u_init(1,2);
[psi gamma theta Q Alifted Bulifted ] = lifted_system(lin_sys,Hp);
u_output_tank_old(120,1) =  input.u_init(1,1);
counter = 1;
p=1;
n=1;

%%
for m = 2:iterations
    
        %%%%%% inputs %%%%%%%%%%%%
    input.C_in(m,1) = 8; % concentrate input [g/m^3]
    input.Q_in(m,1) = 0.15;% + sin(m/100)/35 ;%+ sin(m/100)/15;
    
    utank1(m,1) = input.u_init(1,1);% + sin(m/10)/65;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
if m > 4
    utank1(m,1) =  u_output_tank(n);
    input.lat.Q{4} = sin(m/10)/65;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
    n=n+1;
end
    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
  
%     if counter < 100
%         counter = counter +1;
%     else
%         p = 1 ;
%     end
    
     if p==1
        [xstates delta_xstates xstates_old]=collect_states(data,m,lin_sys);
        
        [A_constraints b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp);
    
        [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,Q,delta_xstates, A_constraints, b_constraints,Alifted,Bulifted,xstates_old,u_output_tank_old,Test_matrix,xstates,C_matrix_mpc,input);
        u_output_tank = X(1)+u_output_tank_old;
        u_output_tank_old =X(1)+u_output_tank_old; 
        counter =1;
%         p =0;
        n=1;
     end
 end

%%

sampling = 1; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 1)
playback_speed = 1/5; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)


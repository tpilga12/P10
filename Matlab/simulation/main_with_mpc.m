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
Hp = 30;% Prediciton horizon
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
k = 360;
Test_matrix = zeros(k,k);
p = 0;
for m =1:k
    for n =1:k-p  
      Test_matrix(n+p,m) = 1; 
    end
  p=p+1;
end


%%% C matrix to multiply onto the Constraints to pick the correct one
length_C = 0;
C_matrix_mpc = zeros(10,length(lin_sys.C)*Hp);
C_matrix_mpc_constraint=zeros(1,length(lin_sys.A)); 
C_matrix_mpc_constraint(1,37:38)=1;

for n=1:Hp
   C_matrix_mpc(n,1+length_C:length(C_matrix_mpc_constraint)*n) = C_matrix_mpc_constraint;
    length_C = length(lin_sys.A)*n;
end

Qf = pipe_spec(1).Qf;
d = pipe_spec(1).d;
h_test=0.0001:d/100:d;
for t = 1:100
    
    Q_test(t)=(0.46 - 0.5 *cos(pi*(h_test(t)/d))+0.04*cos(2*pi*(h_test(t)/d)))*Qf;
   
end
fitfunc = fit(h_test',Q_test','poly9');


%% run stuff !!!!!
clc
iterations = 500;



% data = init_data;
input.C_in = input.C_init;
input.Q_in = input.Q_init;
input.u = input.u_init;
% data{1} = 0;
utank1(1) = input.u_init(1,1);
utank1(2) = input.u_init(1,2);

[psi gamma theta Q Alifted Bulifted] = lifted_system(lin_sys,Hp);
u_output_tank_old(1,1) =  0;
counter = 1;
p=1;
n=1;

  h_input1=fitfunc(input.Q_in(1,1)); 
 
  h_input=[0];
  u=[h_input1;h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];  
D_old = u;
    for n = 1:Hp %%% Lifted D matrix
        if n == 1
            D_old = [u.^n];
        else
            D_old = [D_old; u.^(n-1)];
        end
    end
%%
for m = 2:iterations
   tic 
        %%%%%% inputs %%%%%%%%%%%%
    input.C_in(m,1) = 8; % concentrate input [g/m^3]
    input.Q_in(m,1) = 0.15 + sin(m/8)/35 ;%+ sin(m/100)/15;
    
    utank1(m,1) = input.u_init(1,1);% + sin(m/10)/65;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
if m > 4
    utank1(m,1) =  u_output_tank(n);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
    n=n+1;
end
    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
  h_input1=[fitfunc(input.Q_in(m,1))];    
  u=[h_input1;h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];    
    for n = 1:Hp %%% Lifted D matrix
        if n == 1
            Dlifted = [u.^n];
        else
            Dlifted = [Dlifted; u.^(n-1)];
        end
    end
    D_delta = Dlifted - D_old;
    D_old = Dlifted;
%     if counter < 100
%         counter = counter +1;
%     else
%         p = 1 ;
%     end
    
     if p==1
        [xstates delta_xstates xstates_old]=collect_states(data,m,lin_sys);
        
        [A_constraints b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp);
    
        [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, A_constraints, b_constraints,Alifted,Bulifted,xstates_old,u_output_tank_old,Test_matrix,xstates,C_matrix_mpc,input,Dlifted,D_delta);
        u_output_tank = X(1)+u_output_tank_old+input.u_init(1,1);%u_output_tank_old;
        u_output_tank_old =X(1);%+u_output_tank_old+input.u_init(1,1);%u_output_tank_old; 
        counter =1;
%         p =0;
        n=1;
     end
     toc
 end

%%

sampling = 1; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 1)
playback_speed = 1/15; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)


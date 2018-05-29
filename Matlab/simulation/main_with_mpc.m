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
Hp = 60;% Prediciton horizon
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

[SUM_matrix_mpc C_matrix_mpc fitfuncv2]= mpc_init_sewer(size(Bulifted,2),Hp,lin_sys,pipe_spec); 
u_output_tank_old(1,1) =  0;
counter = 1;
p=1;
n=1;

  h_input1=fitfuncv2(input.Q_in(1,1)); 
 
  h_input=[0];
  u=[h_input1;h_input];%; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];  
D_old = u;
    for n = 1:Hp %%% Lifted D matrix
        if n == 1
            D_old = [u.^n];
        else
            D_old = [D_old; u.^(n-1)];
        end
    end

%% Disturbance
disturbance_input = zeros(1,iterations);
i =1;
p=1;
counter =1;
ramp= 0;
index = 0.05;
for n= 1:iterations/40
    
    for i= 1:20 
       disturbance_input(1,counter) = 0; 
       counter = counter +1;
    end    
    for p= 1:20 
       if p < 11  
            disturbance_input(1,counter) =index+ramp; 
            ramp = ramp +index;
       else
            disturbance_input(1,counter) = ramp-index; 
            ramp = ramp -index;
       end
       counter = counter +1;
    end   
end

counter = 1;
p=1;
n=1;
%%
tic
for m = 2:iterations
   
        %%%%%% inputs %%%%%%%%%%%%
    input.C_in(m,1) = 8; % concentrate input [g/m^3]
    input.Q_in(m,1) = 0.15 +disturbance_input(1,m)';%+ sin(m/100)/15;
%     input.Q_in(m,1) = 0.15 + sin(m/100)/10;
    
    utank1(m,1) = input.u_init(1,1);% + sin(m/10)/65;
    utank2(m,1) = input.u_init(1,2);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
if m > 4
    utank1(m,1) =  u_output_tank(n);
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
    n=n+1;
end
    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
  h_input1=[fitfuncv2(input.Q_in(m,1))];    
    u=[h_input1;h_input];%; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];    
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
        xstates_save(m-1,1:length(xstates)) = xstates';
        [b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp,sys_setup);
    
        [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta);
%         if data{1,2}.h(m-1,1) == 0
%             u_output_tank =0.01;
%             u_output_tank_old =0.01;
%         else
%         u_output_tank = X(1)+u_output_tank_old+input.u_init(1,1);%u_output_tank_old;
%         u_output_tank_old =X(1);%+u_output_tank_old+input.u_init(1,1);%u_output_tank_old; 
%         end
        u_output_tank = X(1)+u_output_tank_old+input.u_init(1,1);%u_output_tank_old;
        u_output_tank_old =X(1)+u_output_tank_old;%+u_output_tank_old+input.u_init(1,1);%u_output_tank_old; 
        counter =1;
%         p =0;
        n=1;
     end
     
 end
toc

%%

sampling = 1; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 1)
playback_speed = 1/15; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)


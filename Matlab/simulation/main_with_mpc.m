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
Hp = 20;% Prediciton horizon
load disturbance_from_house_holds_and_small_industry % Load the households and small industry disturbance
load brewery_datav2.mat
input.C_init = 8; % initial concentrate in pipe
input.Q_init = 0.20; % initial input flow
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
[lin_point lin_sys] = linearize_it(pipe_spec, nr_tanks, tank_spec, sys_setup, input, data);
toc
%% run stuff !!!!!
clc
iterations = 360;
xstates_linear = lin_point.x0-lin_point.x0(1);

xstates_linear(7,1) =xstates_linear(7,1) -xstates_linear(7,1); 


% data = init_data;
input.C_in = input.C_init;
input.Q_in = input.Q_init;
input.u = input.u_init;
% data{1} = 0;
utank1(1) = input.u_init(1,1);
utank1(2) = input.u_init(1,2);



[psi gamma theta Q Alifted Bulifted C_insert omega Blifted ] = lifted_system(lin_sys,Hp);

[SUM_matrix_mpc C_matrix_mpc fitfuncv2 C_matrix_output C_matrix_mpc2]= mpc_init_sewer(size(Bulifted,2),Hp,lin_sys,pipe_spec); 
u_output_tank_old(1,1) =  0;
h_input1=fitfuncv2(input.Q_in(1,1)); 
h_input=[0];
u=[h_input1;h_input];%; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];  
u_output_tank=utank1(1,1);



counter = 1;
p=1;
n=1; 
D_old = u;
    for n = 1:Hp %%% Lifted Disturbance vector
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
index = 0.140;
% index = 0;
for n= 1:iterations/20
    
    for i= 1:10
       disturbance_input(1,counter) = 0; 
       counter = counter +1;
    end    
    for p= 1:10
       if p < 6  
%            disturbance_input(1,counter)=0.051;
            disturbance_input(1,counter) =index+ramp; 
            ramp = ramp +index;
       else
%            disturbance_input(1,counter)=-0.051;
            disturbance_input(1,counter) = ramp-index; 
            ramp = ramp -index;
       end
       counter = counter +1;
    end   
    ramp = 0;
end
counter = 1;
p=1;
n=1;

%%
tic
hold on
for m = 2:iterations

        %%%%%% inputs %%%%%%%%%%%%
    input.C_in(m,1) = 8; % concentrate input [g/m^3]
    input.Q_in(m,1) = 0.2+disturbance_input(1,m)';%+ sin(m/100)/15;
%     input.Q_in(m,1) = sin(m/10)/15;

       utank1(m,1) =  u_output_tank;
       utank2(m,1) = input.u_init(1,2);
 
    input.u(m,:) = [utank1(m) utank2(m)]; %input is needed for all actuators, try and remember (look for nr_tanks in workspace) :)
    n=n+1;

    [data input] = simulation(input, pipe_spec, tank_spec, data, sys_setup, m);
    
    % Linear stuff
   h_input1=[fitfuncv2(input.Q_in(m,1))]; 
%   h_input2=[fitfuncv2(utank1(m,1))]; 
     u=[h_input1; utank1(m,1)];%; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input];  
%     disp(u)
%     xstates_k_plus_one_linear= lin_sys.A*xstates_linear+lin_sys.B*u+lin_sys.B*[disturbance_input(m); 0];
%     delta_xstates_linear = xstates_k_plus_one_linear-xstates_linear;
%     y(m,1:length(xstates_k_plus_one_linear))=C_matrix_output* xstates_k_plus_one_linear;
%     temp(m,1:length(xstates_k_plus_one_linear)) = xstates_k_plus_one_linear;
    
    
  
    for n = 1:Hp %%% Lifted D matrix
        if n == 1
            Dlifted = [u.^n];
        else
            Dlifted = [Dlifted; u.^(n-1)];
        end
    end
    D_delta = Dlifted - D_old;
    D_old = Dlifted;

    %%
    
     if p==1
        [xstates delta_xstates xstates_old]=collect_states(data,m,lin_sys);
        xstates_save(m-1,1:length(xstates)) = xstates';
        
        [b_constraints]= constraints_mpc(lin_sys, data,pipe_spec,tank_spec,Hp,sys_setup);
        
         %Nonliner constraints
         % Constraints for tank height for normal lifted
          if m ==2 
          b_constraints1(:,1)= b_constraints(1,7)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc*Alifted*(xstates')-C_matrix_mpc*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old-C_matrix_mpc*Bulifted*Dlifted;
          b_constraints1(:,2)= -b_constraints(2,7)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc*Alifted*(xstates')+C_matrix_mpc*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old+C_matrix_mpc*Bulifted*Dlifted;
          b_constraints1(:,3)= b_constraints(1,8)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc2*Alifted*(xstates')-C_matrix_mpc2*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old-C_matrix_mpc2*Bulifted*Dlifted;
          b_constraints1(:,4)= -b_constraints(2,8)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc2*Alifted*(xstates')+C_matrix_mpc2*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old+C_matrix_mpc2*Bulifted*Dlifted;
          b_constraints2(:,1)= (1-input.u(1,1))*ones(size(Bulifted,2),1)-ones(size(Bulifted,2),1)*u_output_tank_old;
          b_constraints2(:,2)= (0+input.u(1,1))*ones(size(Bulifted,2),1)+ones(size(Bulifted,2),1)*u_output_tank_old;
          end
           
%           %
%           if m ==2 
%           b_constraints1(:,1)= b_constraints(1,7)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc*Alifted*(xstates')-C_matrix_mpc*Blifted*[u_output_tank_old;0]-C_matrix_mpc*Blifted*[Dlifted(1,1);0];
%           b_constraints1(:,2)= -b_constraints(2,7)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc*Alifted*(xstates')+C_matrix_mpc*Blifted*[u_output_tank_old;0]+C_matrix_mpc*Blifted*[Dlifted(1,1);0];
%           b_constraints1(:,3)= b_constraints(1,8)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc2*Alifted*(xstates')-C_matrix_mpc2*Blifted*[u_output_tank_old;0]-C_matrix_mpc2*Blifted*[Dlifted(1,1);0];
%           b_constraints1(:,4)= -b_constraints(2,8)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc2*Alifted*(xstates')+C_matrix_mpc2*Blifted*[u_output_tank_old;0]+C_matrix_mpc2*Blifted*[Dlifted(1,1);0];
%           b_constraints2(:,1)= (1-input.u(1,1))*ones(size(Bulifted,2),1)-ones(size(Bulifted,2),1)*u_output_tank_old;
%           b_constraints2(:,2)= (0+input.u(1,1))*ones(size(Bulifted,2),1)+ones(size(Bulifted,2),1)*u_output_tank_old;
%           end

%               if m ==2 
%           b_constraints1(:,1)= b_constraints(1,7)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc*Alifted*(xstates')-C_matrix_mpc*Blifted*[u_output_tank_old;0]-C_matrix_mpc*Blifted*[0;D_old(1,1)] -C_matrix_mpc*Bulifted*Dlifted;
%           b_constraints1(:,2)= -b_constraints(2,7)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc*Alifted*(xstates')+C_matrix_mpc*Blifted*[u_output_tank_old;0]+C_matrix_mpc*Blifted*[0;D_old(1,1)] +C_matrix_mpc*Bulifted*Dlifted;
%           
% 
% % b_constraints1(:,3)= b_constraints(1,8)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc2*Alifted*(xstates')-C_matrix_mpc2*Blifted*[u_output_tank_old;0]-C_matrix_mpc2*Blifted*[Dlifted(1,1);0];
% %           b_constraints1(:,4)= -b_constraints(2,8)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc2*Alifted*(xstates')+C_matrix_mpc2*Blifted*[u_output_tank_old;0]+C_matrix_mpc2*Blifted*[Dlifted(1,1);0];
%           b_constraints2(:,1)= (1-input.u(1,1))*ones(size(Bulifted,2),1)-ones(size(Bulifted,2),1)*u_output_tank_old;
%           b_constraints2(:,2)= (0+input.u(1,1))*ones(size(Bulifted,2),1)+ones(size(Bulifted,2),1)*u_output_tank_old;
%           end

          % linear
%              if m ==2 
%           b_constraints1(:,1)= b_constraints(1,7)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc*Alifted*(xstates_linear)-C_matrix_mpc*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old-C_matrix_mpc*Bulifted*Dlifted;
%           b_constraints1(:,2)= -b_constraints(2,7)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc*Alifted*(xstates_linear)+C_matrix_mpc*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old+C_matrix_mpc*Bulifted*Dlifted;
%           b_constraints1(:,3)= b_constraints(1,8)*ones(size(C_matrix_mpc,1),1)-C_matrix_mpc2*Alifted*(xstates_linear)-C_matrix_mpc2*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old-C_matrix_mpc2*Bulifted*Dlifted;
%           b_constraints1(:,4)= -b_constraints(2,8)*ones(size(C_matrix_mpc,1),1)+C_matrix_mpc2*Alifted*(xstates_linear)+C_matrix_mpc2*Bulifted*ones(size(Bulifted,2),1)*u_output_tank_old+C_matrix_mpc2*Bulifted*Dlifted;
%           b_constraints2(:,1)= (1-input.u(1,1))*ones(size(C_matrix_mpc,1),1)-ones(size(C_matrix_mpc,1),1)*u_output_tank_old;
%           b_constraints2(:,2)= (0+input.u(1,1))*ones(size(C_matrix_mpc,1),1)+ones(size(C_matrix_mpc,1),1)*u_output_tank_old;
%           end
% %   

           % Nonlinear
    [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta,b_constraints1, C_matrix_mpc2, b_constraints2,omega);
%         [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates,C_matrix_mpc,input,Dlifted,D_delta,b_constraints1, C_matrix_mpc2, b_constraints2,omega,D_old);

        % Linear
%         [X,FVAL,EXITFLAG]=quadprog_mpc(gamma,psi,theta,Q,delta_xstates_linear, b_constraints,Alifted,Bulifted,u_output_tank_old,SUM_matrix_mpc,xstates_k_plus_one_linear,C_matrix_mpc,input,Dlifted,D_delta,b_constraints1,C_matrix_mpc2, b_constraints2,omega);
        u_output_tank = ((X(1))+u_output_tank_old+input.u_init(1,1));%+input.u_init(1,1);%u_output_tank_old;
        u_output_tank_old =(u_output_tank-u_output_tank_old-input.u_init(1,1))-X(1);%+u_output_tank_old+input.u_init(1,1);%u_output_tank_old; 

        counter =1;
        n=1;
     end

 end
toc

%%

sampling = 1; %increase number to skip samples to increase playback speed
starting_point = 1; % change starting point (START IS 1)
playback_speed = 1/5; % 1/fps -> set desired frames per second (warning this is heavily limited by cpu speed)
plot_data(data, nr_tanks, nr_pipes, sys_setup, playback_speed, Dt, pipe_spec, tank_spec, sampling,starting_point)

%% Plot for linear MPC


close all     
figure(1)
plot(temp(1:end,1))
title('First state')
figure(2)
plot(temp(1:end,7))
title('tank height')
figure(3)
plot(temp(1:end,8))
title('Output of tank')
figure(4)
plot(temp(1:end,6))
title('input state - to tank')

%%
close all

t = 1:20:7200;
figure(1)
reduce_plot(t,data{1}.h(1:end,1))
xlabel('Time [hh:mm]')
ylabel('Height [m]')
xticklabels({'00:00','00:20','00:40','01:00','01:20','01:40','02:00'})
set(gca,'xtick',[0:1200:7200])
xlim([0 7200])
grid


figure(2)
reduce_plot(t,data{2}.h(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Height [m]')
xticklabels({'00:00','00:20','00:40','01:00','01:20','01:40','02:00'})
set(gca,'xtick',[0:1200:7200])
xlim([0 7200])
grid

figure(3)
reduce_plot(t,data{3}.h(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Height [m]')
xticklabels({'00:00','00:20','00:40','01:00','01:20','01:40','02:00'})
xlim([0 7200])


grid

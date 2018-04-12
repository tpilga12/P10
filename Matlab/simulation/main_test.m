%% Sewer pipe equations
clc
clear all
global Dt iterations Q_init C_init
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
iterations = 800;
Dt = 30;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C_init = 8; % initial concentrate in pipe

Q_init = 0.015;

input.C_in= 10; % concentrate input [g/m^3]
input.Q_in = 0.015;


[pipe_spec nr_pipes] = pipe_setup(1);
pieces = nr_pipes + 0; %add other pieces that should be in the simulation
data{1} = 0;
for m = 1:iterations
    if m == 200
        input.Q_in = 0.03;
    elseif m > 600
        input.Q_in = 0.05;
    end
    
    for x = 1:pieces
        [data(1,x)] = pipe(pipe_spec,input,data,x,m);
    end
   
end

%%
plot_data(data,nr_pipes,0.2,Dt,pipe_spec)


%data = simulation(Q_init,C_init)

% for m = 1:iterations
 %[pipe1] = pipe(setup(1),pipe1,m);
%  [pipe1] = pipe(pipe2.pipe_spec,pipe2.pipe_sim,pipe2.pipe_in,pipe2.pipe1,m);
% [Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
% end
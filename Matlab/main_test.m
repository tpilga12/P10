%% Sewer pipe equations
clc
clear all
% close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



iterations = 150;
Dt = 20;
%%%%%%%%%%%%%%%%%% sim setup %%%%%%%%%%%%%%
pipe_spec.Ib = 0.00214;
pipe_spec.d = 0.6; %[m] Diameter
pipe_spec.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
pipe_sim.Theta = 0.65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipe_sim.Dt = Dt; %[s] grid time
    pipe_sim.Dx = 8; %[m] grid distance
    pipe_sim.sections=40; % Number of sections,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pipe_sim.iterations = iterations; % temp should be able to be removed at some point
pipe_in.C_init = 8; % initial concentrate in pipe
pipe_in.C_in= 10; % concentrate input
pipe_in.Q_in = 0.015;
pipe_in.Q_init = 0.015;
pipe1 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% sim setup %%%%%%%%%%%%%%
pipe2.pipe_spec.Ib = 0.00214;
pipe2.pipe_spec.d = 0.6; %[m] Diameter
pipe2.pipe_spec.k=0.0015; %sandruhed angives typisk i mm der skal bruges m i formler
pipe2.pipe_sim.Theta = 0.65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pipe2.pipe_sim.Dt = Dt; %[s] grid time
    pipe2.pipe_sim.Dx = 8; %[m] grid distance
    pipe2.pipe_sim.sections=40; % Number of sections,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pipe2.pipe_sim.iterations = iterations; % temp should be able to be removed at some point
pipe2.pipe_in.C_init = 8; % initial concentrate in pipe
pipe2.pipe_in.C_in= 10; % concentrate input
pipe2.pipe_in.Q_in = 0.015;
pipe2.pipe_in.Q_init = 0.015;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for m = 1:iterations
 [pipe1] = pipe(pipe_spec,pipe_sim,pipe_in,pipe1,m);
%  [pipe1] = pipe(pipe2.pipe_spec,pipe2.pipe_sim,pipe2.pipe_in,pipe2.pipe1,m);
% [Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
end
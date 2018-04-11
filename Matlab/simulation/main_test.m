%% Sewer pipe equations
clc
clear all
global Dt iterations Q_init C_init
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
iterations = 150;
Dt = 20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C_init = 8; % initial concentrate in pipe

Q_init = 0.015;


data = simulation(Q_init,C_init)

% for m = 1:iterations
 %[pipe1] = pipe(setup(1),pipe1,m);
%  [pipe1] = pipe(pipe2.pipe_spec,pipe2.pipe_sim,pipe2.pipe_in,pipe2.pipe1,m);
% [Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
% end
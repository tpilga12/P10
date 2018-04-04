%% Sewer pipe equations
clc
clear all
close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Theta = 0.65;
k=0.0015; %angives typisk i mm der skal bruges m i formler

Dt = 20; %[s] grid time
Dx = 8; %[m] grid distance
d = 0.6; %[m] Diameter

sections=40; % Number of sections,
iterations = 150;
% Friction part 
pipe_length = sections*Dx % has to be multiple of Dx

Ib = 0.00214;
C_in= 10; % concentrate input
C_init = 8; % initial concentrate in pipe
Q_in = 0.015;
Q_init = 0.015;
for m = 1:iterations
[Q1 C1 A1 h1] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q_in,C_init,C_in,Theta,iterations);
[Q2 C2 A2 h2] = pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q1(m,end),C_init,C1(m,end),Theta,iterations);
end
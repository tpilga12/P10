%% MPC controller
clc,clear all

% MPCobj = mpc(lin_sys,20);
% T = 20;
% r = [0; 0.03];

A =2;
Hp = 10;
for n = 1:Hp
    Agrafical(n) = [A^n];
    Agrafical =  Agrafical';
    
  
    
    
end
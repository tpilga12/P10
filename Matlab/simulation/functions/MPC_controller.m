%% MPC controller

MPCobj = mpc(lin_sys,20);
T = 20;
r = [0; 0.03];
sim(MPCobj,T,r)

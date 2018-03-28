%File results.m
%Result file for SEWSYS
%This file runs when the user pushes the button Results in SEWSYS' Main window
%Stefan Ahlman
%2000-02-23

trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

%------------------------------------------------
%Heavy metals
Cu_stack=[sum(sewer(:,12)) sum(storm(:,12))
]*trans;

Zn_stack=[sum(sewer(:,13)) sum(storm(:,13))
]*trans;

Pb_stack=[sum(sewer(:,14)) sum(storm(:,14))
]*trans;

Cd_stack=[sum(sewer(:,15)) sum(storm(:,15))
]*trans;

P_stack=[sum(sewer(:,2)) sum(storm(:,2))
]*trans;

N_stack=[sum(sewer(:,3)) sum(storm(:,3))
]*trans;

hm_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;P_stack;N_stack];

bypass=[sum(storm_exceed(:,12)) sum(storm_exceed(:,13)) sum(storm_exceed(:,14)) sum(storm_exceed(:,15)) sum(storm_exceed(:,2)) sum(storm_exceed(:,3))]'*trans;

pass=[sum(storm2(:,12)) sum(storm2(:,13)) sum(storm2(:,14)) sum(storm2(:,15)) sum(storm2(:,2)) sum(storm2(:,3))]'*trans;


[hm_stack(:,2) pass bypass]
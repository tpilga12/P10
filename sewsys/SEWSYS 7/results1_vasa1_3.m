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
%Substances
Cu_stack=[sum(sewer2(:,12)) sum(storm22(:,12))
]*trans;

Zn_stack=[sum(sewer2(:,13)) sum(storm22(:,13))
]*trans;

Pb_stack=[sum(sewer2(:,14)) sum(storm22(:,14))
]*trans;

Cd_stack=[sum(sewer2(:,15)) sum(storm22(:,15))
]*trans;

P_stack=[sum(sewer2(:,2)) sum(storm22(:,2))
]*trans;

N_stack=[sum(sewer2(:,3)) sum(storm22(:,3))
]*trans;

PAH_stack=[sum(sewer2(:,21)) sum(storm22(:,21))
]*trans;

sub_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;P_stack;N_stack;PAH_stack];

bypass=[sum(storm_exceed(:,12)) sum(storm_exceed(:,13)) sum(storm_exceed(:,14)) sum(storm_exceed(:,15)) sum(storm_exceed(:,2)) sum(storm_exceed(:,3)) sum(storm_exceed(:,21))]'*trans;

pass=[sum(storm2(:,12)) sum(storm2(:,13)) sum(storm2(:,14)) sum(storm2(:,15)) sum(storm2(:,2)) sum(storm2(:,3)) sum(storm2(:,21))]'*trans;

%[hm_stack(:,2) pass bypass]
disp('sani')
sub_stack(:,1)
disp('storm')
sub_stack(:,2)
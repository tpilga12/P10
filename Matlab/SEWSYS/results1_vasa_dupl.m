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

PAH_stack=[sum(sewer(:,21)) sum(storm(:,21))
]*trans;

BOD_stack=[sum(sewer(:,8)) sum(storm(:,8))
]*trans;

water_stack=[sum(sewer(:,1)) sum(storm(:,1))
]*trans*1000;

sub_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;P_stack;N_stack;PAH_stack;BOD_stack;water_stack];

%bypass=[sum(storm_exceed(:,12)) sum(storm_exceed(:,13)) sum(storm_exceed(:,14)) sum(storm_exceed(:,15)) sum(storm_exceed(:,2)) sum(storm_exceed(:,3)) sum(storm_exceed(:,21))]'*trans;

%pass=[sum(storm2(:,12)) sum(storm2(:,13)) sum(storm2(:,14)) sum(storm2(:,15)) sum(storm2(:,2)) sum(storm2(:,3)) sum(storm2(:,21))]'*trans;

results_vasa_dupl_sources=[sub_stack(:,1) sub_stack(:,2)];
open results_vasa_dupl_sources
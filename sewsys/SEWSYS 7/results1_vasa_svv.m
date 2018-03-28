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
Cu_stack=[sum(sum(blackw(:,12))+sum(blackw2(:,12))) sum(sum(sewer(:,12))+sum(sewer2(:,12))) sum(sum(storm(:,12))+sum(storm22(:,12)))
]*trans;

Zn_stack=[sum(sum(blackw(:,13))+sum(blackw2(:,13))) sum(sum(sewer(:,13))+sum(sewer2(:,13))) sum(sum(storm(:,13))+sum(storm22(:,13)))
]*trans;

Pb_stack=[sum(sum(blackw(:,14))+sum(blackw2(:,14))) sum(sum(sewer(:,14))+sum(sewer2(:,14))) sum(sum(storm(:,14))+sum(storm22(:,14)))
]*trans;

Cd_stack=[sum(sum(blackw(:,15))+sum(blackw2(:,15))) sum(sum(sewer(:,15))+sum(sewer2(:,15))) sum(sum(storm(:,15))+sum(storm22(:,15)))
]*trans;

P_stack=[sum(sum(blackw(:,2))+sum(blackw2(:,2))) sum(sum(sewer(:,2))+sum(sewer2(:,2))) sum(sum(storm(:,2))+sum(storm22(:,2)))
]*trans;

N_stack=[sum(sum(blackw(:,3))+sum(blackw2(:,3))) sum(sum(sewer(:,3))+sum(sewer2(:,3))) sum(sum(storm(:,3))+sum(storm22(:,3)))
]*trans;

PAH_stack=[sum(sum(blackw(:,21))+sum(blackw2(:,21))) sum(sum(sewer(:,21))+sum(sewer2(:,21))) sum(sum(storm(:,21))+sum(storm22(:,21)))
]*trans;

BOD_stack=[sum(sum(blackw(:,8))+sum(blackw2(:,8))) sum(sum(sewer(:,8))+sum(sewer2(:,8))) sum(sum(storm(:,8))+sum(storm22(:,8)))
]*trans;

water_stack=[sum(sum(blackw(:,1))+sum(blackw2(:,1))) sum(sum(sewer(:,1))+sum(sewer2(:,1))) sum(sum(storm(:,1))+sum(storm22(:,1)))
]*trans*1000;


sub_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;P_stack;N_stack;PAH_stack;BOD_stack;water_stack];

divert=[sum(outCSO(:,12)) sum(outCSO(:,13)) sum(outCSO(:,14)) sum(outCSO(:,15)) sum(outCSO(:,2)) sum(outCSO(:,3)) sum(outCSO(:,21)) sum(outCSO(:,8)) sum(outCSO(:,1))*1000]'*trans;

pass=[sum(storm2(:,12)) sum(storm2(:,13)) sum(storm2(:,14)) sum(storm2(:,15)) sum(storm2(:,2)) sum(storm2(:,3)) sum(storm2(:,21)) sum(storm2(:,8)) sum(storm2(:,1))*1000]'*trans;


%[sub_stack pass bypass]
disp('blackwater')
sub_stack(:,1)
disp('greywater')
sub_stack(:,2)
disp('stormwater')
sub_stack(:,3)
disp('divert')
divert
disp('pass')
pass

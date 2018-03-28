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
Cu_stack=[sum(sum(sewer(:,12))+sum(sewer2(:,12))) sum(sum(storm(:,12))+sum(storm22r(:,12))+sum(outSoil(:,12)))
]*trans;

Zn_stack=[sum(sum(sewer(:,13))+sum(sewer2(:,13))) sum(sum(storm(:,13))+sum(storm22r(:,13))+sum(outSoil(:,13)))
]*trans;

Pb_stack=[sum(sum(sewer(:,14))+sum(sewer2(:,14))) sum(sum(storm(:,14))+sum(storm22r(:,14))+sum(outSoil(:,14)))
]*trans;

Cd_stack=[sum(sum(sewer(:,15))+sum(sewer2(:,15))) sum(sum(storm(:,15))+sum(storm22r(:,15))+sum(outSoil(:,15)))
]*trans;

P_stack=[sum(sum(sewer(:,2))+sum(sewer2(:,2))) sum(sum(storm(:,2))+sum(storm22r(:,2))+sum(outSoil(:,2)))
]*trans;

N_stack=[sum(sum(sewer(:,3))+sum(sewer2(:,3))) sum(sum(storm(:,3))+sum(storm22r(:,3))+sum(outSoil(:,3)))
]*trans;

PAH_stack=[sum(sum(sewer(:,21))+sum(sewer2(:,21))) sum(sum(storm(:,21))+sum(storm22r(:,21))+sum(outSoil(:,21)))
]*trans;

BOD_stack=[sum(sum(sewer(:,8))+sum(sewer2(:,8))) sum(sum(storm(:,8))+sum(storm22r(:,8))+sum(outSoil(:,8)))
]*trans;

water_stack=[sum(sum(sewer(:,1))+sum(sewer2(:,1))) sum(sum(storm(:,1))+sum(storm22r(:,1))+sum(outSoil(:,1)))
]*trans*1000;


sub_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;P_stack;N_stack;PAH_stack;BOD_stack;water_stack];


%[sub_stack pass bypass]
disp('sani')
sub_stack(:,1)
disp('stormwater')
sub_stack(:,2)

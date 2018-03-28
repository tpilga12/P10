%Stefan Ahlman
%2004-10-04
%loads the simulation results from Simulink into MATLAB Workspace (MAT-files are
%stored in sub-directory \results
%write loadresults at MATLAB prompt

load results\storm1
%load results\storm
%load results\s_wetdep
%load results\s_road
%load results\s_roof
%load results\s_other

%load results\sewer
%load results\storm2
%load results\storm_exceed
%load results\settled
%load results\non_settled

%global storm %s_wetdep
storm1=storm1(2:22,:)';
%storm=storm(2:22,:)';
%s_wetdep=s_wetdep(2:22,:)';
%s_road=s_road(2:21,:)';
%s_roof=s_roof(2:21,:)';
%s_other=s_other(2:21,:)';

%sewer=sewer(2:22,:)';
%storm2=storm2(2:22,:)';
%storm_exceed=storm_exceed(2:22,:)';
%settled=settled(2:22,:)';
%non_settled=non_settled(2:22,:)';
%Startfile for SEWSYS
%file sewsys.m
%Stefan Ahlman
%2000-01-17

clear all
close all

global sani stormw CSO_choice rain other_rain K cal_rain T cal sec_per_ts storm in_K com simrun T U2 in_yearly_rain outRecipient inSewageplant
%global inSewageplant
warning off MATLAB:divideByZero
rain1_1d_3600s %load default rain
com=1; %start value choice parameter: Combined system
simrun=0; %start value: No simulation made, changes when Simulate button is pushed 
sani=1; %start value choice parameter: Sanitary Wastewater
stormw=1; %start value choice parameter: Storm Water
CSO_choice=1; %start value choice parameter: Overflow
other_rain=0; %start value choice parameter: Other Rain
K=0; %start value Reservoir parameter
in_K=0; %start value
cal_rain=0; %-"-
cal=0; %-"-
sec_per_ts=0;
open_system('SEWSYS_library')
SEWSYS_fig %bring up SEWSYS Main Window
bar(rain, 1, 'r')                                                                                                                                                                                                                                                                      
ylabel('\mum/s')
HH = findobj(gcf,'Tag','Sec_per_ts');
set(HH, 'String', 3600);
HH = findobj(gcf,'Tag','timesteps');
set(HH, 'String', 24);

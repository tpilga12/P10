%File runoff_cal.m 
%This files creates the type rain and sets time parameters for the calibration process
%Stefan Ahlman
%2000-02-23

in_T=in_Trd+in_Ta;
rainint=in_rainint;
cal_rain=[ones(1,in_Trd)*rainint zeros(1,in_Ta)]';
U1=[zeros(in_T,1)];
T=[0:in_T-1]';



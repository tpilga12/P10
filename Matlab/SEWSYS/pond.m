%n=1; %turbulence/short-circuiting constant, n=1 poor performance (variable inflow)
%Ap=10000; %pond area [m2]
%d=1; %average pond depth [m]
%------------------------------------------------
%Settling velocity vs (Stoke's law)
%roP=1400; %particle density [kg/m3]
%roW=1000; %water density [kg/m3]
%ps=30E-6; %particle size [m]
%dv=0.00131; %dynamic viscosity [kg/ms]

%vs=g/18*(roP-roW)*ps^2/dv; %average settling velocity [m/s] (0.54 m/h)
%------------------------------------------------

%q_threshold=0.02; % [m3/s] inflow larger than q_threshold gives dynamic settling

%for the library block Wet pond this variable is hidden in the
%initialization command
%partboundSS=[ ;% uncertain values, calculated from measurements (Pettersson et al, 1999 p.870)
%   0.57      ;% P-tot              
%   0.10      ;% Tot-N              
%   0         ;% NH3/NH4-N          
%   0         ;% NO3-N
%   0         ;% N2O-N
%   0         ;% SS
%   0.57      ;% BOD
%   0         ;% COD
%   0         ;% C-tot
%   0         ;% Phase index
%   0.43      ;% Cu 
%   0.43      ;% Zn 
%   0.71      ;% Pb
%   0.16      ;% Cd
%   0         ;% Hg 
%   0         ;% Cr
%   0.90	    ;% Pt assumed values
%   0.90	    ;% Pd ---"---
%   0.90		 ;% Rh ---"---
%   0.85      ;% PAH
%   ]'; 


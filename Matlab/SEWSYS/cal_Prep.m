%File cal_prep.m
%This file is used in the calibration of runoff, instead of prep.m 
%Stefan Ahlman
%1999-12-17

%-----------------------------------------------------------------------------
%MAJOR CONSTANTS
numberOfPersons=in_numberOfPersons;
g=9.81; %gravity constant
totnr=21; %total number of vector elements
global nr_ex_H2O;
nr_ex_H2O=totnr-1; %number of pollutants
Separation=[1,1,4,1,1,1,1,1,6,3,1]; %Separation in the Mux and Demux-element (Sewage Plant/Separation) 
NewVSofSS=[10,1,10]; %Special separation in the biological stage (Sewage Plant)


sec_per_ts=in_sec_per_ts;
sph=3600/sec_per_ts; %samples per hour

%-----------------------------------------------------------------------------
%PARAMETERS FOR RAIN DATA:

%Rain/yr in area:(mm)
yearly_rain=in_yearly_rain;

%rain data given in um/s, models mm/timestep
U2=cal_rain/1000*sec_per_ts;

%load area-specific constants
areas

%load pollution constants
constants

%load runoff constants
runoff

%-----------------------------------------------------------------------------
%load pollution vectors
pollutants

%-----------------------------------------------------------------------------------   
%load CSO
CSO_limit=in_CSO_limit;

%-----------------------------------------------------------------------------------   
%load sewageplant
sewageplant

%------------------------------------------------------------------------------
%load pond
pond

%------------------------------------------------------------------------------

%Set the number of timesteps to run
Q=size(T,1)-1;

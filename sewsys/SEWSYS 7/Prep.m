%File prep.m 
%Preparation file, runs when "Simulate" button is pushed
%Stefan Ahlman
%2000-02-23

%-----------------------------------------------------------------------------
%MAJOR CONSTANTS
numberOfPersons=in_numberOfPersons;
g=9.81; %gravity constant
totnr=21; %total number of vector elements
global nr_ex_H2O;sec_per_ts;
nr_ex_H2O=totnr-1; %number of pollutants
Separation=[1,1,4,1,1,1,1,1,6,3,1]; %Separation in the Mux and Demux-element (Sewage Plant/Separation) 
NewVSofSS=[10,1,10]; %Special separation in the biological stage (Sewage Plant)

if in_days==0
   T=[0:in_T-1]';
else
   T=[0:in_days*86400/in_sec_per_ts-1]';
end
sec_per_ts=in_sec_per_ts;
sph=3600/sec_per_ts; %samples per hour
%-----------------------------------------------------------------------------

%load time variation of sewer
time_var

%process rain data
raininfo

%load area-specific constants
areas

%load pollution constants
constants

%load runoff constants
runoff

%load pollution vectors
pollutants

%load CSO input
CSO_limit=in_CSO_limit;

%load sewageplant inputs
sewageplant

%load pond
pond
%------------------------------------------------------------------------------

Q=size(T,1)-1; %number of timestep to run, for use in the Simulink model

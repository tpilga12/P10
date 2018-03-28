%File areas.m
%Definition of catchment for Simulink stormwater modelling
%this file is a modified version from Engvall's model
%loaded from file: prep.m
%Stefan Ahlman
%2000-02-23


%All areas in square metres

%-------%-------%

%TOTAL AREA

%total impervious area:
tota=in_tota;

%-------%

%ROADS

%area of roads
roada=in_roads;

%area of zinc covered surfaces by roads
roadZna=in_part_roadZna/100*roada; 

%number of vehicles per day*
%number of kilometres travelled per vehicle in area:
fkmday=in_fkmday;

%number of heavy vehicles/all vehicles:
nhv=in_nhv/100;

%-------%

%ROOFS

% total roof area 
roofa=in_roofs;

%area of zink roofs: Zink on buildings, painted zink surfaces, 
RoofZna=in_part_roofZna/100*roofa/cos(15*pi/180); %15 graders taklutning

%area of copper roofs:
RoofCua=in_part_roofCua/100*roofa/cos(15*pi/180); %15 graders taklutning

%-------%

%impervious areas that are not covered in other processes.
othera=in_otherarea;

%-------%-------%

%initial loss [mm], for use in subfunction "initial loss" and S-function "initloss"  
init=0.6; %SEWSYS DEFAULT
init_init=4*3600; %SEWSYS DEFAULT 4 hours (14400s) of dry-period before initial loss should be withdrawn
init_time=5; %number of time steps for which initial loss should be withdrawn at the beginning of simulation

%Reduction factor
redu=0.8; %SEWSYS DEFAULT
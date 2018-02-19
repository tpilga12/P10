
%File constants.m
%Constants regarding pollutant loads for Simulink stormwater modelling
%loaded from file: prep.m
%Stefan Ahlman
%Modified 2005-09-12


%1 P
%2 N
%6 SS
%7 BOD
%8 COD
%11 Cu
%12 Zn
%13 Pb
%14 Cd
%15 Hg
%16 Cr
%17 Pt
%18 Pd
%19 Rh
%20 PAH


%----------------------------------------------------------------%
%dry period before simulation
dryper=4; %[days] default 4 days

%DEPOSITION (ug/m2*year) (metaller.txt)

%Total deposition:
%  Cd 150
%	Zn 15000
%	Cu 4000
%	Pb 10000
%	P  7500  Areskoug
%  N 0.5-2.9 g/m2*yr  PAM s. 282, choose 1 g/m2*yr, Areskoug

%Wet deposition:
wetdep(1)=7500; %7500
wetdep(2)=1000000; %1 g/m2*yr
wetdep(11)=1500;
wetdep(12)=8000;
wetdep(13)=1500;
wetdep(14)=150; %default 50
%wetdep(20)=2500; %New 2001-02-12, estimated for Stockholm (VBB Viak, 1997) Total deposition
%wetdep(20)=300; %New 2002-08-02, estimated, Paris values
wetdep(20)=100; %New 2002-12-17, adjusted for Vasastaden

%Dry deposition
drydep(1)=8000; %birds' droppings
drydep(2)=66667;%----"-----------
drydep(7)=10E6; %estimated from EMC 15 mg/l , gives EMC 8.5 mg/l (load 10 g/m2*yr)
drydep(11)=2500;
drydep(12)=7000;
drydep(13)=8500;
drydep(14)=150; %default 100
drydep(20)=0;

%maximum level=level at start of simulation=4*daily deposition (ug)
drydepmax=dryper*drydep/365;

%--------%

%CORROSION

%Zink surfaces: (g/m2*yr) (Hammarby Sjöstad)
Znroofp(12)=4; %default 4
Znroofp(13)=5*300e-6;
Znroofp(14)=9*10e-6; %(10-500)
Znroofp(20)=0;

%maximum level=level at start of simulation=4'dailiy deposition (ug)
Znroofmax=dryper*1e6*Znroofp/365;

%Copper surfaces:
Curoofp(11)=2.6; %default 2.6
Curoofp(20)=0;

%maximum level=level at start of simulation=4*daily deposition (ug)
Curoofmax=dryper*1e6*Curoofp/365;

%share of corroded material that runs of with rainfall
roadrunpart=1;
roofrunpart=0.5;

%--------%

%ROOFS

%Maximum level= level at start of simulation
roofmax=(Znroofmax*RoofZna+Curoofmax*RoofCua)*roofrunpart+drydepmax*roofa;

%--------%

%OTHER AREAS

othermax=drydepmax*othera;

%------%

%ROADS

%levels of pollutants in tyres (ppm) (Hammarby Sjöstad pp.24&29) (Cd: Lohm et al s.45)
%tyrep(1)=1204; %value from Jan Butz 1204 mg P/kg
%tyrep(8)=1100; %value from Jan Butz 1100 mg COD/kg
tyrep(11)=250;
tyrep(12)=15000;
tyrep(14)=5;
tyrep(20)=300*0.2; %lower values from (Hammarby Sjöstad pp.25)

%tyre material from vehicles in Sweden (tons/year)
tyrewear=9000; %9000 ton/year according to Swedish Road Administration (2004)

%levels of pollutants in road material (ppm) (Hammarby Sjöstad)
roadp(11)=28;
roadp(12)=63;
roadp(13)=18;
roadp(14)=0.16;
roadp(20)=100*0.05; %lower values from (Hammarby Sjöstad pp.25)

%road material lost in Sweden (tons/year)
roadwear=130000; %130000 ton/year according to Swedish Road Administration (2004)

%phosphorous in exhaust that is partculate and falls to the ground
%ug per kilometer travelled
exhp(1)=600; %from Malmqvist (1983) p.289
exhp(20)=0;

%pollution from brake wear , ug per kilometer travelled (Koppar i
%    samhälle och miljö p.99)
brakep(11)=1500;
brakep(12)=650;
brakep(20)=0;

%pollution from oil discharge, ug per kilometer travelled (Hammarby Sjöstad p.27)
oilp(1)=0;  %0
oilp(11)=0.039; %0.039
oilp(12)=13.78; %13.78
oilp(13)=0.117; %0.117
oilp(14)=0.0013; %0.0013
oilp(20)=0; %0


%pollution from catalysts, ug per kilometer travelled (Palacios et al p.9)
catalystp(17)=0.101;
catalystp(18)=0.264;
catalystp(19)=0.066;
catalystp(20)=0;

%other constants
roadkm=63e9; %total traffic load in Sweden [vehicle km/year], 43.5e9 ton/year according to Swedish Road Administration (2004)?
andt=0.15; % part heavy traffic, 0.15 according to Swedish Road Administration (2004), trucks and buses over 3.5 tons
andpt=1/3; % heavy vehicles produces 1/3 of the total tyre wear

%share of pollutants from roads that enters the stormwater system
fast=0.7; %default 0.7

%----------------------------------------------------------------%
%SCENARIOS
%----------------------------------------------------------------%
%These are just examples!

%Scenario #1
%roadp=roadp/2;

%Scenario #2
%tyrep=tyrep/2;
%brakep(11)=0;
%oilp=oilp/2;
%catalystp=zeros(1,20);

%----------------------------------------------------------------%
%----------------------------------------------------------------%

%initial level of accumulated pollutants (roadaccmax)
%4 days to accumulate maximum amount of pollutants (Overton & Meadows, 1976 p. 306)

p_tyrewear=(tyrewear*1000*andpt/andt/roadkm*nhv+tyrewear*1000*(1-andpt)/roadkm/(1-andt)*(1-nhv))*fkmday/24/sph*tyrep*1000;
p_roadwear=(roadwear*1000*andpt/andt/roadkm*nhv+roadwear*1000*(1-andpt)/roadkm/(1-andt)*(1-nhv))*fkmday/24/sph*roadp*1000;
p_exhaust=fkmday/24/sph*exhp;
p_breakwear=fkmday/24/sph*brakep;
p_drydep=drydep/365/24/sph*roada;
p_corrZn=Znroofp*1000000/365/24/sph*roadrunpart*roadZna;
p_oildischarge=fkmday/24/sph*oilp;
p_catalyst=fkmday/24/sph*catalystp;

roadaccmax=dryper*24*sph*fast*(p_tyrewear+p_roadwear+p_exhaust+p_breakwear+p_drydep+p_corrZn+p_oildischarge+p_catalyst);

%--------%

%ACCUMULATION AND WASHOFF

global ka kw;

%Ackumulation constant: A higher value gives slower accumulation
ka=0.0002*sec_per_ts/60; %ka=0.0002 is valid for time step =1 min, *900/60=15 when time step is 15 min

% kw is the washoff constant, a higher value gives quicker washoff
kw=0.036*sec_per_ts/60; 
%kw=0.036 is valid for time step =1 min, *900/60=15 when time step is 15 min

delayinit=[zeros(1,nr_ex_H2O)];

%Parameters to control storage of data in Simulink simulations
lim_off=1; %no storage in ToWorkspace blocks
lim_on=inf; %storage in ToWorkspace blocks (all time steps). Fills up the Workspace (internal memory). Not a good choice for long simulations.

%Sources
store1_yes=1; %stores data from sources into ToFile blocks. Stores binary files (*.mat) in subfolder Results. Can be loaded into Workspace with file loadresults.m.
sizeT=size(T); 
store1_no=sizeT(1); %no data storage in ToFile blocks

%Sinks
store2_yes=1; %stores data from sinks into ToFile blocks.
store2_no=sizeT(1);

%File areas.m
%Definition of catchment for Simulink stormwater modelling
%this file is a modified version from Engvall's model
%loaded from file: prep.m
%Stefan Ahlman
%2000-02-23


%All areas in square metres

%-------%-------%
%INPUTS
%Number of persons
%HH = findobj(gcf,'Tag','persons');                                                                                                                                                                                           
%in_numberOfPersons2=str2num(get(HH, 'String'));
numberOfPersons2=2643;

K2=0.05; %roofs + other
K2r=0.04; %roads
baseflow2=0;
%TOTAL AREA

%total impervious area:
tota2=161767;

%-------%

%ROADS

%area of roads
roada2=61611;

%area of zinc covered surfaces by roads
roadZna2=2/100*roada2; 

%number of vehicles per day*
%number of kilometres travelled per vehicle in area:
fkmday2=13150;

%number of heavy vehicles/all vehicles:
nhv2=5/100;

%-------%

%ROOFS

% total roof area 
roofa2=58096;

%area of zink roofs: Zink on buildings, painted zink surfaces, 
RoofZna2=4.916/100*roofa2/cos(15*pi/180); %15 graders taklutning

%area of copper roofs:
RoofCua2=8.369/100*roofa2/cos(15*pi/180); %15 graders taklutning

%-------%

%impervious areas that are not covered in other processes.
othera2=42060;
%----------------------------------------------------------------%

%ROOFS

%Maximum level= level at start of simulation
roofmax2=(Znroofmax*RoofZna2+Curoofmax*RoofCua2)*roofrunpart+drydepmax*roofa2;

%--------%

%OTHER AREAS

othermax2=drydepmax*othera2;


%----------------------------------------------------------------%

%initial level of accumulated pollutants (roadaccmax)
%Should be lowered if it is less than 4 days since the last rain
%4 days to accumulate maximum amount of pollutants (Overton & Meadows, 1976 p. 306)

p_tyrewear2=(tyrewear*1000*andpt/andt/roadkm*nhv+tyrewear*1000*(1-andpt)/roadkm/(1-andt)*(1-nhv2))*fkmday2/24/sph*tyrep*1000;
p_roadwear2=(roadwear*1000*andpt/andt/roadkm*nhv+roadwear*1000*(1-andpt)/roadkm/(1-andt)*(1-nhv2))*fkmday2/24/sph*roadp*1000;
p_exhaust2=fkmday2/24/sph*exhp;
p_breakwear2=fkmday2/24/sph*brakep;
p_drydep2=drydep/365/24/sph*roada2;
p_corrZn2=Znroofp*1000000/365/24/sph*roadrunpart*roadZna2;
p_oildischarge2=fkmday2/24/sph*oilp;
p_catalyst2=fkmday2/24/sph*catalystp;

roadaccmax2=dryper*24*sph*fast*(p_tyrewear2+p_roadwear2+p_exhaust2+p_breakwear2+p_drydep2+p_corrZn2+p_oildischarge2+p_catalyst2);

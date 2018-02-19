%File sewageplant.m
%load sewageplant input
%this file is loaded from prep.m
%Stefan Ahlman
%2000-02-23

%SEWAGE PLANT

%Factor transforming SS to Water (the reduction stages)
SStoWater=1E6; %(E6 m3/s - g/s)
KgperDay_GperSecond=1000/3600/24; %( factor transforming kg/d - g/s)

spVSofSS=0.7;
BODofVS=0.4;
spDenSS=0.25; % part of oxidated VS in SS
spPout=0.38; %g/m3 P in outflow (0.17 old ORWARE), 0.38 for Rya WWTP
spPout1 = 0; % ORWARE 0.71

spHjust=1; %adjustment factor for heavy metals
%Heavy metals separation in pre-sed, bio and chem stages from ORWARE (Rennerfelt 1992)
spHeavym=[0.41 0.525 0.5 ;% Cu 0.41 0.525 0.679
   0.54 0.152 0.55 ;% Zn 0.54 0.152 0.359
   0.4 0.3 0 ;% Pb 0.4 0.4 0.5
   0.44 0.263 0.111 ;% Cd 0.44 0.263 0.111 
   0.44 0.263 0.111 ;% Hg 0.44 0.263 0.111 
   0.43 0.509 0.429 ;% Cr 0.43 0.509 0.429
];


%Pretreatment
SSred_screen=0.017; %Uppsala
ProcSS_screen=0.185*0.85; %Uppsala, 0.185
VSofSS_screen=0.60; %From measurements of VS in Screensludge, Uppsala 1993

SSred_sand=0.0032; %Uppsala
ProcSS_sand=0.42*0.70; %Uppsala
VSofSS_sand=0.26;

%Presedimentation
SSred_presed=0.75;
ProcSS_presed=0.025;


%Biological treatment

spCODBOD=2.51; % Ratio between COD and BOD (=2.51 in Rennerfelt 1991)
BOD=0; %In a function: NH3 emissions from aeration to nitrificatio and degration of BOD.

spNpur=1; % run with nitrogen purification =1
spN2ONpurEmitted=0.0003;
spN2OEmitted=0.0005;
spNemitted=0.5; %Part of N-tot to biostage, which will be emitted as N2 (0.677)
spNitrif=1.07; %part of NH4 nitrified to NH3
spBiored=0.95; %reduction of Bioass and Biograd due to postsedimentation
spBiooxidBod=0.5;%  Part of BOD7 assimilated to organic substance  ORWARE

SSred_bio=0.65; % Part of dry substance separated in biological sedimentation
ProcSS_bio=0.01; %Dry matter in the sludge


%N-purification
spCcontent=0.5424; % estimated C-content in VS from adCcontent and Rennerfelt (1991)
spOcontent=0.3575; %  Estimated O-content in VS from adOontent and organic compounds Rennerfelt (1991)

%Chemical treatment
spPBound=0.97*0.5; %Total purification of phosphorus reduction due to earlier sedimentation
SSred_chem=0.4; %Part of dry substance separated in chemical sedimentation (0.75)
ProcSS_chem=0.007; %Dry matter in the sludge


%PIX Chemical
spChemicalPart=[ ;% Columns mg/g
   1000	       ;% H2O                
   0            ;% P-tot              
   0            ;% Tot-N              
   0            ;% NH3/NH4-N          
   0            ;% NO3-N
   0            ;% N2O-N
   0            ;% SS
   0            ;% BOD
   0            ;% COD
   0            ;% C-tot
   0.002            ;% Phase index
   0.0024          ;% Cu                     -  "  -
   0.018           ;% Zn                     -  "  -
   0.0007          ;% Pb                 Environment report (1992)
   0.0001          ;% Cd                     -  "  -
   0.0000004       ;% Hg                     -  "  -
   0.0089          ;% Cr                     -  "  -
   0				;%Pt
   0				;%Pd
   0				;%Rh
   0            ;% PAH
   ]'; 


spChemFe=0.171; %concentration of Fe in precipitationchemical PIX

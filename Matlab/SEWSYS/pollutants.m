%File pollutants.m
%This file defines the different substancies from household sanitary wastewater
%Stefan Ahlman
%1999-12-17
%Prefix (in_) means value taken from SEWSYS Main window (loaded in file: inputs.m)

%H20
BDTCapita=0.15/24/3600; %[m3/ps] 150 l/pd, new prop by Vinnerås et al (2002): 100 l/pd
ToiletsCapita=0.05/24/3600; %[m3/ps] 50 l/pd
HouseholdWater=numberOfPersons*(BDTCapita+ToiletsCapita);
IndustryWater=in_IndustryWater/24/3600; %[m3/s]
if HouseholdWater==0
    DrainageWater=in_DrainageWaterFactor*IndustryWater;
else
    DrainageWater=in_DrainageWaterFactor*HouseholdWater;
end

%P-tot
P_totBDTCapita=0.52/24/3600; %[g/ps] 0.3 g/pd, Naturvårdsverket 1995 modified 1998, new prop by Vinnerås et al (2002): 0.52 g/pd
P_totUrineCapita=1.0/24/3600; %[g/ps] 1.0 g/pd Naturvårdsverket 1995
P_totFaecesCapita=0.5/24/3600;%[g/ps] 0.5 g/pd Naturvårdsverket 1995
P_totIndustry=in_P_totIndustry*1000/24/3600;%[g/s] 

%N
N_totBDTCapita=1.37/24/3600; %[g/ps] 1.0 g/pd, Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 1.37 g/pd
N_totUrineCapita=11/24/3600; %[g/ps] 11 g/pd Naturvårdsverket 1995
N_totFaecesCapita=1.5/24/3600; %[g/ps] 1,5 g/pd Naturvårdsverket 1995
N_totIndustry=in_N_totIndustry*1000/24/3600; %[g/s]

N_NH3_NH4_BDTCapita=27/365/24/3600; %[[g/ps] 27 g/year?? g/pd, Naturvårdsverket 1995
N_NH3_NH4_UrineCapita=11/24/3600*0.985; %[g/ps] 11 g/d 5%??? is assumed in the fresh urine
N_NH3_NH4_FaecesCapita=310/365/24/3600; %[g/ps] 31 g/year
N_NH3_NH4_Industry=in_N_NH3_NH4_Industry*1000/24/3600;

N_NO3_BDTCapita=3/365/24/3600; %[g/ps] 3g/year?? 
N_NO3_UrineCapita=0;  
N_NO3_FaecesCapita=0;  
N_NO3_Industry=in_N_NO3_Industry*1000/24/3600;

%N2O  
%This substance is only produced in the nitrogen treatment process in the WWTP

%SS
SSBDTCapita=16/24/3600; %[g/ps] 16 g/pd Naturvårdsverket 1995
SSUrineCapita=0;
SSFaecesCapita=(3.6+12.5)*1000/365/24/3600; % [g/ps] 3.6 kg/pyear paper (Svensson 1993), 12.5 kg/pyear faeces (Documenta Geigy 1970)
SSIndustry=in_SSIndustry*1000/24/3600;

%BOD
BODBDTCapita=26/24/3600; % [g/ps] 28 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 26 g/pd
BODUrineCapita=3/24/3600; % [g/ps] 2.68 g/pd ORWARE Understenshöjden
BODFaecesCapita=17/24/3600; % [g/ps] 20 g/pd (Total toilets) Naturvårdsverket 1995 
BODIndustry=in_BODIndustry*1000/24/3600; %[g/s]

%COD
CODBDTCapita=52/24/3600; % [g/ps] 52 g/pd Naturvårdsverket 1995
CODUrineCapita=3.5/24/3600; % [g/ps] 3,5 g/pd ORWARE Understenshöjden
CODFaecesCapita=17*2/24/3600; % [g/ps] COD/BOD-ratio=2 
CODIndustry=in_CODIndustry*1000/24/3600; %[g/s]

%C-tot
C_totBDTCapita=9.59*1000/365/24/3600; %[g/ps] 9.59 kg/py, ORWARE
C_totUrineCapita=0.8075*1000/365/24/3600; %[g/ps] 0.8075 kg/py Calculated from ORWARE, 
C_totFaecesCapita=(1.5+6.94)*1000/365/24/3600; %[g/ps] 1.5 kg/py(paper) 6.94 kg/py(faeces)  Svensson 1993
C_totIndustry=in_C_totIndustry*1000/24/3600; %[g/s]

%Cu
CuBDTCapita=0.008/24/3600; %[g/ps] 0.006 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.008 g/pd
CuUrineCapita=0.1*10^-3/24/3600; %[g/ps] 0.1*10^-3 g/pd Naturvårdsverket 1995  
CuFaecesCapita=1.1*10^-3/24/3600; %[g/ps] 1.1*10^-3 g/pd Naturvårdsverket 1995
CuIndustry=in_CuIndustry*1000/24/3600; %[g/s]

%Zn
ZnBDTCapita=0.01/24/3600; %[g/ps] 0.05 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.01 g/pd
ZnUrineCapita=45*10^-6/24/3600; %[g/ps] 45*10^-6 g/pd Naturvårdsverket 1995  
ZnFaecesCapita=10.8*10^-3/24/3600; %[g/ps] 10.8*10^-3 g/pd Naturvårdsverket 1995
ZnIndustry=in_ZnIndustry*1000/24/3600; %[g/s]

%Pb
PbBDTCapita=0.00096/24/3600; %[g/ps] 0.003 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.96 mg/pd
PbUrineCapita=2*10^-6/24/3600; %[g/ps] 2*10^-6 g/pd Naturvårdsverket 1995  
PbFaecesCapita=20*10^-6/24/3600; %[g/ps] 20*10^-6 g/pd Naturvårdsverket 1995
PbIndustry=in_PbIndustry*1000/24/3600; %[g/s]

%Cd
CdBDTCapita=41*10^-6/24/3600; %[g/ps] 0.0006 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 41*10^-6 g/pd 
CdUrineCapita=0.68*10^-6/24/3600; %[g/ps] 1*10^-6 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.68*10^-6 g/pd 
CdFaecesCapita=10*10^-6/24/3600; %[g/ps] 10*10^-6 g/pd Naturvårdsverket 1995
CdIndustry=in_CdIndustry*1000/24/3600; %[g/s]

%Hg
HgBDTCapita=4.11*10^-6/24/3600; %[g/ps] 0.00006 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 4.11*10^-6 g/pd 
HgUrineCapita=0.82*10^-6/24/3600; %[g/ps] 3*10^-6 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.82*10^-6 g/pd  
HgFaecesCapita=9.04*10^-6/24/3600; %[g/ps] 63*10^-6 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 9.04*10^-6 g/pd
HgIndustry=in_HgIndustry*1000/24/3600; %[g/s]

%Cr
CrBDTCapita=0.001/24/3600; %[g/ps] 0.005 g/pd Naturvårdsverket 1995, new prop by Vinnerås et al (2002): 0.001 g/pd 
CrUrineCapita=10*10^-6/24/3600; %[g/ps] 10*10^-6 g/pd Naturvårdsverket 1995  
CrFaecesCapita=20*10^-6/24/3600; %[g/ps] 20*10^-6 g/pd Naturvårdsverket 1995
CrIndustry=in_CrIndustry*1000/24/3600; %[g/s]

%PAH
PAHBDTCapita=7.2*10^-3/365/24/3600; %[g/ps] 0.18 g/pår ORWARE, new value from Palmquist's lic thesis 2001 (Vibyåsen): 7.2*10^-3 g/p,yr
PAHUrineCapita=3.3/2*10^-3/365/24/3600; %[g/ps] new value from Palmquist's lic thesis 2001 (Vibyåsen): 3.3*10^-3 (Blackwater)
PAHFaecesCapita=3.3/2*10^-3/365/24/3600; %[g/ps] new value from Palmquist's lic thesis 2001 (Vibyåsen): 3.3*10^-3 (Blackwater)
PAHIndustry=in_PAHIndustry*1000/24/3600; %[g/s]
%--------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------%
%SCENARIOS
%----------------------------------------------------------------%

%SYSTENANALYS VASASTADEN
%Scenario #2 - källkontroll spillvatten
%CuBDTCapita=CuBDTCapita*0.8*0.9;
%ZnBDTCapita=ZnBDTCapita*0.9;
%PbBDTCapita=PbBDTCapita*0.9;
%CdBDTCapita=CdBDTCapita*0.83*0.9;
%PAHBDTCapita=PAHBDTCapita*0.9;
%----------------------------------------------------------------%

%SOURCES
      
BDT=[
   BDTCapita				%1 H20 [m3/ps]
   P_totBDTCapita			%2 P-tot [g/ps]
   N_totBDTCapita			%3 N-tot [g/ps]
   N_NH3_NH4_BDTCapita 	%4 NH3/NH4-N [g/ps]
   N_NO3_BDTCapita 		%5 NO3-N [g/ps]
   0 							%6 N2O-N [g/ps]
   SSBDTCapita 			%7 SS [g/ps]
   BODBDTCapita 			%8 BOD [g/ps]
   CODBDTCapita 			%9 COD [g/ps]
   C_totBDTCapita 		%10 C-tot [g/ps]
   0 							%11 Phase index
   CuBDTCapita 			%12 Cu [g/ps]
   ZnBDTCapita 			%13 Zn [g/ps]
   PbBDTCapita 			%14 Pb [g/ps]
   CdBDTCapita 			%15 Cd [g/ps]
   HgBDTCapita 			%16 Hg [g/ps]
   CrBDTCapita 			%17 Cr [g/ps]
   0							%18 Pt
   0							%19 Pd
   0							%20 Rh
   PAHBDTCapita			%21 PAH [g/ps]
]';
   
Urine=[
   ToiletsCapita/2	%H20
   P_totUrineCapita	%P-tot
   N_totUrineCapita	%N-tot
   N_NH3_NH4_UrineCapita %NH3/NH4-N
   N_NO3_UrineCapita %NO3-N
   0 %N2O-N
   SSUrineCapita %SS
   BODUrineCapita %BOD
   CODUrineCapita %COD
   C_totUrineCapita %C-tot
   0 %Phase index
   CuUrineCapita %Cu
   ZnUrineCapita %Zn
   PbUrineCapita %Pb
   CdUrineCapita %Cd
   HgUrineCapita %Hg
   CrUrineCapita %Cr
   0 %Pt
   0 %Pd
   0 %Rh
   PAHUrineCapita %PAH
   ]';

   
Faeces=[
   ToiletsCapita/2	%H20
   P_totFaecesCapita	%P-tot
   N_totFaecesCapita	%N-tot
   N_NH3_NH4_FaecesCapita %NH3/NH4-N
   N_NO3_FaecesCapita %NO3-N
   0 %N2O-N
   SSFaecesCapita %SS
   BODFaecesCapita %BOD
   CODFaecesCapita %COD
   C_totFaecesCapita %C-tot
   0 % Phase index
   CuFaecesCapita %Cu
   ZnFaecesCapita %Zn
   PbFaecesCapita %Pb
   CdFaecesCapita %Cd
   HgFaecesCapita %Hg
   CrFaecesCapita %Cr
   0 %Pt
   0 %Pd
   0 %Rh
   PAHFaecesCapita %PAH
   ]';
   
Industry=[
	 IndustryWater	%H20 
    P_totIndustry	%P-tot 
    N_totIndustry	%N-tot 
    N_NH3_NH4_Industry %NH3/NH4-N
    N_NO3_Industry %NO3-N
    0 %N2O-N
    SSIndustry %SS
    BODIndustry %BOD
    CODIndustry %COD
    C_totIndustry %C-tot
    0 %Phase index
    CuIndustry %Cu
    ZnIndustry %Zn
    PbIndustry %Pb
    CdIndustry %Cd
    HgIndustry %Hg
    CrIndustry %Cr
    0 %Pt
    0 %Pd
    0 %Rh
    PAHIndustry %PAH
   ]';
      
Drainage=[
   DrainageWater	%H20 
   0 %P-tot 
   0 %N-tot 
   0 %NH3/NH4-N
   0 %NO3-N
   0 %N2O-N
   0 %SS
   0 %BOD
   0 %COD
   0 %C-tot
   0 %Phase index
   0 %Cu
   0 %Zn
   0 %Pb
   0 %Cd
   0 %Hg
   0 %Cr
   0 %Pt
   0 %Pd
   0 %Rh
   0 %PAH
   ]';
   
   
   
   

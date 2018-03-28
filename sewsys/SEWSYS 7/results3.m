%File results.m
%Result file for SEWSYS
%This file runs when the user pushes the button Results in SEWSYS' Main window
%Stefan Ahlman
%2000-02-23

trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size
totvol=[sum(storm(:,1))]*sec_per_ts;

%------------------------------------------------
disp('-------------------------')
disp('Load from sources/categories [kg]')
disp('1. Total load')
disp('2. Wet deposition')
disp('3. Road surfaces')
disp('4. Roof surfaces')
disp('5. Other surfaces')
%Sources for Copper

cu_sewer=[sum(sewer(:,12))]*trans;
if cu_sewer==0
   cu_urine=0;
   cu_faeces=0;
   cu_bdt=0;
   cu_industry=0;
   cu_sewer_bar=[cu_sewer,cu_urine,cu_faeces,cu_bdt,cu_industry];
else
   cu_urine=s_urine(1,12)*numberOfPersons*in_T*trans;
   cu_faeces=s_faeces(1,12)*numberOfPersons*in_T*trans;
   cu_bdt=s_bdt(1,12)*numberOfPersons*in_T*trans;
   cu_industry=s_industry(1,12)*in_T*trans;
   cu_sewer_sum=cu_urine+cu_faeces+cu_bdt+cu_industry;
   cu_sewer_bar=[cu_sewer,cu_urine,cu_faeces,cu_bdt,cu_industry];
end

cu_storm=[sum(storm(:,12))]*trans;
cu_wetdep=[sum(s_wetdep(:,12))]*tota*trans1*trans2;
cu_road=[sum(s_road(:,11))]*trans1*trans2;
cu_roof=[sum(s_roof(:,11))]*trans1*trans2;
%cu_roof_dp=[sum(s_roof_drydep(:,11))]*trans1*trans2;
%cu_roof_cu=[sum(s_roof_cucorr(:,11))]*trans1*trans2;
cu_other=[sum(s_other(:,11))]*trans1*trans2;
cu_storm_sum=cu_wetdep+cu_road+cu_roof+cu_other;
cu_storm_bar=[cu_storm,cu_wetdep,cu_road,cu_roof, cu_other];

disp('-------------------------')
disp('Cu')
[cu_storm cu_wetdep cu_road cu_roof cu_other]'

cu_EMC=cu_storm/totvol*1E6;
disp('Cu EMC [ug/l]')
[cu_EMC]
%---------------------------------------------------

%Sources for Zinc

zn_sewer=[sum(sewer(:,13))]*trans;
if zn_sewer==0
   zn_urine=0;
   zn_faeces=0;
   zn_bdt=0;
   zn_industry=0;
   zn_sewer_bar=[zn_sewer,zn_urine,zn_faeces,zn_bdt,zn_industry];
else
   zn_urine=s_urine(1,13)*numberOfPersons*in_T*trans;
   zn_faeces=s_faeces(1,13)*numberOfPersons*in_T*trans;
   zn_bdt=s_bdt(1,13)*numberOfPersons*in_T*trans;
   zn_industry=s_industry(1,13)*in_T*trans;
   zn_sewer_sum=zn_urine+zn_faeces+zn_bdt+zn_industry;
   zn_sewer_bar=[zn_sewer,zn_urine,zn_faeces,zn_bdt,zn_industry];
end

zn_storm=[sum(storm(:,13))]*trans;
zn_wetdep=[sum(s_wetdep(:,13))]*tota*trans1*trans2;
zn_road=[sum(s_road(:,12))]*trans1*trans2;
zn_roof=[sum(s_roof(:,12))]*trans1*trans2;
%zn_roof_dp=[sum(s_roof_drydep(:,12))]*trans1*trans2;
%zn_roof_zn=[sum(s_roof_zncorr(:,12))]*trans1*trans2;
zn_other=[sum(s_other(:,12))]*trans1*trans2;
zn_storm_sum=zn_wetdep+zn_road+zn_roof+zn_other;
zn_storm_bar=[zn_storm,zn_wetdep,zn_road,zn_roof, zn_other];

disp('-------------------------')
disp('Zn')
[zn_storm zn_wetdep zn_road zn_roof zn_other]'

zn_EMC=zn_storm/totvol*1E6;
disp('Zn EMC [ug/l]')
[zn_EMC]

%---------------------------------------------------

%Sources for lead

pb_sewer=[sum(sewer(:,14))]*trans;
if pb_sewer==0
   pb_urine=0;
   pb_faeces=0;
   pb_bdt=0;
   pb_industry=0;
   pb_sewer_bar=[pb_sewer,pb_urine,pb_faeces,pb_bdt,pb_industry];
else
   pb_urine=s_urine(1,14)*numberOfPersons*in_T*trans;
   pb_faeces=s_faeces(1,14)*numberOfPersons*in_T*trans;
   pb_bdt=s_bdt(1,14)*numberOfPersons*in_T*trans;
   pb_industry=s_industry(1,14)*in_T*trans;
   pb_sewer_sum=pb_urine+pb_faeces+pb_bdt+pb_industry;
   pb_sewer_bar=[pb_sewer,pb_urine,pb_faeces,pb_bdt,pb_industry];
end

pb_storm=[sum(storm(:,14))]*trans;
pb_wetdep=[sum(s_wetdep(:,14))]*tota*trans1*trans2;
pb_road=[sum(s_road(:,13))]*trans1*trans2;
pb_roof=[sum(s_roof(:,13))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,13))]*trans1*trans2;
pb_other=[sum(s_other(:,13))]*trans1*trans2;
pb_storm_sum=pb_wetdep+pb_road+pb_roof+pb_other;
pb_storm_bar=[pb_storm,pb_wetdep,pb_road,pb_roof, pb_other];

disp('-------------------------')
disp('Pb')
[pb_storm pb_wetdep pb_road pb_roof pb_other]'

pb_EMC=pb_storm/totvol*1E6;
disp('Pb EMC [ug/l]')
[pb_EMC]

%---------------------------------------------------
%Sources for cadmium

cd_sewer=[sum(sewer(:,15))]*trans;
if cd_sewer==0
   cd_urine=0;
   cd_faeces=0;
   cd_bdt=0;
   cd_industry=0;
   cd_sewer_bar=[cd_sewer,cd_urine,cd_faeces,cd_bdt,cd_industry];
else
   cd_urine=s_urine(1,15)*numberOfPersons*in_T*trans;
   cd_faeces=s_faeces(1,15)*numberOfPersons*in_T*trans;
   cd_bdt=s_bdt(1,15)*numberOfPersons*in_T*trans;
   cd_industry=s_industry(1,15)*in_T*trans;
   cd_sewer_sum=cd_urine+cd_faeces+cd_bdt+cd_industry;
   cd_sewer_bar=[cd_sewer,cd_urine,cd_faeces,cd_bdt,cd_industry];
end

cd_storm=[sum(storm(:,15))]*trans;
cd_wetdep=[sum(s_wetdep(:,15))]*tota*trans1*trans2;
cd_road=[sum(s_road(:,14))]*trans1*trans2;
cd_roof=[sum(s_roof(:,14))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,14))]*trans1*trans2;
cd_other=[sum(s_other(:,14))]*trans1*trans2;
cd_storm_sum=cd_wetdep+cd_road+cd_roof+cd_other;
cd_storm_bar=[cd_storm,cd_wetdep,cd_road,cd_roof, cd_other];

disp('-------------------------')
disp('Cd')
[cd_storm cd_wetdep cd_road cd_roof cd_other]'

cd_EMC=cd_storm/totvol*1E6;
disp('Cd EMC [ug/l]')
[cd_EMC]

%---------------------------------------------------
%Sources for nitrogen

n_sewer=[sum(sewer(:,3))]*trans;
if n_sewer==0
   n_urine=0;
   n_faeces=0;
   n_bdt=0;
   n_industry=0;
   n_sewer_bar=[n_sewer,n_urine,n_faeces,n_bdt,n_industry];
else
   n_urine=s_urine(1,3)*numberOfPersons*in_T*trans;
   n_faeces=s_faeces(1,3)*numberOfPersons*in_T*trans;
   n_bdt=s_bdt(1,3)*numberOfPersons*in_T*trans;
   n_industry=s_industry(1,3)*in_T*trans;
   n_sewer_sum=n_urine+n_faeces+n_bdt+n_industry;
   n_sewer_bar=[n_sewer,n_urine,n_faeces,n_bdt,n_industry];
end

n_storm=[sum(storm(:,3))]*trans;
n_wetdep=[sum(s_wetdep(:,3))]*tota*trans1*trans2;
n_road=[sum(s_road(:,2))]*trans1*trans2;
n_roof=[sum(s_roof(:,2))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,2))]*trans1*trans2;
n_other=[sum(s_other(:,2))]*trans1*trans2;
n_storm_sum=n_wetdep+n_road+n_roof+n_other;
n_storm_bar=[n_storm,n_wetdep,n_road,n_roof, n_other];

disp('-------------------------')
disp('Nitrogen')
[n_storm n_wetdep n_road n_roof n_other]'

n_EMC=n_storm/totvol*1E6;
disp('n EMC [ug/l]')
[n_EMC]

%---------------------------------------------------
%Sources for phosphorus

p_sewer=[sum(sewer(:,2))]*trans;
if p_sewer==0
   p_urine=0;
   p_faeces=0;
   p_bdt=0;
   p_industry=0;
   p_sewer_bar=[p_sewer,p_urine,p_faeces,p_bdt,p_industry];
else
   p_urine=s_urine(1,2)*numberOfPersons*in_T*trans;
   p_faeces=s_faeces(1,2)*numberOfPersons*in_T*trans;
   p_bdt=s_bdt(1,2)*numberOfPersons*in_T*trans;
   p_industry=s_industry(1,2)*in_T*trans;
   p_sewer_sum=p_urine+p_faeces+p_bdt+p_industry;
   p_sewer_bar=[p_sewer,p_urine,p_faeces,p_bdt,p_industry];
end

p_storm=[sum(storm(:,2))]*trans;
p_wetdep=[sum(s_wetdep(:,2))]*tota*trans1*trans2;
p_road=[sum(s_road(:,1))]*trans1*trans2;
p_roof=[sum(s_roof(:,1))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,1))]*trans1*trans2;
p_other=[sum(s_other(:,1))]*trans1*trans2;
p_storm_sum=p_wetdep+p_road+p_roof+p_other;
p_storm_bar=[p_storm,p_wetdep,p_road,p_roof, p_other];

disp('-------------------------')
disp('Phosphorus')
[p_storm p_wetdep p_road p_roof p_other]'

p_EMC=p_storm/totvol*1E6;
disp('p EMC [ug/l]')
[p_EMC]

%---------------------------------------------------
%Sources for Platinum

pt_sewer=[sum(sewer(:,18))]*trans;
if pt_sewer==0
   pt_urine=0;
   pt_faeces=0;
   pt_bdt=0;
   pt_industry=0;
   pt_sewer_bar=[pt_sewer,pt_urine,pt_faeces,pt_bdt,pt_industry];
else
   pt_urine=s_urine(1,18)*numberOfPersons*in_T*trans;
   pt_faeces=s_faeces(1,18)*numberOfPersons*in_T*trans;
   pt_bdt=s_bdt(1,18)*numberOfPersons*in_T*trans;
   pt_industry=s_industry(1,18)*in_T*trans;
   pt_sewer_sum=pt_urine+pt_faeces+pt_bdt+pt_industry;
   pt_sewer_bar=[pt_sewer,pt_urine,pt_faeces,pt_bdt,pt_industry];
end

pt_storm=[sum(storm(:,18))]*trans;
pt_wetdep=[sum(s_wetdep(:,18))]*tota*trans1*trans2;
pt_road=[sum(s_road(:,17))]*trans1*trans2;
pt_roof=[sum(s_roof(:,17))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,17))]*trans1*trans2;
pt_other=[sum(s_other(:,17))]*trans1*trans2;
pt_storm_sum=pt_wetdep+pt_road+pt_roof+pt_other;
pt_storm_bar=[pt_storm,pt_wetdep,pt_road,pt_roof, pt_other];

disp('-------------------------')
disp('Platinum')
[pt_storm pt_wetdep pt_road pt_roof pt_other]'

pt_EMC=pt_storm/totvol*1E6;
disp('Platinum EMC [ug/l]')
[pt_EMC]

%---------------------------------------------------
%Sources for Palladium

pd_sewer=[sum(sewer(:,19))]*trans;
if pd_sewer==0
   pd_urine=0;
   pd_faeces=0;
   pd_bdt=0;
   pd_industry=0;
   pd_sewer_bar=[pd_sewer,pd_urine,pd_faeces,pd_bdt,pd_industry];
else
   pd_urine=s_urine(1,19)*numberOfPersons*in_T*trans;
   pd_faeces=s_faeces(1,19)*numberOfPersons*in_T*trans;
   pd_bdt=s_bdt(1,18)*numberOfPersons*in_T*trans;
   pd_industry=s_industry(1,19)*in_T*trans;
   pd_sewer_sum=pt_urine+pd_faeces+pd_bdt+pd_industry;
   pd_sewer_bar=[pd_sewer,pd_urine,pd_faeces,pd_bdt,pd_industry];
end

pd_storm=[sum(storm(:,19))]*trans;
pd_wetdep=[sum(s_wetdep(:,19))]*tota*trans1*trans2;
pd_road=[sum(s_road(:,18))]*trans1*trans2;
pd_roof=[sum(s_roof(:,18))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,18))]*trans1*trans2;
pd_other=[sum(s_other(:,18))]*trans1*trans2;
pd_storm_sum=pd_wetdep+pd_road+pd_roof+pd_other;
pd_storm_bar=[pd_storm,pd_wetdep,pd_road,pd_roof, pd_other];

disp('-------------------------')
disp('Palladium')
[pd_storm pd_wetdep pd_road pd_roof pd_other]'

pd_EMC=pd_storm/totvol*1E6;
disp('Palladium EMC [ug/l]')
[pd_EMC]

%---------------------------------------------------
%Sources for Rhodium

rh_sewer=[sum(sewer(:,20))]*trans;
if rh_sewer==0
   rh_urine=0;
   rh_faeces=0;
   rh_bdt=0;
   rh_industry=0;
   rh_sewer_bar=[rh_sewer,rh_urine,rh_faeces,rh_bdt,rh_industry];
else
   rh_urine=s_urine(1,20)*numberOfPersons*in_T*trans;
   rh_faeces=s_faeces(1,20)*numberOfPersons*in_T*trans;
   rh_bdt=s_bdt(1,20)*numberOfPersons*in_T*trans;
   rh_industry=s_industry(1,20)*in_T*trans;
   rh_sewer_sum=rh_urine+rh_faeces+rh_bdt+rh_industry;
   rh_sewer_bar=[rh_sewer,rh_urine,rh_faeces,rh_bdt,rh_industry];
end

rh_storm=[sum(storm(:,20))]*trans;
rh_wetdep=[sum(s_wetdep(:,20))]*tota*trans1*trans2;
rh_road=[sum(s_road(:,19))]*trans1*trans2;
rh_roof=[sum(s_roof(:,19))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,19))]*trans1*trans2;
rh_other=[sum(s_other(:,19))]*trans1*trans2;
rh_storm_sum=rh_wetdep+rh_road+rh_roof+rh_other;
rh_storm_bar=[rh_storm,rh_wetdep,rh_road,rh_roof, rh_other];

disp('-------------------------')
disp('Rhodium')
[rh_storm rh_wetdep rh_road rh_roof rh_other]'

rh_EMC=rh_storm/totvol*1E6;
disp('Rhodium EMC [ug/l]')
[rh_EMC]

%---------------------------------------------------
%Sources for PAH

PAH_sewer=[sum(sewer(:,21))]*trans;
if PAH_sewer==0
   PAH_urine=0;
   PAH_faeces=0;
   PAH_bdt=0;
   PAH_industry=0;
   PAH_sewer_bar=[PAH_sewer,PAH_urine,PAH_faeces,PAH_bdt,PAH_industry];
else
   PAH_urine=s_urine(1,21)*numberOfPersons*in_T*trans;
   PAH_faeces=s_faeces(1,21)*numberOfPersons*in_T*trans;
   PAH_bdt=s_bdt(1,21)*numberOfPersons*in_T*trans;
   PAH_industry=s_industry(1,21)*in_T*trans;
   PAH_sewer_sum=PAH_urine+PAH_faeces+PAH_bdt+PAH_industry;
   PAH_sewer_bar=[PAH_sewer,PAH_urine,PAH_faeces,PAH_bdt,PAH_industry];
end

PAH_storm=[sum(storm(:,21))]*trans;
PAH_wetdep=[sum(s_wetdep(:,21))]*tota*trans1*trans2;
PAH_road=[sum(s_road(:,20))]*trans1*trans2;
PAH_roof=[sum(s_roof(:,20))]*trans1*trans2;
%p_roof_dp=[sum(s_roof_drydep(:,20))]*trans1*trans2;
PAH_other=[sum(s_other(:,20))]*trans1*trans2;
PAH_storm_sum=PAH_wetdep+PAH_road+PAH_roof+PAH_other;
PAH_storm_bar=[PAH_storm,PAH_wetdep,PAH_road,PAH_roof, PAH_other];

disp('-------------------------')
disp('PAH')
[PAH_storm PAH_wetdep PAH_road PAH_roof PAH_other]'

PAH_EMC=PAH_storm/totvol*1E6;
disp('PAH EMC [ug/l]')
[PAH_EMC]

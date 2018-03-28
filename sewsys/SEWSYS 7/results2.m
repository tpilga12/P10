%File results.m
%Result file for SEWSYS
%This file runs when the user pushes the button Results in SEWSYS' Main window
%Stefan Ahlman
%2000-02-23

trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

%------------------------------------------------
%Heavy metals
Cu_stack=[sum(sewer(:,12)) sum(storm(:,12))
]*trans;

Zn_stack=[sum(sewer(:,13)) sum(storm(:,13))
]*trans;

Pb_stack=[sum(sewer(:,14)) sum(storm(:,14))
]*trans;

Cd_stack=[sum(sewer(:,15)) sum(storm(:,15))
]*trans;

Hg_stack=[sum(sewer(:,16)) sum(storm(:,16))
]*trans;

Cr_stack=[sum(sewer(:,17)) sum(storm(:,17))
]*trans;

hm_stack=[Cu_stack;Zn_stack;Pb_stack;Cd_stack;Hg_stack;Cr_stack];

figure
set(gcf,'position',w_size)

bar(hm_stack,'stack')
colormap([1 0 0;0 1 0])
title('Heavy metals', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Cu, 2-Zn, 3-Pb, 4-Cd, 5-Hg, 6-Cr','FontSize',12)
AX=legend('Sanitary Wastewater','Storm Water');

set(gcf,'numbertitle','off')
set(gcf,'name','Heavy metals')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')

%---------------------------------------------------

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

figure
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
Cu=[cu_sewer, cu_storm];
bar(Cu)
title('Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

SUBPLOT(2,2,2)
bar(cu_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

SUBPLOT(2,2,4)
bar(cu_storm_bar, 'r')
title('Storm Water - Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Copper')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')

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

figure
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
Zn=[zn_sewer, zn_storm];
bar(Zn)
title('Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

SUBPLOT(2,2,2)
bar(zn_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

SUBPLOT(2,2,4)
bar(zn_storm_bar, 'r')
title('Storm Water - Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Zinc')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


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

figure
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
pb_sum=[sum(sewer(:,14)) sum(storm(:,14))]*trans;
bar(pb_sum)
title('Sources for Lead', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

SUBPLOT(2,2,2)
bar(pb_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Lead', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

SUBPLOT(2,2,4)
bar(pb_storm_bar, 'r')
title('Storm Water - Sources for Lead', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Lead')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


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

figure
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
cd_sum=[sum(sewer(:,15)) sum(storm(:,15))]*trans;
bar(cd_sum)
title('Sources for Cadmium', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

SUBPLOT(2,2,2)
bar(cd_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Cadmium', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

SUBPLOT(2,2,4)
bar(cd_storm_bar, 'r')
title('Storm Water - Sources for Cadmium', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Cadmium')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')

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
%p_roof_dp=[sum(s_roof_drydep(:,17))]*trans1*trans2;
PAH_other=[sum(s_other(:,20))]*trans1*trans2;
PAH_storm_sum=PAH_wetdep+PAH_road+PAH_roof+PAH_other;
PAH_storm_bar=[PAH_storm,PAH_wetdep,PAH_road,PAH_roof, PAH_other];

figure
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
PAH_sum=[sum(sewer(:,21)) sum(storm(:,21))]*trans;
bar(PAH_sum)
title('Sources for PAH', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

SUBPLOT(2,2,2)
bar(PAH_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for PAH', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

SUBPLOT(2,2,4)
bar(PAH_storm_bar, 'r')
title('Storm Water - Sources for PAH', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for PAH')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


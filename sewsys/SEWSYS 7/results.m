%File results.m
%Result file for SEWSYS
%This file runs when the user pushes the button Results in SEWSYS' Main window
%Stefan Ahlman
%2000-02-23

trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

%----------------------------------------------------
%Mass balance over treatment plant
pP=trans*[sum(inSewageplant(:,2))
sum(outLandfill(:,2))
sum(outSludge(:,2))
sum(out_WWTP_Recipient(:,2))
];

pN=[sum(inSewageplant(:,3)) sum(outLandfill(:,3)) sum(outSludge(:,3)) sum(out_WWTP_Recipient(:,3)) sum(outAir(:,3))   
]*trans;

pZn=[sum(inSewageplant(:,13))
sum(outLandfill(:,13))
sum(outSludge(:,13))
sum(out_WWTP_Recipient(:,13))
]*trans';

figure
set(gcf,'position',w_size)
subplot(2,2,1)
plot(T,inSewageplant(:,1))
title('Inflow - WWTP', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
xlabel('Timestep', 'fontsize', 12)
xlim([0 size(T,1)-1])

subplot(2,2,2)
bar(pP,'g')
title('Tot-P', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-In WWTP 2-Landfill 3-Sludge 4-Recipient');

subplot(2,2,3)
bar(pN,'r')
title('Tot-N', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-In WWTP 2-Landfill 3-Sludge 4-Recipient 5-Air');

subplot(2,2,4)
bar(pZn,'y')
title('Zn', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-In WWTP 2-Landfill 3-Sludge 4-Recipient');

set(gcf,'numbertitle','off')
set(gcf,'name','Massbalance over WWTP')

%----------------------------------------------------
%Hydrographs
figure
set(gcf,'position',w_size)

subplot(2,1,1)
plot(T,sewer(:,1))
set(gca,'nextplot','add')
plot(T,mean(sewer(:,1))*ones(size(T)),'r')
title('Sanitary Wastewater', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
xlabel('Timestep')
xlim([0 size(T,1)-1])


subplot(2,1,2)
plot(T,storm(:,1))
title('Storm Water', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
xlabel('Timestep')
xlim([0 size(T,1)-1])

set(gcf,'numbertitle','off')
set(gcf,'name','Hydrographs')

%------------------------------------------------

%Heavy Metals
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

%---------------------------------------------------

%CSO
P_stack=[sum(inSewageplant(:,2)) sum(outCSO(:,2))
]*trans;

N_stack=[sum(inSewageplant(:,3)) sum(outCSO(:,3))
]*trans;

Cu_stack=[sum(inSewageplant(:,12)) sum(outCSO(:,12))
]*trans;

Zn_stack=[sum(inSewageplant(:,13)) sum(outCSO(:,13))
]*trans;

CSO_stack1=[P_stack;N_stack];
CSO_stack2=[Cu_stack;Zn_stack];

figure
set(gcf,'position',w_size)

bar(CSO_stack1,'stack')
colormap([1 0 0;0 1 0])
title('Combined Sewer Overflow (1)', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-P, 2-N','FontSize',12)
AX=legend('to WWTP','to recipient');

set(gcf,'numbertitle','off')
set(gcf,'name','Combined Sewer Overflow (1)')

figure
set(gcf,'position',w_size)

bar(CSO_stack2,'stack')
colormap([1 0 0;0 1 0])
title('Combined Sewer Overflow (2)', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Cu, 2-Zn','FontSize',12)
AX=legend('to WWTP','to recipient');

set(gcf,'numbertitle','off')
set(gcf,'name','Combined Sewer Overflow (2)')

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

subplot(2,2,1)
Cu=[cu_sewer, cu_storm];
bar(Cu)
title('Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

subplot(2,2,2)
bar(cu_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

subplot(2,2,4)
bar(cu_storm_bar, 'r')
title('Storm Water - Sources for Copper', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Copper')
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

subplot(2,2,1)
Zn=[zn_sewer, zn_storm];
bar(Zn)
title('Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

subplot(2,2,2)
bar(zn_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

subplot(2,2,4)
bar(zn_storm_bar, 'r')
title('Storm Water - Sources for Zinc', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Zinc')

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

figure
set(gcf,'position',w_size)

subplot(2,2,1)
p_sum=[sum(sewer(:,2)) sum(storm(:,2))]*trans;
bar(p_sum)
title('Sources for Phosphorus', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sanitary Wastewater, 2-Storm Water','fontsize',12)

subplot(2,2,2)
bar(p_sewer_bar, 'g')
title('Sanitary Wastewater - Sources for Phosphorus', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Urine, 3-Faeces, 4-Greywater, 5-Industry','FontSize',12)

subplot(2,2,4)
bar(p_storm_bar, 'r')
title('Storm Water - Sources for Phosphorus', 'fontsize', 14)
ylabel('Tot kg', 'fontsize', 12)
xlabel('1-Sum , 2-Wet dep, 3-Roads, 4-Roofs, 5-Other areas','FontSize',12)

set(gcf,'numbertitle','off')
set(gcf,'name','Sources for Phosphorus')



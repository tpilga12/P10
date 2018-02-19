%This file gives the total loads for sanitary wastewater and stormwater
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

clear Y
clear Ys

disp('-------------------------')
disp('Sanitary wastewater volume')
disp('Urine')
disp('Faeces')
disp('Grey water')

for i=1:21
    if i==1
        disp('NOTE: VOLUME [m3]')
        [s_urine(1,i)*numberOfPersons*in_T*trans*1000
            s_faeces(1,i)*numberOfPersons*in_T*trans*1000
            s_bdt(1,i)*numberOfPersons*in_T*trans*1000]
    else
        tots=[sum(sewer(:,i))]*trans;
        urine=s_urine(1,i)*numberOfPersons*in_T*trans;
        faeces=s_faeces(1,i)*numberOfPersons*in_T*trans;
        grey=s_bdt(1,i)*numberOfPersons*in_T*trans;
        [urine
            faeces
            grey];
        if i==2
            Ys(1,:)=[urine,faeces,grey];
            tots_P=tots;
        elseif i==3
            Ys(2,:)=[urine,faeces,grey];
            tots_N=tots;
        elseif i==4
            Ys(3,:)=[urine,faeces,grey];
            tots_NH3_4=tots;
        elseif i==5
            Ys(4,:)=[urine,faeces,grey];
            tots_NO3=tots;
        elseif i==7
            Ys(5,:)=[urine,faeces,grey];
            tots_SS=tots;
        elseif i==8
            Ys(6,:)=[urine,faeces,grey];
            tots_BOD=tots;
        elseif i==9
            Ys(7,:)=[urine,faeces,grey];
            tots_COD=tots;
        elseif i==10
            Ys(8,:)=[urine,faeces,grey];
            tots_C_tot=tots;
        elseif i==12
            Ys(9,:)=[urine,faeces,grey];
            tots_Cu=tots;
        elseif i==13
            Ys(10,:)=[urine,faeces,grey];
            tots_Zn=tots;
        elseif i==14
            Ys(11,:)=[urine,faeces,grey];
            tots_Pb=tots;
        elseif i==15
            Ys(12,:)=[urine,faeces,grey];
            tots_Cd=tots;
        elseif i==16
            Ys(13,:)=[urine,faeces,grey];
            tots_Hg=tots;
        elseif i==17
            Ys(14,:)=[urine,faeces,grey];
            tots_Cr=tots;
        else
            Ys(15,:)=[urine,faeces,grey];
            tots_PAH=tots;
            
        end
    end
end

%sdistr=Ys';
%open sdistr

disp('-------------------------')
disp('Total Stormwater Volume [m3]')
sum(storm(:,1))*sec_per_ts

for i=2:21
    i;
    j=i-1;
    tot=[sum(storm(:,i))]*trans;
    wetdep1=[sum(s_wetdep(:,i))]*tota*trans1*trans2;
    road=[sum(s_road(:,j))]*trans1*trans2;
    roof=[sum(s_roof(:,j))]*trans1*trans2;
    other=[sum(s_other(:,j))]*trans1*trans2;
    %tot=[sum(storm22(:,i))]*trans;
    %wetdep2=[sum(s_wetdep2(:,i))]*tota2*trans1*trans2;
    %road=[sum(s_road2(:,j))]*trans1*trans2;
    %roof=[sum(s_roof2(:,j))]*trans1*trans2;
    %other=[sum(s_other2(:,j))]*trans1*trans2;
    storm_bar=[wetdep1,road,roof, other]';
    if i==12
        Y(1,:)=[Ys(9,:), wetdep1,road,roof, other];
        totsw_Cu=tot;
        totssw_Cu=totsw_Cu+tots_Cu;
    elseif i==13
        Y(2,:)=[Ys(10,:),wetdep1,road,roof, other];
        totsw_Zn=tot;
        totssw_Zn=totsw_Zn+tots_Zn;
    elseif i==14
        Y(3,:)=[Ys(11,:) wetdep1,road,roof, other];
        totsw_Pb=tot;
        totssw_Pb=totsw_Pb+tots_Pb;
    elseif i==15
        Y(4,:)=[Ys(12,:) wetdep1,road,roof, other];
        totsw_Cd=tot;
        totssw_Cd=totsw_Cd+tots_Cd;
    elseif i==2
        Y(5,:)=[Ys(1,:),wetdep1,road,roof, other];
        totsw_P=tot;
        totssw_P=totsw_P+tots_P;
    elseif i==3
        Y(6,:)=[Ys(2,:), wetdep1,road,roof, other];
        totsw_N=tot;
        totssw_N=totsw_N+tots_N;
    elseif i==21
        Y(7,:)=[Ys(15,:), wetdep1,road,roof, other];
        totsw_PAH=tot;
        totssw_PAH=totsw_PAH+tots_PAH;
    elseif i==8
        Y(8,:)=[Ys(6,:), wetdep1,road,roof, other];
        totsw_BOD=tot;
        totssw_BOD=totsw_BOD+tots_BOD;
    end
end

sswdistr=Y';
open sswdistr

swpoll_stack=[Y(1,:)/totssw_Cu*100;Y(2,:)/totssw_Zn*100;Y(3,:)/totssw_Pb*100;Y(4,:)/totssw_Cd*100;Y(5,:)/totssw_P*100;Y(6,:)/totssw_N*100;Y(7,:)/totssw_PAH*100; Y(8,:)/totssw_BOD*100];

figure
set(gcf,'position',w_size)

bar(swpoll_stack,'stack')
%colormap([1 0 0;0 1 0])
title('Total Pollution Load (Relative)', 'fontsize', 14)
ylabel('%', 'fontsize', 12)
xlabel('1-Cu, 2-Zn, 3-Pb, 4-Cd, 5-P, 6-N, 7-PAH, 8-BOD','FontSize',12)
AX=legend('Urine','Faeces','Grey Water','Wet Deposition','Roads','Roofs', 'Other areas');
ylim([0 100])

set(gcf,'numbertitle','off')
set(gcf,'name','Total Pollution Load Distribution')

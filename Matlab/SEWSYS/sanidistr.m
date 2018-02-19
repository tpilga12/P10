
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

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

sdistr=Ys';
open sdistr

spoll_stack=[Ys(1,:)/tots_P*100; Ys(2,:)/tots_N*100; Ys(3,:)/tots_NH3_4*100; Ys(4,:)/tots_NO3*100; Ys(5,:)/tots_SS*100; Ys(6,:)/tots_BOD*100; Ys(7,:)/tots_COD*100; Ys(8,:)/tots_C_tot*100; Ys(9,:)/tots_Cu*100; Ys(10,:)/tots_Zn*100; Ys(11,:)/tots_Pb*100; Ys(12,:)/tots_Cd*100; Ys(13,:)/tots_Hg*100; Ys(14,:)/tots_Cr*100; Ys(15,:)/tots_PAH*100;];

figure
set(gcf,'position',w_size)

bar(spoll_stack,'stack')
%colormap([1 0 0;0 1 0])
title('Sanitary Wastewater Pollution Load (Relative)', 'fontsize', 14)
ylabel('%', 'fontsize', 12)
xlabel('1-P, 2-N, 3-NH3_4, 4-NO3, 5-SS, 6-BOD, 7-COD, 8-C-tot, 9-Cu, 10-Zn, 11-Pb, 12-Cd, 13-Hg, 14-Cr, 15-PAH','FontSize',12)
AX=legend('Urine','Faeces','Grey Water');
ylim([0 100])

set(gcf,'numbertitle','off')
set(gcf,'name','Sanitary Wastewater Pollution Load Distribution')
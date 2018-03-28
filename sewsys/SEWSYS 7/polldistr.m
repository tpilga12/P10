%This file gives the load for stormwater from the different source categories
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size
disp('-------------------------')
disp('Total Stormwater Volume [m3]')
sum(storm(:,1))*sec_per_ts

clear Y
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
        Y(1,:)=[wetdep1,road,roof, other];
        totsw_Cu=tot;
    elseif i==13
        Y(2,:)=[wetdep1,road,roof, other];
        totsw_Zn=tot;
    elseif i==14
        Y(3,:)=[wetdep1,road,roof, other];
        totsw_Pb=tot;
    elseif i==15
        Y(4,:)=[wetdep1,road,roof, other];
        totsw_Cd=tot;
    elseif i==2
        Y(5,:)=[wetdep1,road,roof, other];
        totsw_P=tot;
    elseif i==3
        Y(6,:)=[wetdep1,road,roof, other];
        totsw_N=tot;
    elseif i==21
        Y(7,:)=[wetdep1,road,roof, other];
        totsw_PAH=tot;
    end %other substances can be added here
end

swdistr=Y';
open swdistr
figure
set(gcf,'position',w_size)
Y_mod=Y;
Y_mod(4,:)=Y_mod(4,:)*100; %multiplied with 100 to make graph look better
Y_mod(6,:)=Y_mod(6,:).*0.1; %multiplied with 0.1 to make graph look better
Y_mod(7,:)=Y_mod(7,:).*100; %multiplied with 100 to make graph look better
bar(Y_mod)
title('Stormwater Pollution Load (Absolute)', 'fontsize', 14)
ylabel('kg', 'fontsize', 12)
xlabel('1-Cu                2-Zn                   3-Pb        4-Cd(*100)            5-P             6-N(*0.1)              7-PAH(*100)', 'fontsize', 12)
set(gcf,'numbertitle','off')
set(gcf,'name','Stormwater Pollution Load Distribution 1')
AX=legend('Wet Deposition','Roads','Roofs', 'Other areas');
%ylim([0 1])
%xlim([1000 2500])

swpoll_stack=[Y(1,:)/totsw_Cu*100;Y(2,:)/totsw_Zn*100;Y(3,:)/totsw_Pb*100;Y(4,:)/totsw_Cd*100;Y(5,:)/totsw_P*100;Y(6,:)/totsw_N*100;Y(7,:)/totsw_PAH*100];

figure
set(gcf,'position',w_size)

bar(swpoll_stack,'stack')
%colormap([1 0 0;0 1 0])
title('Stormwater Pollution Load (Relative)', 'fontsize', 14)
ylabel('%', 'fontsize', 12)
xlabel('1-Cu, 2-Zn, 3-Pb, 4-Cd, 5-P, 6-N, 7-PAH','FontSize',12)
AX=legend('Wet Deposition','Roads','Roofs', 'Other areas');
ylim([0 100])

set(gcf,'numbertitle','off')
set(gcf,'name','Stormwater Pollution Load Distribution 2')

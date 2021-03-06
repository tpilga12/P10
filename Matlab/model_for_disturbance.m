close all
clear all

x=0;
for n = 0:90000
    if x > 0 
        if    x < 4*3600
            f(n)=0;
    
        end
    end
    if x > 4*3600 
%Fra 00 til 5,8
        if x< 2.156E+4
            f(n)=feval(@y1,x);
        end
    end
    if x >2.155E+4%2.1083E+4
        if x < 3.465E+4
    %Fra 5,8 til 9,6
        f(n)=feval(@y2,x);
        end
    end
%Fra 9,6 til 20
    if x > 34640%3.465E+4
        if x < 7.1272E+4
           f(n)=feval(@y3,x);
        end
    end
    if x > 71260%7.1272E+4
        if x < 86401
    %Fra 20 til 24
    f(n)=feval(@y4,x);
        end 
    end
    
    
    x = x+1;
    if x == 86401
        x =0;
    end
end

%%% residential
f1_1=(f*3.6)*517/2000;
f1_2=(f*3.6)*344/2000;
f1_3=(f*3.6)*1418/2000;
f2=(f*3.6)*173/2000;
f3=(f*3.6)*517/2000;
f4_1=(f*3.6)*3485/2000;
f4_2=(f*3.6)*517/2000;
f4_3=(f*3.6)*1797/2000;
f5=(f*3.6)*322/2000;
f6=(f*3.6)*356/2000;
f7=(f*3.6)*5874/2000;
f89=(f*3.6)*2067/2000;
f11=(f*3.6)*865/2000;

%%% industry
f1_1_indu = ((f*3.6)*517/2000)*1/5;
f1_3_indu = ((f*3.6)*1418/2000)*1/5;
f4_1_indu = ((f*3.6)*3485/2000)*1/5;
f7_indu = ((f*3.6)*5874/2000)*1/5;
f8_9_indu = ((f*3.6)*2067/2000)*1/5;
f10_1_indu = ((f*3.6)*3916/2000)*1/5;

xtime= 1:1:90000;




%%
close all

% Zone 1
reduce_plot(xtime,f1_1+f1_1_indu+f1_2+f1_3+f1_3_indu)
% hold on
% reduce_plot(xtime,f1_2)
% hold on
% reduce_plot(xtime,f1_3)
% hold on
% reduce_plot(xtime,f1_1_indu)
% hold on
% reduce_plot(xtime,f1_3_indu)
% legend('Zone 1,1')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend q('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')
%%
close all
%% Zone 2

reduce_plot(xtime,f1_2)

% legend('Zone 2')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 3
close all


reduce_plot(xtime,f3)

legend('Zone 3')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 4
close all


reduce_plot(xtime,f4_1+f4_2+f4_3+f4_1_indu)
% hold on
% reduce_plot(xtime,f4_2)
% hold on
% reduce_plot(xtime,f4_3)
% hold on
% reduce_plot(xtime,f4_1_indu)
% hold on
% legend('Zone 4,1', 'Zone 4,2','Zone 4,3','Zone 4,1 industry')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 5
close all


reduce_plot(xtime,f5)

% legend('Zone 5')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')


%% Zone 6
close all


reduce_plot(xtime,f6)

% legend('Zone 6')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 7
close all


reduce_plot(xtime,f7+f7_indu)
% hold on
% reduce_plot(xtime,f7_indu)
% legend('Zone 7','Zone 7 industry')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 8-9
close all


reduce_plot(xtime,f89+f8_9_indu)
% hold on
% reduce_plot(xtime,f8_9_indu)
% legend('Zone 8 & 9','Zone 8 & 9 industry')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% Zone 10
close all
% f10 = zeros(1,90000)
% counter = 1;
% i=1;
% p=1;
% for n= 1:length(xtime)/2700
%     
%     for i= 1:1800 
%        f10(1,counter) = 0; 
%        counter = counter +1;
%     end    
%     for p= 1:900 
%         f10(1,counter) = 350;
%        counter = counter +1;
%     end   
% end
% f10 = f10/1000;
reduce_plot(f10)
% legend('Zone 10')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')
%% Zone 11
close all


reduce_plot(xtime,f11)

% legend('Zone 11 ')

xticklabels({'01:00','05:00','09:00','13:00','17:00','21:00','01:00'})
set(gca,'xtick',[3600:14350:90000])
xlim([3600 90000])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')

%% From height to flow
% From N�rregade to main
dia_norre = 0.6;
Ie_norre = 0.0044;
Qf_norre = 72*(dia_norre/4)^0.635*pi*(dia_norre/2)^2*Ie_norre^0.5;
Q_out_norre=(0.46 - 0.5 *cos(pi*(f1N/dia_norre))+0.04*cos(2*pi*(f1N/dia_norre)))*Qf_norre;


%% Disturance in m^3/s
%%% residential
f1_1=(f*3.6)*517/2000;
f1_2=(f*3.6)*344/2000;
f1_3=(f*3.6)*1418/2000;
f2=(f*3.6)*173/2000;
f3=(f*3.6)*517/2000;
f4_1=(f*3.6)*3485/2000;
f4_2=(f*3.6)*517/2000;
f4_3=(f*3.6)*1797/2000;
f5=(f*3.6)*322/2000;
f6=(f*3.6)*356/2000;
f7=(f*3.6)*5874/2000;
f89=(f*3.6)*2067/2000;
f11=(f*3.6)*865/2000;
%%% industry
f1_1_indu = ((f*3.6)*517/2000)*1/5;
f1_3_indu = ((f*3.6)*1418/2000)*1/5;
f4_1_indu = ((f*3.6)*3485/2000)*1/5;
f7_indu = ((f*3.6)*5874/2000)*1/5;
f8_9_indu = ((f*3.6)*2067/2000)*1/5;
f10_1_indu = ((f*3.6)*3916/2000)*1/5;


f1_1 = [ zeros(1,250) f1_1];
% f1_1(1:3600+250)=[];

% f1_1=f1_1(1:86400+250);
f1_1=f1_1(1:90000);

f1_1_indu = [ zeros(1,250) f1_1_indu];
% f1_1_indu=f1_1_indu(251:86400+250);
f1_1_indu=f1_1_indu(1:90000);

f1_2 = [ zeros(1,500) f1_2];
f1_2=f1_2(1:90000);

f1_3 = [ zeros(1,1000) f1_3];
f1_3 =f1_3(1:90000);
f1_3_indu = [ zeros(1,1000) f1_3_indu];
f1_3_indu=f1_3_indu(1:90000);

f2 = f2(1:90000);

f3 = [ zeros(1,400) f3];
f3=f3(1:90000);

f4_1 = [ zeros(1,750) f4_1];
f4_1=f4_1(1:90000);
f4_1_indu = [ zeros(1,550) f4_1_indu];
f4_1_indu=f4_1_indu(1:90000);

f4_2 = [ zeros(1,700) f4_2];
f4_2=f4_2(1:90000);


f4_3 = [ zeros(1,551) f4_3];
f4_3=f4_3(1:90000);

f5 = f5(1:90000);

f6 = f6(1:90000);

f7 = [ zeros(1,500) f7];
f7=f7(1:90000);
f7_indu = [ zeros(1,500) f7_indu];
f7_indu=f7_indu(1:90000);

f89 = f89(1:90000);
f8_9_indu = f8_9_indu(1:90000);

f10 = [ zeros(1,450) f10];
f10 = f10(1:90000);
f10_1_indu = f10_1_indu(1:90000);

f11 = [ zeros(1,150) f11];
f11 = f11(1:90000);




disturbance = struct('Zone1_1',f1_1,'Zone1_2',f1_2,'Zone1_3',f1_3,'Industry_1_1',f1_1_indu,'Industry_1_3',f1_3_indu,'Zone2',f2,'Zone3',f3,'Zone4_1',f4_1,'Zone4_2',f4_2,'Zone4_3',f4_3,'Industry_4_1',f4_1_indu,'Zone5',f5,'Zone6',f6,'Zone7',f7,'Industry7_1',f7_indu,'Zone8And9',f89,'Industry_8And9',f8_9_indu,'Zone10',f10,'Industry_10_1',f10_1_indu,'Zone11',f11)
    %'f1_2','f1_3','f1_1_indu','f1_3_indu'}

%%
function y=y1(x)
% y =0.00787968*x^4-0.05717618*x^3+0.12314601*x^2-0.07534371*x+0.99986835; 
% y = 4.69135551E-17*x^4-1.22548401E-12*x^3+9.50200702E-09*x^2-2.09288079E-05*x+0.99986835;
y =-2.8283977E-25*x^6+2.59646909E-20*x^5-6.9646465E-16*x^4+7.8187321E-12*x^3-3.79574701E-08*x^2+6.36203303E-05*x+5.11743425E-15;
end
function y=y2(x)
y =1.36386912E-19*x^5-2.11119777E-14*x^4+1.29920629E-09*x^3-3.97127492E-05*x^2+0.60243431*x-3618.601359;
end
function y=y3(x)
y =9.09777237E-30*x^7-3.31145844E-24*x^6+5.0953161E-19*x^5-4.29724557E-14*x^4+2.14610381E-09*x^3-6.34907933E-05*x^2+1.03054368*x-7076.86531418;
end
function y=y4(x)
y = 7.17730966E-21*x^5-2.7981166E-15*x^4+4.33317708E-10*x^3-3.33312964E-05*x^2+1.27369468*x-1.93381976E+04;
end
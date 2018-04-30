close all
clear all

x=0;
for n = 0:86400
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
end

f1T=(f*3.6)*517/2000;
f1N=(f*3.6)*1762/2000;
f2=(f*3.6)*173/2000;
f3=(f*3.6)*517/2000;
f4=(f*3.6)*5799/2000;
f5=(f*3.6)*322/2000;
f6=(f*3.6)*356/2000;
f7=(f*3.6)*5874/2000;
f89=(f*3.6)*2066/2000;
f11=(f*3.6)*861/2000;

xtime= 1:1:86400;
%%
close all
%xtime = datetime(xtime,'format','hh')
%  reduce_plot(xtime/3600,f1T)
% hold on
reduce_plot(xtime/3600,f1N)
% hold on
% reduce_plot(xtime/3600,f2)
% hold on
% reduce_plot(xtime/3600,f3)
% hold on
%  reduce_plot(xtime/3600,f4)
% hold on
% reduce_plot(xtime/3600,f5)
% hold on
% reduce_plot(xtime/3600,f6)
% hold on
% reduce_plot(xtime/3600,f7)
% hold on
% reduce_plot(xtime/3600,f89)
% hold on
% reduce_plot(xtime/3600,f11)
% hold on

xticklabels({'00:00','04:00','8:00','12:00','16:00','20:00'})
set(gca,'xtick',[0:4:24])
xlim([0 24])
grid
% legend('1T','1N','2','3','4','5','6','7','8-9','11')
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/hr]')
%% From height to flow
% From Nørregade to main
dia_norre = 0.6;
Ie_norre = 0.0044;
Qf_norre = 72*(dia_norre/4)^0.635*pi*(dia_norre/2)^2*Ie_norre^0.5;
Q_out_norre=(0.46 - 0.5 *cos(pi*(f1N/dia_norre))+0.04*cos(2*pi*(f1N/dia_norre)))*Qf_norre;


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
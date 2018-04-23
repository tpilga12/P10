close all
clear all
% x = 5:0.5:11.5;
% y = [  .5  2 
%       4.2 7 
%       6.5 6 
%       5.5 5 4.5 4.2 4 3.9 3.7 3.6  
%     ];     
%       
% 
% plot(x,y,'.')
% hold on
% X=fit(x',y','poly5')
% plot(X)
%  
% 
% % 1 0.5   Fra 0 til 4.5
% %     0 0 
% %     0 0 
% %     0 0
% %     0 .2


%3.5 3.4 3.3 3.2 3.2 3.2 3.3 3.5 3.9 4.3 5   5.5 6.1 6.3  5.7 5.1 4.7 4.5 4.3 4.1 3.9 3.5
%3.2 2.4 fra 13 til 23:30
x=0;
for n = 0:86400
    if x > 0 
%Fra 00 til 5,8
        if x< 5.9
            f(n)=feval(@y1,x);
        end
    end
    if x >5.9
        if x < 9.6
    %Fra 5,8 til 9,6
        f(n)=feval(@y2,x);
        end
    end
%Fra 9,6 til 20
    if x > 9.6
        if x < 19.3
           f(n)=feval(@y3,x);
        end
    end
    if x > 19.3
        if x < 24 
    %Fra 20 til 24
    f(n)=feval(@y4,x);
        end 
    end
    x = x+0.0067*20;
end

f=f;
xtime= 0.0067*20:0.0067*20:24;
%xtime = datetime(xtime,'format','hh')
plot(xtime,f)
xticklabels({'00:00','05:00','10:00','15:00','20:00'})
grid
xlim([0 24])
title('Daily flow')
xlabel('Time [hh:mm]')
ylabel('Flow [l/s]')



function y=y1(x)
y =0.00787968*x^4-0.05717618*x^3+0.12314601*x^2-0.07534371*x+0.99986835; 
end
function y=y2(x)
y =0.08246795*x^5-3.54600156*x^4+60.61576894*x^3-514.67723058*x^2+2168.76350652*x-3618.60136301;
end
function y=y3(x)
y =7.12944256E-05*x^7-0.00720838*x^6+0.3080966*x^5-7.21777918*x^4+100.1294443*x^3-822.84778935*x^2+3709.99087351*x-7076.93259674; 
end
function y=y4(x)
y =0.00936408*x^5-0.98908244*x^4+41.63882839*x^3-873.32874312*x^2+9125.17202327*x-3.79897918E+04;
end
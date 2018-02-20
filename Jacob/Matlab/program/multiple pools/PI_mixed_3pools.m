%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Automatic Tuning of Distant Downstream, Local Upstream  %%%
%%% and Mixed PI Controllers for an Irrigation Canal        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X. Litrico, 2009

clear all; 
%close all

%---------------------------------
% ID model of the canal pools 
tau=[1 1 1];
Ad=[1 5 1];
n=length(tau);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tuning of Distant Downstream PI Controllers %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gain Margin
DG1=[10 10 10];
%DG1=[10 10 10];
tau1=[1 1 1];%2.75];% equivalent delay used to tune the distant downstream controllers

w180=pi/2./tau1;% frequency at -180 degrees
wc=w180.*10.^(-DG1/20);% Crossover frequency
DPmax=(pi/2-tau1.*wc)*180/pi;% maximum phase margin
DP1=[0.7 0.7 0.7].*DPmax;% phase margin ratio
% proportional gains
kp1=Ad.*wc.*abs(sin(DP1*pi/180+tau1.*wc));
% integral times
Ti1=1./wc.*tan(DP1*pi/180+tau1.*wc);

% distant downstream PI controllers
for i=1:n
    Kdd=kp1(i)*tf([1 1/Ti1(i)],[1 0]);
    K1(i)=Kdd;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tuning of Local Upstream P Controller %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tuning assuming a delay due to sampling
Te=max(tau)/5;
tau2=Te/2;
DG2=DG1;
w180=pi/2/tau2;
wc2=w180.*10.^(-DG2/20);
% proportional coefficient
kp2=-Ad.*wc2;
% local upstream P controllers
for i=1:n
    Klu=kp2(i);
    K2(i)=Klu;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tuning of Mixed PI Controllers %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameter theta 
theta=1*[1 1 0];  %1: pure mixed controller
                    %0: pure DD controller
theta=1*[1 0 1];
                    % Decouplers
% Distant Downstream decoupler
%dec_DD=1*[1 1];
dec_DD=1*[0.8 0.9];
% Local Upstream decoupler
dec_LU=1*[1 1];
%dec_LU=1*[1 1];
% Mixed controller
DG1b=1.3*[10 10 10];% Gain margin
% controller K1b
% proportional gain
kp1b=10.^(-DG1b/20);
% Maximum phase margin
DPmax1b=(pi/2+asin(kp1b))*180/pi;
% phase margin
DP1b=0.7*DPmax1b;
% Crossover frequency
w180b=pi./tau*3/4;
wc1b=1./tau.*(pi/2-DP1b*pi/180+asin(kp1b));
Ti1b=1./wc1b.*kp1b./sqrt(1-kp1b.^2);
kp1b=kp1b./sqrt(1+1./(Ti1b.^2.*w180b.^2));

for i=1:n
    K2(i)=K2(i)*theta(i);
    K1b(i)=kp1b(i)*tf([1 1/Ti1b(i)],[1 0]);%*tf(1,[1 1/Ti2(i)]);
    K1(i)=(1-theta(i))*K1(i);
end

% Time domain simulations
f1=1;
tfin=150;
t_step1=1;
t_step2=50;
t_step3=100;
[ts,xs,ys]=sim('sim_IDmodel_3pools',0:0.1:tfin);

y=ys(:,1:n);
u=ys(:,n+1:end);
t=ts(:,1);    

figure;
subplot(2,1,1)
h=newplot;
set(h,'DefaultLineLineWidth',1);
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|--|-.|:')
set(h,'FontSize',14)
plot(t,y,'LineWidth',2);
%legend('\theta=1','\theta=0.1','\theta=0')
hold on
grid
%axis([0 20 -2 0])
title('Ouput y^*')
xlabel('t/\tau')
ylabel('Ay/(\tauQ)')
legend('y_1','y_2','y_3')
subplot(2,1,2)
h=newplot;
set(h,'FontSize',14)
%set(h,'FontSize',14,'LineWidth',1)
plot(t,u,'LineWidth',2);
hold on
grid
%axis([0 20 -1.5 1.5])
title('Control u^*')
xlabel('t/\tau')
ylabel('u/Q')   
legend('u_1','u_2','u_3','u_4')



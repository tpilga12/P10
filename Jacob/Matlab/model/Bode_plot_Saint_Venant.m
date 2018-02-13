% This file computes the frequency response of the linearized Saint-Venant equation
% for non uniform flow conditions
% Uses freqresp_SV.m 
%
% XL 2002-2009 

clear all; 
close all
%----------
g=9.81;
%---------------------------------
type=1;% example canal type (1 or 2)
%---------------------------------
if type==1
    L=3000; %canal length in meters     
    B=7; %bottom width
    Sb=0.0001; %bottom slope
    K=50; %Strickler coefficient (inverse of Manning)
    m=1.5; % side slope
    Q=14;    %maximum discharge
    yn=2.1221; % normal depth
    yL=1.2*yn; % downstream boundary condition
    w=logspace(-5,-1,500);%frequency points
elseif type==2    
    L=6000; %canal length in meters
    B=8; %bottom width
    Sb=0.0008; %bottom slope
    K=50; %Strickler coefficient (inverse of Manning)
    m=1.5; % side slope
    Q=80;    %maximum discharge
    yn=2.9234; % normal depth
    yL=1.2*yn; % downstream boundary condition
    w=logspace(-5,-1,500);%frequency points
end
%---------------------------------------------------------------

% Computation of the frequency response 
[x,y,g11,g12,g21,g22]=freqresp_SV(Q,L,B,Sb,K,m,yL,w,L/100);

% input-output transfer functions
p11=g11(:,1);
p12=g12(:,1);
p21=g11(:,end);
p22=g12(:,end);    
    
phase_p11=unwrap(angle(p11));
phase_p12=unwrap(angle(p12));
phase_p21=unwrap(angle(p21));
phase_p22=unwrap(angle(p22));
   
%%%%%%%%%%%%%%%%%%%%
%%%%% plots %%%%%%%%
%%%%%%%%%%%%%%%%%%%%
figure;
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
mesh(x,w,20*log10(abs(g11)));
ylabel('Freq. (rad/s)')
xlabel('abscissa (m)')
zlabel('Gain (dB)')
if type==1
    axis([0 3000 1e-4 10^(-1.5) -60 20])
elseif type ==5
    axis([0 6000 1e-5 10^(-1.5) -60 20])
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Bode plots %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(2,2,1)
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|--|-.|:')
semilogx(w,20*log10(abs(p11)),'LineWidth',1);
ylabel('Gain (dB)')
axis([1e-5 1e-1 -60 20])
grid on
hold on
title(['p_{11}'])
subplot(2,2,3)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*phase_p11/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
axis([1e-5 1e-1 -300 100])
grid on

subplot(2,2,2)
h=newplot;
set(h,'FontSize',14)
semilogx(w,20*log10(abs(p12)),'LineWidth',1);
ylabel('Gain (dB)')
axis([1e-5 1e-1 -60 20])
grid on
hold on
title(['p_{12}'])
subplot(2,2,4)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*phase_p12/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
axis([1e-5 1e-1 -500 100])
grid on
% END  Bode Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  Bode Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,2,1)
h=newplot;
set(h,'FontSize',14)
semilogx(w,20*log10(abs(p21)),'LineWidth',1);
ylabel('Gain (dB)')
axis([1e-5 1e-1 -60 20])
grid on
hold on
title(['p_{21}'])
subplot(2,2,3)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*phase_p21/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
axis([1e-5 1e-1 -500 0])
grid on

subplot(2,2,2)
h=newplot;
set(h,'FontSize',14)
semilogx(w,20*log10(abs(p22)),'LineWidth',1);
ylabel('Gain (dB)')
axis([1e-5 1e-1 -60 20])
grid on
hold on
title(['p_{22}'])
subplot(2,2,4)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*phase_p22/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
axis([1e-5 1e-1 0 300])
grid on
% END Bode Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

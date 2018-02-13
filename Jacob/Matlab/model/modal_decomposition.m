% This files computes the modal decomposition of the linearized Saint-Venant equation
% for a uniform flow condition
%
% XL 15/01/2009 

clear all; 
close all
%----------
g=9.81;
%---------------------------------
type=1; % example canal type (1 or 2)
%---------------------------------
if type==1
    L=3000; %canal length in meters    
    B=7; %bottom width
    Sb=0.0001; %bottom slope
    K=50; %Strickler coefficient
    m=1.5; % side slope
    Q=14;    %maximum discharge
    yn=2.1221; % normal depth
    w=logspace(-5,-1,500);%frequency points
    s=sqrt(-1)*w;
elseif type==2    
    L=6000; %canal length in meters
    B=8; %bottom width
    Sb=0.0008; %bottom slope
    K=50; %Strickler coefficient
    m=1.5; % side slope
    Q=80;    %maximum discharge
    yn=2.9234; % normal depth
    w=logspace(-5,-1,500);%frequency points
    s=sqrt(-1)*w;
end

y=yn;
% Physical characteristics of the flow
T=B+2*m*y;
A=y.*(B+m*y);
P=B+2*sqrt(1+m^2)*y;
R=A./P;
% square of the Froude number
Fr2=Q^2*T./(g*A.^3);
% friction slope
Sf=Q^2./(K^2*A.^2.*R.^(4/3));
%---------------------------------
x=0:L/100:L;
% dPdy
dPdy=2*sqrt(1+m^2); 
%dTdx=2*m*dydx;
%------------------
V=Q./A;%velocity
C=sqrt(g*A./T);%celerity
%------------------
alpha=V+C;
beta=C-V;
kappa=7/3-4/3*A./P./T.*dPdy;
gamma=g*(1+kappa)*Sb;
delta=2*g./V.*Sb;

tau1=L/alpha;
tau2=L/beta;
r1=(alpha.*delta-gamma)./alpha./(alpha+beta);
r2=(beta.*delta+gamma)./beta./(alpha+beta);
% -------------------poles --------------------
% number of pairs of poles
nk=1:10;

% integrator
s0(1)=0; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Computation of the modal factors%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialization
ga=gamma*L/alpha/beta;
ega=exp(ga);
% modal decomposition gij
% modal factors for the integrator
a11(1,:)=ga/L*exp(ga*x/L)/(exp(ga)-1)/T;   
a12(1,:)=-a11(1,:);
a21(1,:)=0.*exp(ga*x/L);
a22(1,:)=0.*exp(ga*x/L);

% computation of bij(x)
b11=exp(ga*x/L)/T/(ega-1)^2.*((alpha-beta)/alpha/beta*(ega*(1+ga*(x/L-1))-1-ga*x/L)+delta/gamma*(exp(ga*(1-x/L))*(ega-1)+ega*(1+ga*(x/L-2))-1-ga*x/L));
b12=1/T/(ega-1)^2*((alpha-beta)/alpha/beta*exp(ga*x/L).*(ga*ega+(1-ega)*(1+ga*x/L))+delta/gamma*(ga*exp(ga*x/L)*(1+ega)+(1-ega)*(1+exp(ga*x/L).*(1+ga*x/L))));
b21=(ega-exp(ga*(x/L-1)))/(ega-1);
b22=(exp(ga*x/L)-1)/(ega-1);

%
% approx_gij are the truncated series of the modal decomposition
% 

approx_g11=ones(size(s))'*b11+1./s'*a11(1,:);
approx_g12=ones(size(s))'*b12+1./s'*a12(1,:);
approx_g21=ones(size(s))'*b21;
approx_g22=ones(size(s))'*b22;

% approx with the integrator
approx_g11_0=approx_g11;
approx_g12_0=approx_g12;

% modal decomposition of gijtilde
a11t(1,:)=a11(1,:);
a12t(1,:)=a12(1,:);
a21t(1,:)=a21(1,:);
a22t(1,:)=a22(1,:);

% coef bij(x)
b11t=b11+x./alpha.*a11(1,:);
b12t=b12+(L-x)./beta.*a12(1,:);
b21t=b21;
b22t=b22;

approx_g11t=ones(size(s))'*b11t+1./s'*a11t(1,:);
approx_g12t=ones(size(s))'*b12t+1./s'*a12t(1,:);
approx_g21t=ones(size(s))'*b21t;
approx_g22t=ones(size(s))'*b22t;

% approx with the integrator
approx_g11t_0=approx_g11t;
approx_g12t_0=approx_g12t;
%------------------
a=2*V/(C^2-V^2);
b=gamma/alpha/beta;
c=T;
d=1/T/(C^2-V^2);
e=2*g*Sb/V/T/(C^2-V^2);
%-----
A=a^2+4*d*c;
B=a*b+2*e*c;
C=b^2;
for k=1:10
    Delta=B^2-A*(C+4*k^2*pi^2/L^2);                  
    %
    % poles of Saint-Venant transfer matrix
    %
    s0(2*k)=(-B+sqrt(Delta))/A;
    s0(2*k+1)=(-B-sqrt(Delta))/A; 
    %
    %  Modal decomposition of gij
    %
    spec1=(a*s0(2*k)+b)/2/k/pi*L*sin(k*pi*x/L)+cos(k*pi*x/L);
    spec2=(a*s0(2*k+1)+b)/2/k/pi*L*sin(k*pi*x/L)+cos(k*pi*x/L);        
    % modal factors
    a11(2*k,:)=-4*k^2*pi^2/sqrt(Delta)/s0(2*k)/L^3/T*exp(1/2*(a*s0(2*k)+b)*x).*spec1; 
    a11(2*k+1,:)=4*k^2*pi^2/sqrt(Delta)/s0(2*k+1)/L^3/T*exp(1/2*(a*s0(2*k+1)+b)*x).*spec2; 
    a12(2*k,:)=(-1)^(k)*4*k^2*pi^2/sqrt(Delta)/s0(2*k)/L^3/T*exp(1/2*(a*s0(2*k)+b)*(x-L)).*spec1; 
    a12(2*k+1,:)=(-1)^(k+1)*4*k^2*pi^2/sqrt(Delta)/s0(2*k+1)/L^3/T*exp(1/2*(a*s0(2*k+1)+b)*(x-L)).*spec2; 
    a21(2*k,:)=-4*k*pi/sqrt(Delta)/s0(2*k)/L^2*exp(1/2*(a*s0(2*k)+b)*x).*sin(k*pi*x/L); 
    a21(2*k+1,:)=4*k*pi/sqrt(Delta)/s0(2*k+1)/L^2*exp(1/2*(a*s0(2*k+1)+b)*x).*sin(k*pi*x/L); 
    a22(2*k,:)=(-1)^k*4*k*pi/sqrt(Delta)/s0(2*k)/L^2*exp(1/2*(a*s0(2*k)+b)*(x-L)).*sin(k*pi*x/L); 
    a22(2*k+1,:)=-(-1)^k*4*k*pi/sqrt(Delta)/s0(2*k+1)/L^2*exp(1/2*(a*s0(2*k+1)+b)*(x-L)).*sin(k*pi*x/L); 
    % Rational approx of gij 
    approx_g11=approx_g11 + 1./(s'-s0(2*k+1))*a11(2*k+1,:) +  1./(s'-s0(2*k))*a11(2*k,:)+ ones(size(s))'*(a11(2*k+1,:)/s0(2*k+1) +  a11(2*k,:)/s0(2*k)); 
    approx_g12=approx_g12 + 1./(s'-s0(2*k+1))*a12(2*k+1,:) +  1./(s'-s0(2*k))*a12(2*k,:)+ ones(size(s))'*(a12(2*k+1,:)/s0(2*k+1) +  a12(2*k,:)/s0(2*k)); 
    approx_g21=approx_g21 + 1./(s'-s0(2*k+1))*a21(2*k+1,:) +  1./(s'-s0(2*k))*a21(2*k,:)+ ones(size(s))'*(a21(2*k+1,:)/s0(2*k+1) +  a21(2*k,:)/s0(2*k)); 
    approx_g22=approx_g22 + 1./(s'-s0(2*k+1))*a22(2*k+1,:) +  1./(s'-s0(2*k))*a22(2*k,:)+ ones(size(s))'*(a22(2*k+1,:)/s0(2*k+1) +  a22(2*k,:)/s0(2*k)); 
            
    % Modal decomposition of gijtilde (without the delay)
    a11t(2*k,:)=a11(2*k,:).*exp(s0(2*k).*x./alpha);
    a11t(2*k+1,:)=a11(2*k+1,:).*exp(s0(2*k+1).*x./alpha);
    a12t(2*k,:)=a12(2*k,:).*exp(s0(2*k)*(L-x)/beta);
    a12t(2*k+1,:)=a12(2*k+1,:).*exp(s0(2*k+1)*(L-x)/beta);
    a21t(2*k,:)=a21(2*k,:).*exp(s0(2*k)*x/alpha);    
    a21t(2*k+1,:)=a21(2*k+1,:).*exp(s0(2*k+1)*x/alpha);
    a22t(2*k,:)=a22(2*k,:).*exp(s0(2*k)*(L-x)/beta);
    a22t(2*k+1,:)=a22(2*k+1,:).*exp(s0(2*k+1)*(L-x)/beta);
    % Rational approx of gijtilde
    approx_g11t=approx_g11t + 1./(s'-s0(2*k+1))*a11t(2*k+1,:) +  1./(s'-s0(2*k))*a11t(2*k,:)+ ones(size(s))'*(a11t(2*k+1,:)/s0(2*k+1) +  a11t(2*k,:)/s0(2*k)); 
    approx_g12t=approx_g12t + 1./(s'-s0(2*k+1))*a12t(2*k+1,:) +  1./(s'-s0(2*k))*a12t(2*k,:)+ ones(size(s))'*(a12t(2*k+1,:)/s0(2*k+1) +  a12t(2*k,:)/s0(2*k)); 
    approx_g21t=approx_g21t + 1./(s'-s0(2*k+1))*a21t(2*k+1,:) +  1./(s'-s0(2*k))*a21t(2*k,:)+ ones(size(s))'*(a21t(2*k+1,:)/s0(2*k+1) +  a21t(2*k,:)/s0(2*k)); 
    approx_g22t=approx_g22t + 1./(s'-s0(2*k+1))*a22t(2*k+1,:) +  1./(s'-s0(2*k))*a22t(2*k,:)+ ones(size(s))'*(a22t(2*k+1,:)/s0(2*k+1) +  a22t(2*k,:)/s0(2*k)); 
end


% Figure aij    
figure;
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|--|-.|:')
plot(x,abs(a11(1,:)),x,abs(a11(2,:)),x,abs(a11(4,:)),x,abs(a11(6,:)),'LineWidth',1)
legend('k=0','k=1','k=2','k=3')
xlabel('abscissa (m)')
title('|a_{11}^{(k)}(x)|')%ylabel

% Figure bij    
figure;
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|--|-.|:')
plot(x,b11,x,b12,'LineWidth',1)
legend('b_{11}(x)','b_{12}(x)')
xlabel('abscissa (m)')

% Figure bij tilde   
figure;
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|--|-.|:')
plot(x,b11t,x,b12t,'LineWidth',1)
legend('b^~_{11}(x)','b^~_{12}(x)')
xlabel('abscissa (m)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Computation of the step response %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if type==1
    t=0:1:3000; %time vector for the simulation
elseif type==2
    t=0:2:6000;
end

tt=t'*ones(size(x));
% step response
y1=ones(size(t))'*b11+t'*a11(1,:);
y2=ones(size(t))'*b12+t'*a12(1,:);
t1=tt-ones(size(t))'*x/alpha;
t2=tt-ones(size(t))'*(L-x)/beta;
retard1=max(0,t1);
retard2=max(0,t2);
onest1=max(0,t1./abs(t1));
onest2=max(0,t2./abs(t2));
y1t=onest1.*(ones(size(t))'*b11t)+retard1.*(ones(size(t))'*a11t(1,:));
y2t=onest2.*(ones(size(t))'*b12t)+retard2.*(ones(size(t))'*a12t(1,:));

y1t_0=y1t;y1_0=y1;
y2t_0=y2t;y2_0=y2;
%
% step response 
%
for k=1:10
    y1=y1 + (ones(size(t))'/s0(2*k+1)*a11(2*k+1,:)).*exp(tt*s0(2*k+1)) +  (ones(size(t))'/s0(2*k)*a11(2*k,:)).*exp(tt*s0(2*k)); 
    y2=y2 + (ones(size(t))'/s0(2*k+1)*a12(2*k+1,:)).*exp(tt*s0(2*k+1)) +  (ones(size(t))'/s0(2*k)*a12(2*k,:)).*exp(tt*s0(2*k)); 
    y1t=y1t + onest1.*(ones(size(t))'*a11t(2*k+1,:)).*exp(t1*s0(2*k+1))/s0(2*k+1) +  onest1.*(ones(size(t))'*a11t(2*k,:)).*exp(t1*s0(2*k))/s0(2*k); 
    y2t=y2t + onest2.*(ones(size(t))'*a12t(2*k+1,:)).*exp(t2*s0(2*k+1))/s0(2*k+1) +  onest2.*(ones(size(t))'*a12t(2*k,:)).*exp(t2*s0(2*k))/s0(2*k);
end

figure
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
set(0,'DefaultAxesColorOrder',[0 0 0],...
    'DefaultAxesLineStyleOrder','-|--|-.|:')
subplot(221)
h=newplot;
set(h,'FontSize',14)
plot(t,y1t(:,1),t,y1t_0(:,1),'LineWidth',1)
hold on
xlabel('time (s)')
title('p_{11}')
subplot(223)
h=newplot;
set(h,'FontSize',14)
plot(t,y1t(:,end),t,y1t_0(:,end),'LineWidth',1)
hold on
xlabel('time (s)')
title('p_{21}')
subplot(222)
h=newplot;
set(h,'FontSize',14)
plot(t,y2t(:,1),t,y2t_0(:,1),'LineWidth',1)
hold on
xlabel('time (s)')
title('p_{12}')
subplot(224)
h=newplot;
set(h,'FontSize',14)
plot(t,y2t(:,end),t,y2t_0(:,end),'LineWidth',1)
hold on
xlabel('time (s)')
title('p_{22}')


figure;
h=newplot;
set(h,'FontSize',14)
set(h,'DefaultLineLineWidth',1);
title('step response')
mesh(x,t,y1t);
ylabel('time (s)')
xlabel('abscissa (m)')


% computation of the exact solution
x12=-c*s;
x21=-d*s-e;
x22=a*s+b;
land1=0.5*(x22-sqrt(x22.^2+4*x21.*x12));
land2=0.5*(x22+sqrt(x22.^2+4*x21.*x12));
    
l1s=(land1./s)'*ones(size(x));
l2s=(land2./s)'*ones(size(x));
dens=(1-exp((land1'-land2')*ones(size(x))*L));
g11=(l2s.*exp(land2'*(x-L)+land1'*ones(size(x))*L)-l1s.*exp(land1'*x))./dens/T;
g12=(l1s.*exp(land1'*x-land2'*ones(size(x))*L)-l2s.*exp(land2'*(x-L)))./dens/T;
g21=(exp(land1'*x)-exp(land2'*(x-L)+land1'*ones(size(x))*L))./dens;
g22=(exp(land2'*x)-exp(land1'*x))./dens;
g11t=g11.*exp(s'*x/alpha);
g12t=g12.*exp(s'*(L-x)/beta);
g21t=g21.*exp(s'*x/alpha);
g22t=g22.*exp(s'*(L-x)/beta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Comparison exact and approximated transfers %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p21t=g11t(:,end);p21t_0=approx_g11t_0(:,end);p21t_10=approx_g11t(:,end);
p22t=g12t(:,end);p22t_0=approx_g12t_0(:,end);p22t_10=approx_g12t(:,end);
% DESSIN Bode P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,2,1)
h=newplot;
set(h,'FontSize',14)
semilogx(w,20*log10(abs(p21t)),w,20*log10(abs(p21t_10)),w,20*log10(abs(p21t_0)),'LineWidth',1);
%xlabel('dimensionless frequency')
ylabel('Gain (dB)')
axis([1e-4 1e-1 -60 0])
grid on
hold on
title(['p_{21}'])
subplot(2,2,3)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*unwrap(angle(p21t))/pi,w,180*unwrap(angle(p21t_10))/pi,w,180*unwrap(angle(p21t_0))/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
%axis([1e-4 1e-1 -500 0])
grid on

subplot(2,2,2)
h=newplot;
set(h,'FontSize',14)
semilogx(w,20*log10(abs(p22t)),w,20*log10(abs(p22t_10)),w,20*log10(abs(p22t_0)),'LineWidth',1);
%xlabel('dimensionless frequency')
ylabel('Gain (dB)')
axis([1e-4 1e-1 -60 0])
grid on
hold on
title(['p_{22}'])
subplot(2,2,4)
h=newplot;
set(h,'FontSize',14)
semilogx(w,180*unwrap(angle(p22t))/pi,w,180*unwrap(angle(p22t_10))/pi,w,180*unwrap(angle(p22t_0))/pi,'LineWidth',1);
xlabel('Freq. (rad/s)')
ylabel('Phase (deg)')
%axis([1e-4 1e-1 0 300])
grid on
% FIN DESSIN Bode P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


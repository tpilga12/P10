function [T1,T2,tau1,tau2,Ad,Au,p_inf,x1,N]=IDZmodel(Q,L,B,Sb,K,m,yL,Qmin,Qmax)

% function
% [T1,T2,tau1,tau2,Ad,Au,p_inf,x1,N]=IDZmodel(Q,L,B,Sb,K,m,yL,Qmin,Qmax)
%
% computes the IDZ model parameters for a canal pool:
% - T1 and T2: downstream and upstream group delays
% - tau1 and tau2: downstream and upstream mathematical delays
% - Ad and Au: downstream and upstream areas
% - p_inf(1:4): gains at infinity
% - N: hydraulic exponent
%
% Xavier Litrico 2002/2009
%---------------------------------
g=9.81;
% computation of the uniform depth
[y1,fval,exitflag]=fzero('ynormal',(Qmax/(K*B*sqrt(Sb)))^(3/5),[],K,Sb,B,m,Qmax);
[y2,fval,exitflag]=fzero('ynormal',(Qmin/(K*B*sqrt(Sb)))^(3/5),[],K,Sb,B,m,Qmin);

N=2*log(Qmax/Qmin)/log(y1/y2);
yn=(Q/Qmax)^(2/N)*y1;

ym=yL;
TL=B+2*m*ym;
AL=ym*(B+m*ym);
PL=B+2*sqrt(1+m^2)*ym;
RL=AL/PL;
FL2=Q^2*TL/(g*AL^3);
SfL=Q^2/(K^2*AL^2*RL^(4/3));
Sb_L=max((Sb-SfL)/(1-FL2),0);
% computation of x1
if Sb_L==0
    x1=L;
else
    x1=max(L-(yL-yn)/Sb_L,0); % intersection with the uniform detph
    x1=min(L,x1);
end
if x1==0
    yn=yL-L*Sb_L; 
end
% parameters for discharge Q
T0=B+2*m*yn;
A0=yn*(B+m*yn);
P0=B+2*sqrt(1+m^2)*yn;
dPdy=2*sqrt(1+m^2);
C0=sqrt(g*A0/T0);% celerity
V0=Q/A0;%velocity
F0=V0/C0;% Froude
k0=7/3-4/3*A0/P0/T0*dPdy;
chi0=x1*Sb*T0/A0;
% uniform 
b0=T0*Sb*(1+k0)/A0/(1-F0^2);

%===========================%
%     approximate IDZ model     %
%===========================%

% water depth 
ym=(yL+yn)/2;
Tm=B+2*m*ym;
Am=ym*(B+m*ym);
Pm=B+2*sqrt(1+m^2)*ym;
Rm=Am/Pm;
Cm=sqrt(g*Am/Tm);% celerity
Vm=Q/Am;
Fm=Vm/Cm;% Froude 
% friction slope
Jm=Q^2/(K^2*Am^2*Rm^(4/3));
% parameter bm
km=7/3-4/3*Am/Pm/Tm*dPdy;
bm=Fm^2/Tm/(1-Fm^2)*2*m*Sb_L+Tm*(Sb*(1+km)-(1+km-Fm^2*(km-2))*Sb_L)/Am/(1-Fm^2);

% backwater areas
Ad0=T0/b0*(1-exp(-b0*x1));
Adm=Tm/bm*(1-exp(-bm*(L-x1)));
Ad=Adm+Ad0*exp(-bm*(L-x1));

Aum=Tm/bm*(exp(bm*(L-x1))-1);
Au0=T0/b0*(exp(b0*x1)-1);
Au=Au0+Aum*exp(b0*x1);

% mathematical delays
tau1=x1/(C0+V0)+(L-x1)/(Cm+Vm);
tau2=x1/(C0-V0)+(L-x1)/(Cm-Vm);

%====================%
% computation of p_inf    %
%====================%
% uniform part 
aa=2*V0/(C0^2-V0^2);
bb=b0;
ee=2*g*Sb/V0/(C0^2-V0^2);
AA=4*C0^2/(C0^2-V0^2)^2;
BB=aa*bb+2*ee;
CC=bb^2;
% 
alpha0=BB/sqrt(AA);
p11_inf0=1/T0/(C0-V0)*sqrt((1+((1-F0)/(1+F0))^2*exp(alpha0*x1))/(1+exp(alpha0*x1)));
p12_inf0=2/C0/T0/(1-F0^2)*exp(-b0*x1/2)/sqrt(1+exp(alpha0*x1));
p21_inf0=2/C0/T0/(1-F0^2)*exp(b0*x1/2)/sqrt(1+exp(alpha0*x1));
p22_inf0=1/T0/(C0+V0)*sqrt((1+((1+F0)/(1-F0))^2*exp(alpha0*x1))/(1+exp(alpha0*x1)));
p22_inf0=abs(p22_inf0);

% group delay
T10=-BB/CC-x1*aa/2+x1*BB/sqrt(CC)*(1/2+exp(-bb*x1)/(1-exp(-bb*x1)));
T20=T10+x1*aa;

% backwater part
aa=2*Vm/(Cm^2-Vm^2);
bb=bm;
ee=2*g*(Sb-Sb_L)/Vm/(Cm^2-Vm^2);
AA=4*Cm^2/(Cm^2-Vm^2)^2;
BB=aa*bb+2*ee;
CC=bb^2;
alpham=BB/sqrt(AA);
%
p11_infm=1/Tm/(Cm-Vm)*sqrt((1+((1-Fm)/(1+Fm))^2*exp(alpham*(L-x1)))/(1+exp(alpham*(L-x1))));
p11_infm=abs(p11_infm);
p12_infm=2*Cm/(Cm^2-Vm^2)/Tm*exp(-bm*(L-x1)/2)/sqrt(1+exp(alpham*(L-x1)));
p21_infm=2*Cm/(Cm^2-Vm^2)/Tm*exp(bm*(L-x1)/2)/sqrt(1+exp(alpham*(L-x1)));
p22_infm=1/Tm/(Cm+Vm)*sqrt((1+((1+Fm)/(1-Fm))^2*exp(alpham*(L-x1)))/(1+exp(alpham*(L-x1))));

% group delay
T1m=-BB/CC-(L-x1)*aa/2+(L-x1)*BB/sqrt(CC)*(1/2+exp(-bb*(L-x1))/(1-exp(-bb*(L-x1)))) ;
T2m=T1m+aa*(L-x1);

if x1==L % the whole pool is in uniform flow
    p11_inf=p11_inf0;
    p12_inf=p12_inf0;
    p21_inf=p21_inf0;
    p22_inf=p22_inf0;
    T1=T10;
    T2=T20;
elseif x1==0 % the whole pool is under backwater
    p11_inf=p11_infm;
    p12_inf=p12_infm;
    p21_inf=p21_infm;
    p22_inf=p22_infm;
    T1=T1m;
    T2=T2m;
else % part of the pool is under backwater
    p11_inf=p11_inf0-p12_inf0*p21_inf0/(p11_infm+p22_inf0);
    p12_inf=p12_inf0*p12_infm/(p11_infm+p22_inf0);
    p21_inf=p21_infm*p21_inf0/(p11_infm+p22_inf0);
    p22_inf=p22_infm-p12_infm*p21_infm/(p11_infm+p22_inf0);
    T1=T10+T1m;
    T2=T20+T2m;
    % group delay due to interconnection
    A=Aum*Ad0/(Aum+Ad0);
    p=p11_infm+p22_inf0;
    T1=T1+A*p; 
    T2=T2+A*p;
end

if T1<0
    T1=0;
end

T1=T1+Ad*p21_inf;
T2=T2+Au*p12_inf;

p_inf=[p11_inf,p12_inf,p21_inf,p22_inf];

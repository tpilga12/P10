function [tau1,tau2,r1,r2]=delay_nonuniform(x,alpha,beta,gamma,delta)

% function [tau1,tau2,r1,r2]=delay_nonuniform(x,alpha,beta,gamma,delta)
%
% computes the delays and the high frequency attenuation 
% for the linearized Saint-Venant equation around non uniform flow
%
% XL 09/01/2002, 18/01/2008 and 14/01/2009

%---------------------------------
g=9.81;

f1=1./alpha;
f2=1./beta;

nx=length(x);
dalphadx=(alpha(2:nx)-alpha(1:nx-1))./(x(2:nx)-x(1:nx-1));dalphadx(nx)=dalphadx(nx-1);
dbetadx=(beta(2:nx)-beta(1:nx-1))./(x(2:nx)-x(1:nx-1));dbetadx(nx)=dbetadx(nx-1);

fr1=(alpha.*delta-gamma-alpha.*dbetadx)./alpha./(alpha+beta);
fr2=(beta.*delta+gamma+dalphadx.*beta)./beta./(alpha+beta);

% Computation of the delays and attenuation using trapezoidal numerical 
% integration method
tau1=trapz(x,f1); 
tau2=trapz(x,f2); 

r1=trapz(x,fr1); 
r2=trapz(x,fr2); 

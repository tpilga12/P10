function dydx=backwater(x,y,options,K,Sb,B,m,Q);
%
% function dydx=backwater(x,y,options,K,Sb,B,m,Q);
%
% Computes the right hand term of the backwater curve equation
% for a prismatic trapezoidal canal of bottom slope Sb, 
% Strickler coefficient K, bottom width B, side slope m and discharge Q
%
% options is needed to prevent a warning from Matlab
% dans c:/MatlabR12/toolbox/matlab/funfun/private/odearguments
%
% Xavier Litrico 02/05/2001

g=9.81;
%Computation of the hydraulic variables of the section
T=B+2*m*y;
A=y*(B+m*y);
P=B+2*sqrt(1+m*m)*y;
R=A/P;
% square of the Froude number
Fr2=Q^2*T/(g*A^3);
% friction slope
Sf=Q^2/(K^2*A^2*R^(4/3));
% right hand term
dydx=(Sb-Sf)/(1-Fr2);
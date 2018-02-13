function [Phi11,Phi12,Phi21,Phi22]=transition(x0,x,a1,b1,a2,b2,s)

% function [Phi11,Phi12,Phi21,Phi22]=transition(x0,x,a1,b1,a2,b2,s)
% 
% Calcul de la matrice de transition pour LSWE
% les coef a1, a2, b1, b2 sont donnés par:
% a1=(alpha-beta)/(alpha*beta)
% b1=gamma/(alpha*beta)
% a2=-1/(alpha*beta)
% b2=-delta/(alpha*beta)
%
% XL Berkeley, février 2008

% initialisation
Phi=[1 0;0 1];
n0=find(x==x0);
Phi11(n0)=Phi(1,1);
Phi12(n0)=Phi(1,2);
Phi21(n0)=Phi(2,1);
Phi22(n0)=Phi(2,2);    
x1=a1*s+b1;
x2=a2*s+b2;

for kx=n0+1:length(x)
    % on calcule pour chaque pas d'espace dx la solution en supposant que la matrice Xi est constante entre x et x+dx
    % calcul de la solution par diagonalisation
    dx=x(kx)-x(kx-1);%pas d'espace courant
    alphaa=0.5*x1(kx);
    betaa=0.5*sqrt(x1(kx)^2-4*s*x2(kx));
    land1=alphaa-betaa;
    land2=alphaa+betaa;            
    deltaa=-2*betaa;
    phi11=(land1*exp(land1*dx)-land2*exp(land2*dx))/deltaa;
    phi12=x2(kx)*(exp(land1*dx)-exp(land2*dx))/deltaa;
    phi21=s*(exp(land2*dx)-exp(land1*dx))/deltaa;
    phi22=(land1*exp(land2*dx)-land2*exp(land1*dx))/deltaa;
    % concaténation des matrices de transfert
    Phi=[phi11 phi12;phi21 phi22]*Phi;
    Phi11(kx)=Phi(1,1);
    Phi12(kx)=Phi(1,2);
    Phi21(kx)=Phi(2,1);
    Phi22(kx)=Phi(2,2);    
end
Phi11=Phi11(:);
Phi12=Phi12(:);
Phi21=Phi21(:);
Phi22=Phi22(:);
function z = ynormal(y,K,I,B,m,Q)

% Calcul du tirant d'eau normal yn pour un canal trapezoidal

A=y*(B+m*y);
L=B+2*m*y;
P=B+2*sqrt(1+m*m)*y;
R=A/P;

z = A^3*R^2-(Q/K/sqrt(I))^3;


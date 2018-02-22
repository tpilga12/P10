function f=Fun3_312ndDer(x)
L=3; E=70E9; I=52.9E-6;w=15E3;
f=w/(120*L*E*I)*(6*L^3-42*L^2*x+60*L*x^2-20*x^3);
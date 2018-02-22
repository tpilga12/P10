function f=Fun3_31Der(x)
L=3; E=70E9; I=52.9E-6;w=15E3;
f=w/(120*L*E*I)*(6*L^3*x-21*L^2*x^2+20*L*x^3-5*x^4);
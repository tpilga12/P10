clc
clear all

d=0.9;
I_e = 0.00214;
k=0.0015;

hej_qf = -3.02*log(10e-6/(d*sqrt(d*I_e))+k/(3.71/d))*d^2*sqrt(d*I_e) %Palle
hej_qf2 = 72*(d/4)^(0.635)*pi*(d/2)^(2)*I_e^0.5; % Henning h?jsp?nding
speed2 = hej_qf2/(pi*(d/2)^2);

%%
mel=k/(3.71/d)
mel2=k/(3.71/d)*d^2*sqrt(d*I_e)
mel3=log(10e-6/(d*sqrt(d*I_e))+k/(3.71/d)*d^2*sqrt(d*I_e))

clc
clear all
V = 10;
A= 5; % max height = 2;
Q_in = 0.285;

OD = 0:1:100
b0=0;b1=0.002825;
x = linspace(0,100,100);
y = b0+b1*x;
% plot(x,y)
ConvOD = b0+b1*OD;%

Dt = 20;
rho = 1000;
g = 9.82;
h = 0;
old_hn = 0;
for n = 2:30
    OD = 1;
    Q_out(n) = abs((b0+b1*OD)*sqrt(rho*g*h(n-1)))
    %Q_out = 0.1+n/100;
    h_dot = (1/A)*(Q_in - Q_out(n))*Dt;
    h(n) = h(n-1)+h_dot;
    
end
plot(h)
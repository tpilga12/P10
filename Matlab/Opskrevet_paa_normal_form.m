clear all, clc,


Theta = 1;
m=1;
Dt = 3; %[s] grid time
Dx = 8; %[m] grid distance
d = 0.6; %[m] Diameter.
dd= d;
g = 9.81; %[m/s^2]
n=150; % Number of iterations, 
% Friction part 
Ie = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
Ib = 0.00214;
h=0.3; % arbejds punkt
Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ie^0.5;% Hennings

%%% 
a = (1/(2*Dt))*(2*sqrt(-h^2+(h*d)))-Theta/(Dx)*(-1/2*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d)*Qf);
b = (1/(2*Dt))*(2*sqrt(-h^2+(h*d)))+Theta/(Dx)*(-1/2*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d)*Qf);
c = (-1/(2*Dt))*(2*sqrt(-h^2+(h*d)))-(1-Theta)/(Dx)*(-1/2*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d)*Qf);
d = (-1/(2*Dt))*(2*sqrt(-h^2+(h*d)))+(1-Theta)/(Dx)*(-1/2*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d)*Qf);

F = [ a b 0 0 0 0 0 0 0 0; 
      0 a b 0 0 0 0 0 0 0;
      0 0 a b 0 0 0 0 0 0;
      0 0 0 a b 0 0 0 0 0;
      0 0 0 0 a b 0 0 0 0;
      0 0 0 0 0 a b 0 0 0;
      0 0 0 0 0 0 a b 0 0;
      0 0 0 0 0 0 0 a b 0;
      0 0 0 0 0 0 0 0 a b;
      0 0 0 0 0 0 0 0 0 a];
Finv = inv(F);
 
A = [ d 0 0 0 0 0 0 0 0 0;
      c d 0 0 0 0 0 0 0 0;
      0 c d 0 0 0 0 0 0 0;
      0 0 c d 0 0 0 0 0 0;
      0 0 0 c d 0 0 0 0 0;
      0 0 0 0 c d 0 0 0 0;
      0 0 0 0 0 c d 0 0 0;
      0 0 0 0 0 0 c d 0 0;
      0 0 0 0 0 0 0 c d 0;
      0 0 0 0 0 0 0 0 c d];
A = Finv*A;
B = Finv*[c*-(-1/2*pi/dd*sin(pi*h/dd)-0.04*2*pi/dd*sin(2*pi*h/dd)*Qf) 0 0 0 0 0 0 0 0 0]';
C = [0 0 0 0 0 0 0 0 0 1];
D = 0;

Sys = ss(A,B,C,D)

t = 1:Dt:3600;
X0(1:10) =0;
d1= sin(-0.01:1.1112e-04:0.01);
u(1:length(t))= 0.1186;
[Y t1 x1]=lsim(Sys,u,t,X0);
figure(2)
plot(t,Y)

Q_out = (0.46 - 0.5 *cos(pi*(x1(end,end)/dd))+0.04*cos(2*pi*(x1(end,end)/dd)))*Qf

%% Sewer model

d = 0.5;
Ie = 100; 
Theta = 0.5;
Dt = 1;
Dx = 1;
Q1 = 20;
h1 = 0.25;
A1 = d^2/4 * acos(((d/2)-h1/(d/2)))-sqrt(h1*(d-h1))*((d/2)-h1); 

H = (2*(1-Theta)*Q1-2*(1-Theta)*Q1+2*Theta*Q1+2*Theta*Q1)*Dt/Dx - A1+A1+A1;





% function f=V1stDer(h)%V
% f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie^0.5*(0.46-0.5*cos(pi*h/d)+0.04*cos(2*pi*h/d))*Dt/Dx-1/(2*Theta)*(h*2*sqrt(-h^2+h*d)-H);
% function f=Fun3_32rdDer(h)%Vdot
% f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie^0.5*(0.5*pi*sin(pi*h/d)-0.08*pi*sin(2*pi*h/d))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));

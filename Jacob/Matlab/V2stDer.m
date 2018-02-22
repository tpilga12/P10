function f=V2stDer(h)%Vdot
d = 0.5;
Ie = 0.01; 
Theta = 0.5;
Dt = 10;
Dx = 20;
Q1 = 0.03;
h1 = 0.25;
A1 = d^2/4 * acos(((d/2)-h1/(d/2)))-sqrt(h*(d-h1))*((d/2)-h1); 
H = (2*(1-Theta)*Q1-2*(1-Theta)*Q1+2*Theta*Q1+2*Theta*Q1)*Dt/Dx - A1+A1+A1;



f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie^0.5*(0.5*pi*sin(pi*h/d)-0.08*pi*sin(2*pi*h/d))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
end
 %clear all, clc,


Theta = 0.65;
Dt =20; %[s] grid time
Dx = 8; %[m] grid distance
d = 0.6; %[m] Diameter.
dd= d;
g = 9.81; %[m/s^2]
% Friction part 
Ie = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
h=0.3; % arbejds punkt
Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ie^0.5;% Hennings fyldsning flow

%%% 
a = ((1/(2*Dt))*(2*abs(sqrt(-h^2+(h*d))))) - ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
b = ((1/(2*Dt))*(2*abs(sqrt(-h^2+(h*d))))) + ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
c = ((1/(2*Dt))*(2*abs(sqrt(-h^2+(h*d))))) + (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
d = ((1/(2*Dt))*(2*abs(sqrt(-h^2+(h*d))))) - (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));

F = [ b 0 0 0 0 0 0 0 0 0; 
      a b 0 0 0 0 0 0 0 0;
      0 a b 0 0 0 0 0 0 0;
      0 0 a b 0 0 0 0 0 0;
      0 0 0 a b 0 0 0 0 0;
      0 0 0 0 a b 0 0 0 0;
      0 0 0 0 0 a b 0 0 0;
      0 0 0 0 0 0 a b 0 0;
      0 0 0 0 0 0 0 a b 0;
      0 0 0 0 0 0 0 0 a b];
Finv = -inv(F);
 
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
B = Finv*[c 0 0 0 0 0 0 0 0 0;
          -a 0 0 0 0 0 0 0 0 0]';
C = [0 0 0 0 0 0 0 0 0 1];
D = 0;

Sys = ss(A,B,C,D,0)

h_data_hat=data{1,1}.h(:,1)-data{1,1}.h(1,1);% Data fra den non linear
t = (1:900).*Dt;
h_input(1:length(t))=h_data_hat ;%Input height
Q_input= ((0.46 - 0.5 *cos(pi*(h_input)/dd)+0.04*cos(2*pi*(h_input)/dd)))*Qf;% calc for input flow
h_input2(1:length(t)) = 0; % Input height, test for at sætte a = 0

X0(1:10) =0;

u=[h_input; h_input2];
[Y_hat t1 x1]=lsim(Sys,u,t);


figure(2)
plot(t,Y_hat)

end_height = x1(end,end);
Q_out = (0.46 - 0.5 *cos(pi*(x1(end,end)/dd))+0.04*cos(2*pi*(x1(end,end)/dd)))*Qf;

h_bar = data{1,1}.h(1,1); % Sæt små signaler
Y_bar =h_bar;
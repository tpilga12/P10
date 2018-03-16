clc
clear all

n = 25; %antal rør dele
h_init = 0.2; % initial vand højde i hele røret
k = 0.001; % sandruhed(mm) skal angives i m i formel (overflade friktion i rør)
d = 0.6; % rør diameter
Ie_f = 0.0274; % vandspejlets hældning (samme som rørets hældning for fyldt rør)

Qf = -3.02*log(10e-6/(d*sqrt(d*Ie_f))+k/(3.71/d))*d^2*sqrt(d*Ie_f); %Palle
% Qf = 72*(d/4)^(0.635)*pi*(d/2)^(2)*Ie_f^0.5; % Henning højspænding

Q_init(1:n,1) = (0.46-0.5*cos(pi*h_init/d)+0.04*cos(2*pi*h_init*d))*Qf;
A_init(1:n,1) = d^2/4*acos((d/2-h_init)/d/2)-sqrt(h_init*(d-h_init))*(d/2-h_init);


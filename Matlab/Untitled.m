clc
clear all

n = 25; %antal r�r dele
h_init = 0.2; % initial vand h�jde i hele r�ret
k = 0.001; % sandruhed(mm) skal angives i m i formel (overflade friktion i r�r)
d = 0.6; % r�r diameter
Ie_f = 0.0274; % vandspejlets h�ldning (samme som r�rets h�ldning for fyldt r�r)

Qf = -3.02*log(10e-6/(d*sqrt(d*Ie_f))+k/(3.71/d))*d^2*sqrt(d*Ie_f); %Palle
% Qf = 72*(d/4)^(0.635)*pi*(d/2)^(2)*Ie_f^0.5; % Henning h�jsp�nding

Q_init(1:n,1) = (0.46-0.5*cos(pi*h_init/d)+0.04*cos(2*pi*h_init*d))*Qf;
A_init(1:n,1) = d^2/4*acos((d/2-h_init)/d/2)-sqrt(h_init*(d-h_init))*(d/2-h_init);


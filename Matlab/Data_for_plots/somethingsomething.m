clc
clear all

syms d h Ie

A = d^2/4 * acos(((d/2)-h)/(d/2)) - sqrt(h*(d-h))*(d/2 - h);
diff_Ah = diff(A,h);
A_sem = sqrt(h*(d-h))*(d/2 - h);
diff_sem_Ah = diff(A_sem,h);
Qf = -72 * (d/4)^(2/3)* pi*(d/2)^2 * Ie^(0.5);
Q = (0.46 - 0.5*cos(pi*h/d)+ 0.04 * cos(2*pi*h/d));%*Qf;

diff_Qh = diff(Q,h);

d= 0.6;
Dt = 20;
m = 1;
for h = 0.01:0.0001:d-0.01
test(m) = (h*(d - h))^(1/2) + d/(2*(1 - (4*(d/2 - h)^2)/d^2)^(1/2)) - ((d - 2*h)*(d/2 - h))/(2*(h*(d - h))^(1/2));
test2(m) = ((d - 2*h)*(d/2 - h))/(2*(h*(d - h))^(1/2)) - (h*(d - h))^(1/2);
test3(m)= (1/(2*Dt)*(2*sqrt(-h^2+(h*d))));
test4(m)= (2*sqrt(-h^2+(h*d)));
m = m+1;
end

tests = [test' test2' test3' test4'];
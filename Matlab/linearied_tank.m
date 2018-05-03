%% Linearized tank

% dh/dt = 1/A * (Qin - u*Qpump)
% Qpump kan være = med Qf for det efterfølgende rør
% u er styringssignalet
% Qin er det der kommer fra røret før.
% h = f(Qin)
% A er arealet af tanken

Area = 250;
Qpump = 0.2825;

A = [1/Area];
B = [1/Area*Qpump];
C = [1];
D = 0;

sys = ss(A,B,C,D);



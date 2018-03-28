function P=washoff(u)

global kw nr_ex_H2O;

%number of pollutants
number=nr_ex_H2O;

%ackumulated amount
Pavt=u(2:number+1);
%Rain
R=u(1);


% kw is the washoff constant, a higher value gives quicker washoff, 
% is set in file constants.m

Pavtplusett=Pavt*exp(-kw*R);
deltaP=Pavt-Pavtplusett;

P(1)=u(1);
P(2:number+1)=deltaP;
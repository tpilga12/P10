function L=ackumulation(u)

global ka nr_ex_H2O;

% number of pollutants
number=nr_ex_H2O;
%The incoming vector has 3*number elements and must be split into three vectors
% of equal length


%Deposition rate
C=u(1:number);
%Amount that is washed off
deltaP=u(number+1:2*number);
%previous value L(t-1)
Lavtminusett=u(2*number+1:3*number);


deltaL=max(zeros(number,1),C-ka*Lavtminusett);
Lavt=Lavtminusett+deltaL-deltaP;

L=Lavt;
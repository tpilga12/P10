%File cso2.m 
%This function calculates the cso volume
%Stefan Ahlman
%2003-01-22
%[sewer, storm]

function [] = cso2(x,y)

sumall=x+y;
sizex=size(sumall);
limit=0.19; %cso limit

if sumall(1)>limit %first timestep, check if flow is larger than cso limit
    A=sumall(1)-limit; %calculate CSO volume
    D=A*x(1)/sumall(1); %calculate sani WW volume of CSO volume (assumption: totally mixed)
else
    A=0;
    D=0;
end

for i=2:sizex %for each timestep
    if sumall(i)>limit %check if flow is larger than cso limit
        B=sumall(i)-limit; %calculate CSO volume
        E=B*x(i)/sumall(i); %calculate sani WW volume of CSO volume (assumption: totally mixed)
    else
        B=0;
        E=0;
    end
    A=[A;B]; %build vector after each timestep
    D=[D;E];
end
disp('CSO volume [m3]')
C=sum(A)*900
disp('Sani WW volume of CSO volume [m3]')
F=sum(D)*900
disp('Total volume to CSO [m3]')
sum(sumall)*900

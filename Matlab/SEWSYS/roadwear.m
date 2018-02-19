function u=roadwear(x)

roadkm=67e9;
andt=0.1;
andpt=1/3;
fast=0.5;


%x=total road material lost yearly in Sweden[tons]
x=x*1000;
%tons->kilograms

%u(1)= road wear[kg/km] for heavy traffic
u(1)=x*andpt/(andt*roadkm);
%u(2)=  road wear[kg/km] for light traffic
u(2)=x*(1-andpt)/(roadkm*(1-andt));
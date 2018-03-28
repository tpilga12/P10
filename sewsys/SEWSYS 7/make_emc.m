%Stefan Ahlman
%2004-10-26
%File: make_emc.m
%This file calculates the EMC for all the rain events in the storm1-matrix
%syntax: [sumps,sumws,emc]=make_emc(storm1);

function [sumps,sumws,emc] = make_emc(x) %output EMC in matrix emc
%function [sumps] = make_emc(x) %the event loads
%function [sumws] = make_emc(x) %the event volumes

global sec_per_ts %time step size used in SEWSYS
s=size(x);
n=s(1); %rows
m=s(2); %columns (=21)

sump=zeros(1,20); %sum of pollution load
sumw=0; %sum of volume
sumps=zeros(1,20); %event pollution loads
sumws=0; %event volumes
j=0;
time=0; %counting elapsed time
intertime=4*3600; %time in seconds between rain events (default 4 hours) *****CHANGE HERE*****

for i=1:n %number of rows
    if x(i,2)==0
        j=j+1;
        time=j*sec_per_ts;
    elseif x(i,2)~=0 & time>intertime & sump(1,1)>0 %first rain event
        j=0;
        time=0;
        sumps=[sumps;sump];
        sumws=[sumws;sumw];
        sump=0;
        sumw=0;
        sump=sump+x(i,2:21);
        sumw=sumw+x(i,1);
    elseif x(i,2)~=0 & time>intertime %next rain event
        j=0;
        time=0;
        sump=sump+x(i,2:21);
        sumw=sumw+x(i,1);
    elseif x(i,2)~=0 & time<=intertime %same rain event
        j=0;
        time=0;
        sump=sump+x(i,2:21);
        sumw=sumw+x(i,1);
    end
    if i==n & x(i,2)~=0 %last row (if value should be included)
        j=0;
        time=0;
        sumps=[sumps;sump];
        sumws=[sumws;sumw];
    elseif i==n & x(i,2)==0 %last row (if value is zero)
        j=0;
        time=0;
        sumps=[sumps;sump];
        sumws=[sumws;sumw];
    end
end

ss=size(sumps);
ns=ss(1); %rows
sumps=sumps(2:ns,:);
sumws=sumws(2:ns);
sumws=[sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws,sumws];
emc=sumps./sumws;
sumws=sumws(:,1);
disp('Number of rain events:')
ns-1

figure
w_size=[ 0 30 1024 670 ]; %to define window size
set(gcf,'position',w_size)

SUBPLOT(2,2,1)
hist(emc(:,1))
title('Phosphorus', 'fontsize', 14)
ylabel('Number', 'fontsize', 12)
xlabel('Concentration [mg/L]', 'fontsize', 12)
%xlim([0 0.25])

SUBPLOT(2,2,2)
hist(emc(:,2))
title('Nitrogen', 'fontsize', 14)
ylabel('Number', 'fontsize', 12)
xlabel('Concentration [mg/L]', 'fontsize', 12)

SUBPLOT(2,2,3)
hist(emc(:,11))
title('Copper', 'fontsize', 14)
ylabel('Number', 'fontsize', 12)
xlabel('Concentration [mg/L]', 'fontsize', 12)

SUBPLOT(2,2,4)
hist(emc(:,12))
title('Zinc', 'fontsize', 14)
ylabel('Number', 'fontsize', 12)
xlabel('Concentration [mg/L]', 'fontsize', 12)

text1=num2str(ns-1);
fil=sprintf('%s %s %s %s %s %s %s','EMC Distribution','N=', text1);
set(gcf,'numbertitle','off')
set(gcf,'name',fil)

open emc 
open sumps
open sumws